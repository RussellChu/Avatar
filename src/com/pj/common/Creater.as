package com.pj.common
{
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class Creater implements IDisposable
	{
		private var _inst:ICreatable = null;
		private var _timeId:uint = 0;
		
		public function Creater(p_inst:ICreatable)
		{
			this._inst = p_inst;
		}
		
		public function dispose():void
		{
			if (this._timeId > 0)
			{
				clearTimeout(this._timeId);
				this._timeId = 0;
			}
			this._inst = null;
		}
		
		public function create():void
		{
			this._timeId = setTimeout(function():void
			{
				_timeId = 0;
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