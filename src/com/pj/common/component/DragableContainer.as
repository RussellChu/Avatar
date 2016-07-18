package com.pj.common.component
{
	import com.pj.common.Helper;
	import com.pj.common.component.BasicContainer;
	import com.pj.common.component.BasicObject;
	import com.pj.common.component.IContainer;
	import com.pj.common.component.IMoveHandler;
	import com.pj.common.events.JComponentEvent;
	import com.pj.common.events.JEvent;
	import com.pj.common.math.Vector2D;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class DragableContainer extends BasicObject implements IContainer, IMoveHandler
	{
		private var _active:Boolean = false;
		private var _borderWidth:int = 0;
		private var _borderHeight:int = 0;
		private var _contentWidth:int = 0;
		private var _contentHeight:int = 0;
		private var _content:BasicContainer = null;
		private var _dragable:DragableObject = null;
		
		public function DragableContainer(p_parent:IContainer, p_borderWidth:int = 0, p_borderHeight:int = 0, p_contentWidth:int = 0, p_contentHeight:int = 0):void
		{
			super(null, p_parent);
			this._content = new BasicContainer();
			this._dragable = new DragableObject(this._content, this);
			this.container.addChild(this._content.instance);
			this._borderWidth = p_borderWidth;
			this._borderHeight = p_borderHeight;
			this._contentWidth = p_contentWidth;
			this._contentHeight = p_contentHeight;
			
			var maskShape:Shape = new Shape();
			maskShape.graphics.beginFill(0xFFFFFF, 1);
			maskShape.graphics.drawRect(0, 0, this._borderWidth, this._borderHeight);
			maskShape.graphics.endFill();
			this.container.addChild(maskShape);
			this.container.mask = maskShape;
			
			this._active = true;
		}
		
		override public function dispose():void
		{
			Helper.dispose(this._content);
			Helper.dispose(this._dragable);
			this._content = null;
			this._dragable = null;
		}
		
		public function addChild(p_child:BasicObject):BasicObject
		{
			this._content.addChild(p_child);
			return p_child;
		}
		
		public function checkMove(p_from:Vector2D, p_to:Vector2D):Vector2D
		{
			if (!this._active) {
				return p_from.clone();
			}
			
			var result:Vector2D = p_to.clone();
			if (result.x < this._borderWidth - this._contentWidth)
			{
				result.x = this._borderWidth - this._contentWidth;
			}
			if (result.y < this._borderHeight - this._contentHeight)
			{
				result.y = this._borderHeight - this._contentHeight;
			}
			if (result.x > 0)
			{
				result.x = 0;
			}
			if (result.y > 0)
			{
				result.y = 0;
			}
			return result;
		}
		
		private function get container():Sprite
		{
			return this.instance as Sprite;
		}
		
		public function onMoveComplete(p_to:Vector2D):void
		{
			var evt:JEvent = new JEvent(JComponentEvent.DRAGABLE_SLIDE, {pos: p_to});
			this.dispatchEvent(evt);
		}
	
		public function set active(p_value:Boolean):void{
			this._active = p_value;
		}
		
		public function setWheel(p_mX:int, p_mY:int):void
		{
			this._dragable.setWheel(p_mX, p_mY);
		}
		
		public function slideTo(p_posX:int, p_posY:int, p_isUpdate:Boolean = false):void
		{
			this._dragable.slideTo(p_posX, p_posY, p_isUpdate);
		}
	
	}
}