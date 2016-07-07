package com.pj.common.component
{
	import com.pj.common.Helper;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class BasicContainer extends BasicObject implements IContainer
	{
		protected var _child:Vector.<BasicObject> = null;
		
		public function BasicContainer(p_parent:BasicContainer, p_inst:Sprite = null):void
		{
			super(p_inst, p_parent);
			this._child = new Vector.<BasicObject>();
		}
		
		override public function dispose():void
		{
			Helper.dispose(this._child);
			this._child = null;
			super.dispose();
		}
		
		protected function get container():Sprite
		{
			return this.instance as Sprite;
		}
		
		public function addChild(p_child:BasicObject):BasicObject
		{
			this._child.push(p_child);
			this.container.addChild(p_child.instance);
			return p_child;
		}
	
	}
}