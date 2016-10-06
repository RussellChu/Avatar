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
				if (_inst.onCreate())
				{
					createReady();
				}
			}, 1);
		}
		
		public function createReady():void
		{
			this._inst.signal.dispatch(null, JSignal.EVENT_ON_CREATE);
		}
	
	}
}