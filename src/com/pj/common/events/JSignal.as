package com.pj.common.events
{
	import com.pj.common.IDisposable;
	import com.pj.common.IResetable;
	import com.pj.common.events.JSignal;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class JSignal implements IDisposable, IResetable
	{
		private var _funcList:Vector.<Function> = null;
		
		public function JSignal()
		{
			this.reset();
		}
		
		public function dispose():void
		{
			;
		}
		
		public function reset():void
		{
			this._funcList = new Vector.<Function>();
		}
		
		public function add(p_func:Function):Boolean
		{
			if (!(p_func))
			{
				return false;
			}
			if (p_func.length != 1)
			{
				return false;
			}
			this._funcList.push(p_func);
			return true;
		}
		
		public function dispatch(p_data:Object):void
		{
			for (var i:int = 0; i < this._funcList.length; i++)
			{
				var func:Function = this._funcList[i];
				func(p_data);
			}
		}
	
	}
}