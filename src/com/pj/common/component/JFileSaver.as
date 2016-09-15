package com.pj.common.component
{
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.net.FileReferenceList;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class JFileSaver
	{
		private var _fileReference:FileReference = null;
		private var _list:Array = null;
		
		public function JFileSaver()
		{
			this._fileReference = new FileReference();
			this._fileReference.addEventListener(Event.COMPLETE, this.onComplete);
			this._list = [];
		}
		
		public function add(p_path:String, p_data:ByteArray):void
		{
			this._list.push({path: p_path, data: p_data});
		}
		
		public function save():void
		{
			if (this._list.length == 0)
			{
				return;
			}
			
			var item:Object = this._list.shift();
			var path:String = item.path;
			var data:ByteArray = item.data;
			trace("save " + path);
			this._fileReference.save(data, path);
		}
		
		private function onComplete(p_evt:Event):void
		{
			this.save();
		}
	
	}
}