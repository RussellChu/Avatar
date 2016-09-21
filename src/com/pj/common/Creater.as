package com.pj.common
{
	import flash.utils.setTimeout;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class Creater
	{
		private var _inst:ICreatable = null;
		
		public function Creater(p_inst:ICreatable)
		{
			this._inst = p_inst;
		}
		
		public function create():void
		{
			setTimeout(function():void
			{
				_inst.onCreate();
				_inst.signal.dispatch(null, JSignal.EVENT_ON_CREATE);
			}, 1);
		}
	}
}