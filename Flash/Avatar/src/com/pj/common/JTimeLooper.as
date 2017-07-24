package com.pj.common 
{
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class JTimeLooper implements IDisposable
	{
		private var _from:int = 0;
		private var _to:int = 0;
		private var _i:int = 0;
		private var _timeId:uint = 0;
		private var _func:Function = null;
		private var _onComplete:Function = null;
		
		public function JTimeLooper(p_from:int, p_to:int, p_func:Function, p_onComplete:Function) 
		{
			this._from = p_from;
			this._to = p_to;
			this._func = p_func;
			this._onComplete = p_onComplete;
		}
		
		public function dispose():void
		{
			if (this._timeId > 0)
			{
				clearTimeout(this._timeId);
				this._timeId = 0;
			}
			this._func = null;
			this._onComplete = null;
		}
		
		private function loopMain():void {
			this._timeId = 0;
			var isLoop:Boolean = this._func(this._i) as Boolean;
			this._i++;
			if (this._i > this._to || !isLoop)
			{
				this._onComplete();
				return;
			}
			this._timeId = setTimeout(this.loopMain, 1);
		}
		
		public function loop():void {
			this._i = this._from;
			if (this._from > this._to)
			{
				this._onComplete();
				return;
			}
			
			this.loopMain();
		}
		
	}
}