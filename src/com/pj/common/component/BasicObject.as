package com.pj.common.component
{
	import com.pj.common.Helper;
	import com.pj.common.IDisposable;
	import com.pj.common.IResetable;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class BasicObject extends EventDispatcher implements IDisposable, IResetable
	{
		private var _instance:DisplayObject = null;
		
		public function BasicObject(p_inst:DisplayObject = null, p_parent:IContainer = null):void
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
			this.reset();
		}
		
		public function dispose():void
		{
			Helper.dispose(this._instance);
			this._instance = null;
		}
		
		protected function init():void
		{
			;
		}
		
		public function reset():void
		{
			;
		}
		
		public function get instance():DisplayObject
		{
			return this._instance;
		}
	
	}
}