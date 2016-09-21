package com.pj.common
{
	import com.pj.common.Helper;
	import com.pj.common.IDisposable;
	import com.pj.common.JSignal;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Russell
	 */
	
	public class AssetLoader implements IDisposable
	{
		static private const TYPE_URL:int = 0;
		static private const TYPE_CREATE:int = 1;
		static private const TYPE_OBJECT:int = 2;
		
		private var _assetMap:Object = null;
		private var _currCreate:ICreatable = null;
		private var _currKey:String = "";
		private var _currPath:String = "";
		private var _failList:Array = null;
		private var _loader:Loader = null;
		private var _registerList:Array = null;
		private var _registerMap:Object = null;
		private var _signal:JSignal = null;
		
		public function AssetLoader():void
		{
			this._assetMap = {};
			this._failList = [];
			this._registerList = [];
			this._registerMap = {};
			this._signal = new JSignal();
		}
		
		public function dispose():void
		{
			Helper.dispose(this._signal);
			if (this._loader)
			{
				this._loader.unloadAndStop();
			}
			this._assetMap = null;
			this._currCreate = null;
			this._failList = null;
			this._loader = null;
			this._registerList = null;
			this._registerMap = null;
			this._signal = null;
		}
		
		public function add(p_key:String, p_path:String):Boolean
		{
			if (this._registerMap[p_key])
			{
				return false;
			}
			
			this._registerMap[p_key] = true;
			this._registerList.push({key: p_key, type: TYPE_URL, path: p_path});
			
			return true;
		}
		
		public function addCreate(p_key:String, p_create:ICreatable):Boolean
		{
			if (this._registerMap[p_key])
			{
				return false;
			}
			
			this._registerMap[p_key] = true;
			this._registerList.push({key: p_key, type: TYPE_CREATE, create: p_create});
			
			return true;
		}
		
		public function addObject(p_key:String, p_obj:DisplayObject):Boolean
		{
			if (this._registerMap[p_key])
			{
				return false;
			}
			
			this._registerMap[p_key] = true;
			this._assetMap[p_key] = p_obj;
			
			return true;
		}
		
		public function getAsset(p_key:String):DisplayObject
		{
			return this._assetMap[p_key] as DisplayObject;
		}
		
		public function load():void
		{
			var isLoad:Boolean = false;
			while (!isLoad)
			{
				if (this._registerList.length == 0)
				{
					this._signal.dispatch({failList: this._failList});
					return;
				}
				
				var item:Object = this._registerList.shift();
				var type:int = item.type;
				this._currKey = item.key;
				switch (type)
				{
				case TYPE_URL: 
					isLoad = true;
					this._currPath = item.path;
					this._loader = new Loader();
					this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoad);
					this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
					this._loader.load(new URLRequest(this._currPath));
					break;
				case TYPE_CREATE: 
					isLoad = true;
					this._currCreate = item.create;
					this._currCreate.signal.add(this.onLoadCreate, JSignal.EVENT_ON_CREATE);
					this._currCreate.creater.create();
					break;
				default:
					
				}
			}
		}
		
		private function onLoad(p_evt:Event):void
		{
			this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onLoad);
			this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onError);
			var assets:DisplayObject = this._loader.content as DisplayObject;
			this._assetMap[this._currKey] = assets;
			this._currKey = "";
			this._loader = null;
			this.load();
		}
		
		private function onError(p_evt:Event):void
		{
			this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onLoad);
			this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onError);
			this._failList.push({key: this._currKey, path: this._currPath});
			this.load();
		}
		
		private function onLoadCreate(p_result:Object):void
		{
			this._currCreate.signal.remove(this.onLoadCreate, JSignal.EVENT_ON_CREATE);
			this._assetMap[this._currKey] = this._currCreate;
			this._currKey = "";
			this._currCreate = null;
			this.load();
		}
		
		public function get signal():JSignal
		{
			return this._signal;
		}
	
	}
}