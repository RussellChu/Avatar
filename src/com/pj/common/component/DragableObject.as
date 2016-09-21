package com.pj.common.component
{
	import com.pj.common.Helper;
	import com.pj.common.IDisposable;
	import com.pj.common.IResetable;
	import com.pj.common.component.BasicObject;
	import com.pj.common.component.IMoveHandler;
	import com.pj.common.math.Vector2D;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class DragableObject implements IDisposable, IResetable
	{
		private var _moveChecker:IMoveHandler = null;
		private var _state:int = 0;
		private var _startX:int = 0;
		private var _startY:int = 0;
		private var _target:BasicObject = null;
		private var _wheelX:int = 0;
		private var _wheelY:int = 0;
		
		public function DragableObject(p_target:BasicObject, p_moveChecker:IMoveHandler = null, p_isEnableWheel:Boolean = true)
		{
			this._moveChecker = p_moveChecker;
			this._target = p_target;
			this._target.instance.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
			this._target.instance.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
			this._target.instance.addEventListener(MouseEvent.RELEASE_OUTSIDE, this.onMouseUp);
			if (p_isEnableWheel)
			{
				this._target.instance.addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
			}
		}
		
		public function dispose():void
		{
			if (this._target)
			{
				this._target.instance.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
				this._target.instance.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
				this._target.instance.removeEventListener(MouseEvent.RELEASE_OUTSIDE, this.onMouseUp);
				this._target.instance.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
				this._target.instance.removeEventListener(Event.ENTER_FRAME, this.onDraggerBtnMove);
			}
			Helper.dispose(this._target);
			this._moveChecker = null;
			this._target = null;
		}
		
		public function reset():void
		{
			this._state = 0;
			this._startX = 0;
			this._startY = 0;
			this._wheelX = 0;
			this._wheelY = 0;
			this.slideTo(0, 0, true);
		}
		
		private function onDraggerBtnMove(e:Event):void
		{
			if (this._state == 0)
			{
				this._target.instance.removeEventListener(Event.ENTER_FRAME, this.onDraggerBtnMove);
				return;
			}
			
			this.slide(this._target.instance.mouseX - this._startX, this._target.instance.mouseY - this._startY);
		}
		
		public function setWheel(p_mX:int, p_mY:int):void
		{
			this._wheelX = p_mX;
			this._wheelY = p_mY;
		}
		
		public function slide(p_mX:int, p_mY:int, p_isUpdate:Boolean = false):void
		{
			if (p_mX == 0 && p_mY == 0)
			{
				return;
			}
			this.slideTo(this._target.instance.x + p_mX, this._target.instance.y + p_mY, p_isUpdate);
		}
		
		public function slideTo(p_posX:int, p_posY:int, p_isUpdate:Boolean = false):void
		{
			var fromVtr:Vector2D = new Vector2D(this._target.instance.x, this._target.instance.y);
			var toVtr:Vector2D = new Vector2D(p_posX, p_posY);
			var resultVtr:Vector2D = toVtr;
			if (this._moveChecker)
			{
				resultVtr = this._moveChecker.checkMove(fromVtr, toVtr);
			}
			if (fromVtr.x == resultVtr.x && fromVtr.y == resultVtr.y)
			{
				return;
			}
			this._target.instance.x = resultVtr.x;
			this._target.instance.y = resultVtr.y;
			if (!p_isUpdate)
			{
				this._moveChecker.onMoveComplete(resultVtr);
			}
		}
		
		public function slideToX(p_posX:int, p_isUpdate:Boolean = false):void
		{
			this.slideTo(p_posX, this._target.instance.y, p_isUpdate);
		}
		
		public function slideToY(p_posY:int, p_isUpdate:Boolean = false):void
		{
			this.slideTo(this._target.instance.x, p_posY, p_isUpdate);
		}
		
		public function startDrag():void
		{
			if (this._state == 1)
			{
				return;
			}
			
			this._startX = this._target.instance.mouseX;
			this._startY = this._target.instance.mouseY;
			this._state = 1;
			this._target.instance.addEventListener(Event.ENTER_FRAME, this.onDraggerBtnMove);
		}
		
		public function endDrag():void
		{
			this._state = 0;
		}
		
		private function onMouseDown(p_evt:MouseEvent):void
		{
			this.startDrag();
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
			this.endDrag();
		}
		
		private function onMouseWheel(p_evt:MouseEvent):void
		{
			this.slide(this._wheelX * p_evt.delta, this._wheelY * p_evt.delta);
		}
	
	}
}