const contentTypes = require('./utils/content-types');
const env = process.env;
const express = require('express');
const fs = require('fs');
const http = require('http');
const path = require('path');
const sysInfo = require('./utils/sys-info');

var validator = (function () {
	var inst = {};
	
	var check = function ( obj, arr ) {
		if ( !obj || !( typeof obj === 'object' ) || !arr || !( arr instanceof Array ) ) {
			return false;
		}
		for(var i = 0; i < arr.length; i++) {
			var item = arr[i];
			if ( !item.hasOwnProperty( 'name' ) || typeof item.name !== 'string' ) {
				return false;
			}
			
			if ( !obj.hasOwnProperty( item.name ) ) {
				return false;
			}
			
			if ( !item.hasOwnProperty( 'type' ) || typeof item.type !== 'string' ) {
				continue;
			}
			
			if ( typeof obj[item.name] !== item.type ) {
				return false;
			}
		}
		return true;
	};
	
	inst.check = check;
	
	return inst;
} ());

var eventDispatcher = (function () {
	var inst = {};
	var map = {};
	var dispose = function () {
		inst = null;
		map = null;
	};
	var add = function ( action, listener ) {
		if ( !map || typeof action !== 'string' || action === '' || typeof listener !== 'function' ) {
			return;
		}
		if ( !map[action] ) {
			map[action] = [];
		}
		
		map[action].push( listener );
	};
	var remove = function ( action, listener ) {
		if ( !map ) {
			return;
		}
		if ( typeof action !== 'string' || action === '' ) {
			map = {};
			return;
		}
		if ( !map[action] ) {
			return;
		}
		if ( typeof listener !== 'function' ) {
			map[action] = [];
			return;
		}
		var i = 0;
		var list = map[action];
		for(i = 0; i < list.length; i++) {
			if ( list[i] === listener ) {
				list.splice( i, 1 );
				return;
			}
		}
	};
	var dispatch = function ( action, data ) {
		if ( !map || typeof action !== 'string' || action === '' || !map[action] ) {
			return;
		}
		var i = 0;
		var list = map[action];
		for(i = 0; i < list.length; i++) {
			var listener = list[i];
			listener( data );
		}
	};
	inst.dispose = dispose;
	inst.add = add;
	inst.dispatch = dispatch;
	inst.remove = remove;
	return inst;
} ());

var fileCacher = ( function () {
	var inst = {};
	
	var cache_max = 10;
	var cache_list = [];
	var cache_map = {};
	
	var init = function ( p_cache_max ) {
		cache_max = p_cache_max;
	};
	
	var clear = function () {
		for(var key in cache_map) {
			delete cache_map[key];
		}
		
		cache_list = [];
		cache_map = {};
	};
	
	var getFile = function ( path, forceReload, callback ) {
		if ( typeof callback !== 'function' ) {
			return;
		}
		
		if ( typeof path !== 'string' || !path ) {
			callback( { msg: 'Invalid Path' }, null );
			return;
		}
		
		if ( cache_map.hasOwnProperty( path ) && !forceReload ) {
			console.log( '[fileCacher] Use >> ' + path );
			callback( null, cache_map[path] );
			return;
		}
		
		fs.readFile( path, function(err, data) {
			if (err) {
				callback( err, data );
				return;
			}
			
			if ( cache_list.length >= cache_max ) {
				var remove_path = cache_list.splice( 0, 1 )[0];
				delete cache_map[remove_path];
				console.log( '[fileCacher] Remove >> ' + remove_path );
			}
			
			cache_list.push( path );
			cache_map[path] = data;
			
			callback( err, data );
		});
	};
	
	inst.init = init;
	inst.clear = clear;
	inst.getFile = getFile;
	
	return inst;
} ());

const MasterEvent = {
	  CACHE_GET: 'CACHE_GET'
	, CACHE_SET: 'CACHE_SET'
	, CACHE_UPDATE: 'CACHE_UPDATE'
	, CLEAR_CHILD_CACHE: 'CLEAR_CHILD_CACHE'
	, CLEAR_MASTER_CACHE: 'CLEAR_MASTER_CACHE'
	, MESSAGE: 'MESSAGE'
};

var app = ( function () {
	var inst = {};
	
	let server = express();
	
	var cacheData = {};
	
	var actAPI = function ( query, res ) {
		if ( !validator.check( query, [
			{ name: 'act', type: 'string' }
		] ) ) {
			res.writeHead(404);
			res.end( 'Not found' );
			console.log( 'actAPI fail' );
			return;
		}
		
		var action = query.act;
		switch ( action ) {
		case 'assets_group_name_list':
			var map = {};
			if ( cacheData.hasOwnProperty( 'assets_group_name' ) ) {
				map = cacheData.assets_group_name;
			}
			res.setHeader('Content-Type', 'application/json');
			res.setHeader('Cache-Control', 'no-cache, no-store');
			res.end( JSON.stringify( map ) );
			return;
		case 'assets_group_name_update':
			if ( !validator.check( query, [
				{ name: 'name', type: 'string' },
				{ name: 'value', type: 'string' }
			] ) ) {
				res.writeHead(404);
				res.end( 'act fail: ' + action );
				console.log( 'actAPI fail: ' + action );
				return;
			}
			
			var name = query.name;
			var value = query.value;
			
			var map = {};
			if ( cacheData.hasOwnProperty( 'assets_group_name' ) ) {
				map = cacheData.assets_group_name;
			}
			
			var isUpdateCache = false;
			
			if ( !map.hasOwnProperty( name ) ) {
				isUpdateCache = true;
				map[name] = { value: name, lock: 5 };
			}
			
			if ( map[name].lock > 0 && map[name].value !== value ) {
				isUpdateCache = true;
				map[name].value = value;
				map[name].lock--;
			}
			
			res.writeHead(200);
			
			if ( isUpdateCache ) {
				cacheData.assets_group_name = map;
				eventDispatcher.dispatch( MasterEvent.CACHE_UPDATE, { name: 'assets_group_name', method: 'property', key: name, value: map[name] } );
				eventDispatcher.dispatch( MasterEvent.CACHE_UPDATE, { name: 'assets_group_update', method: 'push', value: { name: name, value: map[name].value } } );
				res.end( 'update success: assets_group_name [' + name +  '] ( lock: ' + map[name].lock + ' ) as ' + map[name].value );
			} else {
				res.end( 'update rejected: assets_group_name [' + name +  '] ( lock: ' + map[name].lock + ' ) as ' + map[name].value );
			}
			
			return;
		case 'cache':
			res.setHeader('Content-Type', 'application/json');
			res.setHeader('Cache-Control', 'no-cache, no-store');
			res.end(JSON.stringify(cacheData));
			return;
		}
		
		res.writeHead(404);
		res.end( 'Not found: ' + action );
	};
	
	var sendFile = function ( url, res, forceReload ) {
		var urlFinal = './static' + url;
		fileCacher.getFile( urlFinal, forceReload, function(err, data) {
			if (err) {
				res.writeHead(404);
				res.end( 'Not found: ' + url );
				console.log( 'sendFile fail >> ' + urlFinal );
			} else {
				let ext = path.extname(url).slice(1);
				switch ( ext ) {
				case 'swf':
					res.setHeader('Content-Type', 'application/x-shockwave-flash');
					break;
				default:
					if (contentTypes[ext]) {
						res.setHeader('Content-Type', contentTypes[ext]);
					}
				}

				if (ext === 'html') {
					res.setHeader('Cache-Control', 'no-cache, no-store');
				} else {
					res.setHeader('Cache-Control', 'max-age=604800, public');
				}
				res.end(data);
				console.log( 'sendFile ok >> ' + urlFinal );
			}
		});
	};
	
	server.get('/*', function (req, res) {
		let url = req.path;
		
		console.log( 'Get: ' + url + ': ' + JSON.stringify( req.query ) );
		
		// IMPORTANT: Your application HAS to respond to GET /health with status 200
		//			for OpenShift health monitoring

		switch ( url ) {
		case '/api':
			actAPI( req.query, res );
			break;
		case '/health':
			res.writeHead(200);
			res.end();
			break;
		case '/info/gen':
		case '/info/poll':
			res.setHeader('Content-Type', 'application/json');
			res.setHeader('Cache-Control', 'no-cache, no-store');
			res.end(JSON.stringify(sysInfo[url.slice(6)]()));
			break;
		case '/clear':
			eventDispatcher.dispatch( MasterEvent.CLEAR_CHILD_CACHE );
			res.writeHead(200);
			res.end();
			break;
		case '/cron':
			res.writeHead(200);
			res.end();
			break;
		case '/':
		case '/avatar':
			eventDispatcher.dispatch( MasterEvent.CACHE_UPDATE, { name: 'visit', value: 1, method: 'add' } );
			sendFile( '/avatar.html', res, false );
			break;
		default:
			sendFile( url, res, false );
		}
	});
	
	var onCacheGet = function ( data ) {
		if ( !validator.check( data, [
			{ name: 'name', type: 'string' }
		] ) ) {
			return;
		}
		
		process.send( { action: 'get', name: data.name } );
	};
	
	var onCacheSet = function ( data ) {
		if ( !validator.check( data, [
			{ name: 'name', type: 'string' },
			{ name: 'value' }
		] ) ) {
			return;
		}
		
		process.send( { action: 'set', name: data.name, value: data.value } );
	};
	
	var onCacheUpdate = function ( data ) {
		if ( !validator.check( data, [
			{ name: 'name', type: 'string' },
			{ name: 'method', type: 'string' },
			{ name: 'value' }
		] ) ) {
			console.log( 'onCacheUpdate fail' );
			return;
		}
		
		data.action = 'update';
		
		process.send( data );
	};
	
	var onClearChildCache = function ( data ) {
		process.send( { action: 'clear_child', } );
	};
	
	var onClearMasterCache = function ( data ) {
		process.send( { action: 'clear' } );
	};
	
	var onMessage = function ( value ) {
		process.send( { action: 'message', value: '' + value } );
	};

	var start = function () {
		
		eventDispatcher.add( MasterEvent.CACHE_GET, onCacheGet );
		eventDispatcher.add( MasterEvent.CACHE_SET, onCacheSet );
		eventDispatcher.add( MasterEvent.CACHE_UPDATE, onCacheUpdate );
		eventDispatcher.add( MasterEvent.CLEAR_CHILD_CACHE, onClearChildCache );
		eventDispatcher.add( MasterEvent.CLEAR_MASTER_CACHE, onClearMasterCache );
		eventDispatcher.add( MasterEvent.MESSAGE, onMessage );
		
		server.listen(env.NODE_PORT || 3000, env.NODE_IP || 'localhost', function () {
			process.on( 'message', function( data ) {
				var action = data.action;
				switch ( action ) {
				case 'clear_cache':
					fileCacher.clear();
					console.log( 'Clear cache of ' + process.pid );
					break;
				case 'update_cache':
					cacheData = data.data;
					console.log( 'Update cache of ' + process.pid + ': length >> ' + JSON.stringify( cacheData ).length );
					break;
				}
			});
			
			process.send( { action: 'init', pid: process.pid } );

			eventDispatcher.dispatch( MasterEvent.MESSAGE, 'Application worker started...' );
		});
	};
	
	fileCacher.init( 10 );
	
	inst.start = start;
	
	return inst;
} ());

app.start();