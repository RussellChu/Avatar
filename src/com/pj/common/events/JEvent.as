package com.pj.common.events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class JEvent extends Event
	{
		private var _data:Object = null;
		
		public function JEvent(p_type:String, p_data:Object)
		{
			super(p_type);
			this._data = p_data;
		}
		
		public function get data():Object
		{
			return this._data;
		}
	
	}
}