package com.pj.common
{
	
	/**
	 * ...
	 * @author Russell
	 */
	public class JTweener implements IDisposable
	{
		private var _func:Function = null;
		private var _onComplete:Function = null;
		private var _time:Number = 0;
		private var _timeMax:Number = 0;
		private var _timer:JTimer = null;
		
		public function JTweener(p_time:Number, p_func:Function, p_onComplete:Function)
		{
			this._timeMax = p_time;
			this._func = p_func;
			this._onComplete = p_onComplete;
			this._timer = new JTimer(this.onTime);
		}
		
		public function dispose():void
		{
			Helper.dispose(this._timer);
			this._func = null;
			this._onComplete = null;
			this._timer = null;
		}
		
		private function onTime(p_delta:Number):void
		{
			this._time += p_delta;
			if (this._time < this._timeMax)
			{
				this._func(this._time);
				return;
			}
			
			this._timer.stop();
			this._onComplete();
		}
		
		public function run():void
		{
			if (this._timer.state())
			{
				return;
			}
			this._timer.start();
		}
	
	}
}