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
		static public const ACTION_CLICK:String = 'click';
		static public const ACTION_DOWN:String = 'down';
		static public const ACTION_OUT:String = 'out';
		static public const ACTION_OVER:String = 'over';
		static public const ACTION_UP:String = 'up';
		
		protected var _data:Object = null;
		
		public function AbstractButton(p_data:Object = null)
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
		
		override public function clear():void
		{
			super.clear();
		}
		
		override public function reset():void
		{
			super.reset();
		}
		
		protected function get container():Sprite
		{
			return this.instance as Sprite;
		}
		
		public function get data():Object
		{
			return this._data;
		}
		
		protected function onMouseClick(p_evt:MouseEvent):void
		{
			this.signal.dispatch({action: ACTION_CLICK, data: this._data, target: this});
		}
		
		protected function onMouseDown(p_evt:MouseEvent):void
		{
			this.signal.dispatch({action: ACTION_DOWN, data: this._data, target: this});
		}
		
		protected function onMouseOver(p_evt:MouseEvent):void
		{
			this.signal.dispatch({action: ACTION_OVER, data: this._data, target: this});
		}
		
		protected function onMouseUp(p_evt:MouseEvent):void
		{
			this.signal.dispatch({action: ACTION_UP, data: this._data, target: this});
		}
		
		protected function onMouseRollOut(p_evt:MouseEvent):void
		{
			this.signal.dispatch({action: ACTION_OUT, data: this._data, target: this});
		}
	
	}
}