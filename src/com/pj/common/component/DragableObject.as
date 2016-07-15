package com.pj.common.component
{
	import com.pj.common.Helper;
	import com.pj.common.IDisposable;
	import com.pj.common.component.BasicObject;
	import com.pj.common.component.IMoveHandler;
	import com.pj.common.events.JComponentEvent;
	import com.pj.common.math.Vector2D;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class DragableObject implements IDisposable
	{
		private var _moveChecker:IMoveHandler = null;
		private var _state:int = 0;
		private var _startX:int = 0;
		private var _startY:int = 0;
		private var _target:BasicObject = null;
		private var _wheelX:int = 0;
		private var _wheelY:int = 0;
		
		public function DragableObject(p_target:BasicObject, p_moveChecker:IMoveHandler = null):void
		{
			this._moveChecker = p_moveChecker;
			this._target = p_target;
			this._target.instance.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
			this._target.instance.addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
			this._target.instance.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
			this._target.instance.addEventListener(MouseEvent.RELEASE_OUTSIDE, this.onMouseUp);
			this._target.instance.addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
		}
		
		public function dispose():void
		{
			if (this._target)
			{
				this._target.instance.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
				this._target.instance.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
				this._target.instance.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
				this._target.instance.removeEventListener(MouseEvent.ROLL_OUT, this.onMouseUp);
				this._target.instance.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
			}
			Helper.dispose(this._target);
			this._moveChecker = null;
			this._target = null;
		}
		
		public function setWheel(p_mX:int, p_mY:int):void
		{
			this._wheelX = p_mX;
			this._wheelY = p_mY;
		}
		
		private function slide(p_mX:int, p_mY:int):void
		{
			trace( "slide >> " + p_mY );
			var fromVtr:Vector2D = new Vector2D(this._target.instance.x, this._target.instance.y);
			var toVtr:Vector2D = new Vector2D(this._target.instance.x + p_mX, this._target.instance.y + p_mY);
			var resultVtr:Vector2D = toVtr;
			if (this._moveChecker)
			{
				resultVtr = this._moveChecker.checkMove(fromVtr, toVtr);
			}
			if (fromVtr.x == resultVtr.x && fromVtr.y == resultVtr.y) {
				return;
			}
			this._target.instance.x = resultVtr.x;
			this._target.instance.y = resultVtr.y;
			this._moveChecker.onMoveComplete(resultVtr);
		}
		
		private function onMouseDown(p_evt:MouseEvent):void
		{
			this._startX = p_evt.localX;
			this._startY = p_evt.localY;
			this._state = 1;
			trace("A");
		}
		
		private function onMouseMove(p_evt:MouseEvent):void
		{
			if (this._state == 0)
			{
				return;
			}
			
			this.slide(p_evt.localX - this._startX, p_evt.localY - this._startY);
		}
		
		private function onMouseUp(p_evt:MouseEvent):void
		{
			this._state = 0;
		}
		
		private function onMouseWheel(p_evt:MouseEvent):void
		{
			this.slide(this._wheelX * p_evt.delta, this._wheelY * p_evt.delta);
		}
	
	}
}