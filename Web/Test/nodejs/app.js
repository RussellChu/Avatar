var express = require('express');
var app = express();

var http = require('http');
var fs = require('fs');

// bitsadmin /transfer wcb /priority high https://cn.unlight.jp/public/image/cc17_01.swf.8cf455dde4b79c49ae03de16ea22f22a D:\Download\cc17_01.swf

var TASK = {
	  NONE: 0
	, FETCH_SWF: 1
	, TEST: 2
};

var currTask = TASK.TEST;

var task_fetch_swf = function ( callback ) {
	var swfList = [];
	var swfMap = {};
	var harList = [];
	var saveFolder = 'D:\\Download\\unlight\\';
	
	var fetchSwf = function () {
		if ( harList.length == 0 ) {
			var str = "";
			for(var i = 0; i < swfList.length; i++) {
				str += 'bitsadmin /transfer wcb /priority high ' + swfList[i].url + ' ' + saveFolder + swfList[i].name + '<br/>';
			}
			console.log( 'swf found >> ' + swfList.length );
			callback( str );
			return;
		}
		
		var harName = harList.pop();
		fs.readFile('./' + harName, 'utf8', function (err, rslt) {
			if (err) {
				;
			} else {
				var data = JSON.parse(rslt);
				if ( data.hasOwnProperty( 'log' ) ) {
					data = data.log;
					if ( data.hasOwnProperty( 'entries' ) ) {
						data = data.entries;
						if ( data instanceof Array ) {
							for(var i = 0; i < data.length; i++) {
								var item = data[i];
								if ( !item.hasOwnProperty( 'request' ) )
								{
									continue;
								}
								item = item.request;
								if ( !item.hasOwnProperty( 'url' ) )
								{
									continue;
								}
								var url = item.url;
								var type = url.substr( url.length - 36, 3 );
								if ( type === 'swf' ) {
									var pos = url.lastIndexOf( '/' );
									var shortName = url.substr( pos + 1 );
									shortName = shortName.substr( 0, shortName.length - 33 );
									if ( !swfMap[shortName] ) {
										swfMap[shortName] = true;
										swfList.push( { url: url, name: shortName } );
									}
								}
							}
						}
					}
				}
				fetchSwf();
			}
		});
	};
	
	fs.readdir('./', function(err, items) {
		for (var i = 0; i < items.length; i++) {
			var type = items[i].substr( items[i].length - 3, 3 );
			if ( type === 'har' ) {
				console.log( 'har found >> ' + items[i] );
				harList.push( items[i] );
			}
		}
		fetchSwf();
	});
};

var task_test = function ( callback ) {
	
	var assetsList = [];
	var groupList = [];
	
	var analysisFile = function ( name ) {
		var rslt = {
			  pass: false
			, group: ''
			, name: name
			, order: 0
		};
		var dotPos = name.lastIndexOf( '.swf' );
		var pPos = name.lastIndexOf( '_p' );
		var checkStr = name.substr( pPos + 2, dotPos - pPos - 2 );
		if ( '' + parseInt( checkStr ) !== checkStr ) {
			return rslt;
		}
		
		rslt.pass =  true;
		rslt.group = name.substr( 0, pPos );
		rslt.name = name.substr( 0, dotPos );
		rslt.order = parseInt( checkStr );
		return rslt;
	};
	
	var onReadDirReady = function ( err, rslt ) {
		buildAssetsList( rslt );
		buildGroupList();
		var str = buildEmbedCode();
		callback( str );
	};
	
	var buildAssetsList = function ( list ) {
		for (var i = 0; i < list.length; i++) {
			var analyRslt = analysisFile( list[i] );
			if ( !analyRslt.pass ) {
				console.log( 'fail : ' + analyRslt.name );
				continue;
			}
			
			assetsList.push( analyRslt );
		}
		console.log( 'assets found : ' + assetsList.length );
	};
	
	var buildGroupList = function () {
		var groupMap = {};
		for (var i = 0; i < assetsList.length; i++) {
			var item = assetsList[i];
			var group = null;
			if ( !groupMap.hasOwnProperty( item.group ) ) {
				group = {};
				group.name = item.group;
				group.parts = [];
				groupList.push( group );
				groupMap[item.group] = group;
			} else {
				group = groupMap[item.group];
			}
			group.parts.push( item.order );
		}
		console.log( 'groups found : ' + groupList.length );
	};
	
	var buildEmbedCode = function () {
		var str = "";
		for (var i = 0; i < assetsList.length; i++) {
			var item = assetsList[i];
			str += '[Embed(source = "../../../../assets/' + item.name + '.swf")]<br/>';
			str += 'private var ' + item.name + ':Class;<br/>';
		}
		for (var i = 0; i < assetsList.length; i++) {
			var item = assetsList[i];
			str += 'this._map["' + item.name + '"] = new ' + item.name + '();<br/>';
		}
		return str;
	};
	
	fs.readdir( './assets/', onReadDirReady );
};

app.get('/', function (req, res) {
	console.log( 'Start:' );
	res.writeHeader( 200, { "Content-Type": "text/html" } );
	var callback = function ( rslt ) {
		res.write( rslt );
		res.end();
		console.log( 'End:' );
	};
	var actFunc = function ( callback ) {
		callback( 'No task called' );
	};
	switch ( currTask ) {
	case TASK.FETCH_SWF:
		actFunc = task_fetch_swf;
		break;
	case TASK.TEST:
		actFunc = task_test;
		break;
	default:
		;
	}
	actFunc( callback );
});

app.get('/avatar', function (req, res) {
	console.log( 'Start:' );
	res.writeHeader( 200, { "Content-Type": "text/html" } );
	var callback = function ( rslt ) {
		res.write( rslt );
		res.end();
		console.log( 'End:' );
	};
	
	fs.readFile('./avatar.html', function (err, data) {
		if (err) {
			throw err; 
		}
		
		callback( data );
	});
});

app.get('/assets.swf', function (req, res) {
	console.log( 'Start:' );
	res.writeHeader( 200, { "Content-Type": "application/x-shockwave-flash" } );
	var callback = function ( rslt ) {
		res.write( rslt );
		res.end();
		console.log( 'End:' );
	};
	
	fs.readFile('./assets.swf', function (err, data) {
		if (err) {
			throw err; 
		}
		
		callback( data );
	});
});

app.listen(5123, function () {
	console.log('Example app listening on port 5123!');
});
