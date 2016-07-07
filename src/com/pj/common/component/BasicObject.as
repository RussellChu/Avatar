package com.pj.common.component
{
	import com.pj.common.Helper;
	import com.pj.common.IDisposable;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class BasicObject implements com.pj.common.IDisposable
	{
		private var _instance:DisplayObject = null;
		
		public function BasicObject(p_inst:DisplayObject = null, p_parent:com.pj.common.component.IContainer = null):void
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
		}
		
		public function dispose():void
		{
			Helper.dispose(this._instance);
			this._instance = null;
		}
		
		public function get instance():DisplayObject
		{
			return this._instance;
		}
	
	}
}