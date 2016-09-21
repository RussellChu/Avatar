package com.pj.common
{
	import com.pj.common.IDisposable;
	import com.pj.common.IResetable;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class JSignal implements IDisposable, IResetable
	{
		static public const EVENT_ON_CREATE:String = "EVENT_ON_CREATE";
		
		private var _targetList:Vector.<Object> = null;
		
		public function JSignal()
		{
			this.reset();
		}
		
		public function dispose():void
		{
			this._targetList = null;
		}
		
		public function reset():void
		{
			this._targetList = new Vector.<Object>();
		}
		
		public function add(p_func:Function, p_event:String = ""):Boolean
		{
			if (!(p_func))
			{
				return false;
			}
			if (p_func.length != 1)
			{
				return false;
			}
			var item:Object = {};
			item.func = p_func;
			item.event = p_event;
			this._targetList.push(item);
			return true;
		}
		
		public function dispatch(p_data:Object, p_event:String = ""):void
		{
			for (var i:int = 0; i < this._targetList.length; i++)
			{
				var item:Object = this._targetList[i];
				var func:Function = item.func;
				var event:String = item.event;
				if (p_event == "" || event == p_event)
				{
					func(p_data);
				}
			}
		}
	
	}
}