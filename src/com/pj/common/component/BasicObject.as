package com.pj.common.component
{
	import com.pj.common.Helper;
	import com.pj.common.IDisposable;
	import com.pj.common.IHasSignal;
	import com.pj.common.IResetable;
	import com.pj.common.JSignal;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class BasicObject implements IDisposable, IHasSignal, IResetable
	{
		private var _instance:DisplayObject = null;
		protected var _signal:JSignal = null;
		
		public function BasicObject(p_inst:DisplayObject = null, p_parent:IContainer = null)
		{
			if (p_inst)
			{
				this._instance = p_inst;
			}
			else
			{
				this._instance = new Sprite() as DisplayObject;
			}
			if (p_parent)
			{
				p_parent.addChild(this);
			}
			
			this.init();
			this.clear();
			this.reset();
		}
		
		public function dispose():void
		{
			Helper.dispose(this._instance);
			Helper.dispose(this._signal);
			this._instance = null;
			this._signal = null;
		}
		
		protected function init():void
		{
			this._signal = new JSignal();
		}
		
		public function clear():void
		{
			this._signal.clear();
		}
		
		public function reset():void
		{
			this._signal.reset();
		}
		
		public function get instance():DisplayObject
		{
			return this._instance;
		}
		
		public function get signal():JSignal
		{
			return this._signal;
		}
	
	}
}