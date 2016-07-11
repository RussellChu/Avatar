package com.pj.common.component
{
	import com.pj.common.component.BasicObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class AbstractButton extends BasicObject
	{
		public function AbstractButton():void
		{
			super();
			this.container.addEventListener(MouseEvent.CLICK, this.onMouseClick);
			this.container.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
			this.container.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
			this.container.addEventListener(MouseEvent.ROLL_OUT, this.onMouseRollOut);
		}
		
		protected function get container():Sprite
		{
			return this.instance as Sprite;
		}
		
		protected function onMouseClick(p_evt:MouseEvent):void
		{
			;
		}
		
		protected function onMouseDown(p_evt:MouseEvent):void
		{
			;
		}
		
		protected function onMouseOver(p_evt:MouseEvent):void
		{
			;
		}
		
		protected function onMouseRollOut(p_evt:MouseEvent):void
		{
			;
		}
		
	}
}