package com.pj.common
{
	
	/**
	 * ...
	 * @author Russell
	 */
	public class JTimer implements IDisposable
	{
		private var _dispose:Boolean = false;
		private var _func:Function = null;
		private var _id:int = 0;
		private var _run:Boolean = false;
		private var _time:Number = 0;
		
		public function JTimer(p_func:Function)
		{
			this._func = p_func;
			this._id = JTimerCtrl.add(this);
		}
		
		public function get id():int
		{
			return this._id;
		}
		
		public function dispose():void
		{
			this.stop();
			this._dispose = true;
			this._func = null;
		}
		
		public function isDisposed():Boolean
		{
			return this._dispose;
		}
		
		public function run(p_time:Number):void
		{
			if (this._func != null) {
				this._func(p_time - this._time);
			}
			this._time = p_time;
		}
		
		public function start():void
		{
			this._time = new Date().time;
			this._run = true;
		}
		
		public function state():Boolean
		{
			return this._run;
		}
		
		public function stop():void
		{
			this._run = false;
		}
	}

}

import com.pj.common.JTimer
import flash.events.TimerEvent;
import flash.utils.Timer;

class JTimerCtrl
{
	static private var __inst:JTimerCtrl = null;
	private var _list:Vector.<JTimer> = null;
	private var _timer:Timer = null;
	private var _count:int = 0;
	
	static public function add(p_timer:JTimer):int
	{
		if (!__inst)
		{
			__inst = new JTimerCtrl();
		}
		__inst._list.push(p_timer);
		return __inst._list.length;
	}
	
	public function JTimerCtrl()
	{
		this._list = new Vector.<JTimer>();
		this._timer = new Timer(20);
		this._timer.addEventListener(TimerEvent.TIMER, this.onTime);
		this._timer.start();
	}
	
	private function onTime(p_evt:TimerEvent):void
	{
		if (this._list.length == 0)
		{
			return;
		}
		
		var currTime:Number = new Date().time;
		var count:int = 0;
		var id:int = -1;
		var timer:JTimer = null;
		while (currTime == new Date().time)
		{
			timer = this._list.shift();
			if (timer.isDisposed())
			{
				if (this._list.length == 0)
				{
					return;
				}
				timer = null;
				continue;
			}
			if (id == -1)
			{
				id = timer.id;
			}
			else
			{
				if (id == timer.id)
				{
					this._list.push(timer);
					break;
				}
			}
			if (!timer.state())
			{
				this._list.push(timer);
				timer = null;
				continue;
			}
			timer.run(currTime);
			this._list.push(timer);
			count++;
		}
		//	trace(count);
	}
	
}

