package com.pj.common
{
	import com.pj.common.Helper;
	import com.pj.common.IDisposable;
	import com.pj.common.JSignal;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Russell
	 */
	
	public class AssetLoader implements IDisposable
	{
		static public const EVENT_COMPLETE:String = "EVENT_COMPLETE";
		static public const EVENT_LOADING:String = "EVENT_LOADING";
		
		static private const TYPE_URL:int = 0;
		static private const TYPE_CREATE:int = 1;
		static private const TYPE_OBJECT:int = 2;
		
		private var _assetMap:Object = null;
		private var _currCreate:ICreatable = null;
		private var _currKey:String = "";
		private var _currPath:String = "";
		private var _failList:Array = null;
		private var _groupMap:Object = null;
		private var _loader:Loader = null;
		private var _listMax:int = 0;
		private var _registerList:Array = null;
		private var _registerMap:Object = null;
		private var _sharedMap:Object = null;
		private var _signal:JSignal = null;
		
		public function AssetLoader()
		{
			this._assetMap = {};
			this._failList = [];
			this._groupMap = {};
			this._registerList = [];
			this._registerMap = {};
			this._signal = new JSignal();
			this._sharedMap = {};
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
			this._groupMap = null;
			this._loader = null;
			this._registerList = null;
			this._registerMap = null;
			this._signal = null;
			this._sharedMap = null;
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
		
		public function addImageOfGroup(p_key:String, p_clsTxt:Class, p_clsImg:Class):Boolean
		{
			if (this._registerMap[p_key])
			{
				return false;
			}
			
			this._registerMap[p_key] = true;
			
			this._groupMap[p_key] = {};
			
			var img:Bitmap = new p_clsImg() as Bitmap;
			var src:BitmapData = img.bitmapData;
			var ba:ByteArray = new p_clsTxt() as ByteArray;
			var str:String = ba.toString();
			var obj:Object = null;
			
			/*
			   //
			   {
			   "format": ["name", "x", "y", "w", "h"]
			   , "data": [
			   "cmdIdle", 0, 0, 15, 14
			   , "cmdOver", 15, 0, 15, 14
			   ]
			   }
			 */
			obj = JSON.parse(str);
			var format:Array = obj.format as Array;
			var data:Array = obj.data as Array;
			var name:String = "";
			var posX:int = 0;
			var posY:int = 0;
			var width:int = 0;
			var height:int = 0;
			for (var i:int = 0; i < data.length; i++)
			{
				var formatIdx:int = i % format.length;
				var field:String = format[formatIdx];
				switch (field)
				{
				case "name": 
					name = data[i] as String;
					break;
				case "x": 
					posX = data[i] as int;
					break;
				case "y": 
					posY = data[i] as int;
					break;
				case "w": 
					width = data[i] as int;
					break;
				case "h": 
					height = data[i] as int;
					break;
				default: 
					;
				}
				if (formatIdx + 1 == format.length)
				{
					var bmp:BitmapData = new BitmapData(width, height, true, 0);
					bmp.draw(src, new Matrix(1, 0, 0, 1, -posX, -posY));
					this._groupMap[p_key][name] = bmp;
				}
			}
			
			return true;
		}
		
		public function addObject(p_key:String, p_obj:Object):Boolean
		{
			if (this._registerMap[p_key])
			{
				return false;
			}
			
			this._registerMap[p_key] = true;
			this._assetMap[p_key] = p_obj;
			
			return true;
		}
		
		public function addShared(p_key:String, p_cls:Class, p_data:Object = null):Boolean
		{
			if (this._registerMap[p_key])
			{
				return false;
			}
			
			this._registerMap[p_key] = true;
			this._sharedMap[p_key] = {cls: p_cls, data: p_data};
			return true;
		}
		
		public function getAsset(p_key:String):Object
		{
			if (this._sharedMap[p_key])
			{
				var cls:Class = this._sharedMap[p_key].cls as Class;
				var data:Object = this._sharedMap[p_key].data;
				return new cls(data);
			}
			
			return this._assetMap[p_key];
		}
		
		public function getAssetOfGroup(p_group:String, p_name:String):Object
		{
			if (!this._groupMap[p_group])
			{
				return null;
			}
			
			return this._groupMap[p_group][p_name];
		}
		
		public function load(p_start:Boolean = true):void
		{
			//loader = new Loader();
			//loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void
			//{
			//loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this);
			//var mc:MovieClip = loader.content as MovieClip;
			//addChild(mc);
			//});
			//loader.load(new URLRequest("basket_x000a_p78.swf"));
			
			if (p_start)
			{
				this._listMax = this._registerList.length;
			}
			
			var isLoad:Boolean = false;
			while (!isLoad)
			{
				if (this._registerList.length == 0)
				{
					this._signal.dispatch({failList: this._failList}, EVENT_COMPLETE);
					return;
				}
				
				var item:Object = this._registerList.shift();
				this._signal.dispatch({index: this._registerList.length, total: this._listMax}, EVENT_LOADING);
				
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
			this.load(false);
		}
		
		private function onError(p_evt:Event):void
		{
			this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onLoad);
			this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onError);
			this._failList.push({key: this._currKey, path: this._currPath});
			this.load(false);
		}
		
		private function onLoadCreate(p_result:Object):void
		{
			this._currCreate.signal.remove(this.onLoadCreate, JSignal.EVENT_ON_CREATE);
			this._assetMap[this._currKey] = this._currCreate;
			this._currKey = "";
			this._currCreate = null;
			this.load(false);
		}
		
		public function get signal():JSignal
		{
			return this._signal;
		}
	
	}
}