package com.pj.common.component
{
	import com.pj.common.component.BasicObject;
	import com.pj.common.events.JComponentEvent;
	import com.pj.common.events.JEvent;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class AbstractButton extends BasicObject
	{
		public static const ACTION_CLICK:String = 'click';
		public static const ACTION_DOWN:String = 'down';
		public static const ACTION_OUT:String = 'out';
		public static const ACTION_OVER:String = 'over';
		public static const ACTION_UP:String = 'up';
		
		private var _data:Object = null;
		
		public function AbstractButton(p_data:Object = null):void
		{
			this._data = p_data;
			super();
		}
		
		override public function dispose():void
		{
			this._data = null;
			this.container.removeEventListener(MouseEvent.CLICK, this.onMouseClick);
			this.container.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
			this.container.removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
			this.container.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
			this.container.removeEventListener(MouseEvent.ROLL_OUT, this.onMouseRollOut);
			
			super.dispose();
		}
		
		override protected function init():void
		{
			super.init();
			this.container.addEventListener(MouseEvent.CLICK, this.onMouseClick);
			this.container.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
			this.container.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
			this.container.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
			this.container.addEventListener(MouseEvent.ROLL_OUT, this.onMouseRollOut);
		}
		
		override public function reset():void
		{
			super.reset();
		}
		
		protected function get container():Sprite
		{
			return this.instance as Sprite;
		}
		
		protected function onMouseClick(p_evt:MouseEvent):void
		{
			var evt:JEvent = new JEvent(JComponentEvent.BUTTON_EVENT, {action: ACTION_CLICK, data: this._data});
			this.dispatchEvent(evt);
		}
		
		protected function onMouseDown(p_evt:MouseEvent):void
		{
			var evt:JEvent = new JEvent(JComponentEvent.BUTTON_EVENT, {action: ACTION_DOWN, data: this._data});
			this.dispatchEvent(evt);
		}
		
		protected function onMouseOver(p_evt:MouseEvent):void
		{
			var evt:JEvent = new JEvent(JComponentEvent.BUTTON_EVENT, {action: ACTION_OVER, data: this._data});
			this.dispatchEvent(evt);
		}
		
		protected function onMouseUp(p_evt:MouseEvent):void
		{
			var evt:JEvent = new JEvent(JComponentEvent.BUTTON_EVENT, {action: ACTION_UP, data: this._data});
			this.dispatchEvent(evt);
		}
		
		protected function onMouseRollOut(p_evt:MouseEvent):void
		{
			var evt:JEvent = new JEvent(JComponentEvent.BUTTON_EVENT, {action: ACTION_OUT, data: this._data});
			this.dispatchEvent(evt);
		}
	
	}
}