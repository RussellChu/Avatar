package com.pj.common.component
{
	import com.pj.common.Helper;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class BasicContainer extends BasicObject implements IContainer
	{
		protected var _child:Vector.<BasicObject> = null;
		
		public function BasicContainer(p_parent:IContainer = null, p_inst:Sprite = null)
		{
			super(p_inst, p_parent);
		}
		
		override public function dispose():void
		{
			Helper.dispose(this._child);
			this._child = null;
			super.dispose();
		}
		
		override protected function init():void
		{
			super.init();
			this._child = new Vector.<BasicObject>();
		}
		
		override public function reset():void
		{
			super.reset();
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
		
		public function removeChildren():void
		{
			this._child = new Vector.<BasicObject>();
			this.container.removeChildren();
		}
		
		public function resize(p_width:int, p_height:int):void
		{
			;
		}
	
	}
}