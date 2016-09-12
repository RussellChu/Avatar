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
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
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
		private var _mask:Shape = null;
		
		public function DragableContainer(p_parent:IContainer, p_borderWidth:int = 0, p_borderHeight:int = 0, p_contentWidth:int = 0, p_contentHeight:int = 0):void
		{
			this._borderWidth = p_borderWidth;
			this._borderHeight = p_borderHeight;
			this._contentWidth = p_contentWidth;
			this._contentHeight = p_contentHeight;
			super(null, p_parent);
		}
		
		override public function dispose():void
		{
			Helper.dispose(this._content);
			Helper.dispose(this._dragable);
			this._content = null;
			this._dragable = null;
			this._mask = null;
		}
		
		override protected function init():void
		{
			super.init();
			
			this._content = new BasicContainer();
			this._dragable = new DragableObject(this._content, this);
			this.container.addChild(this._content.instance);
			
			this._mask = new Shape();
			this._mask.graphics.beginFill(0xFFFFFF, 1);
			this._mask.graphics.drawRect(0, 0, 1, 1);
			this._mask.graphics.endFill();
			this._mask.width = this._borderWidth;
			this._mask.height = this._borderHeight;
			this.container.addChild(this._mask);
			this.container.mask = this._mask;
		}
		
		override public function reset():void
		{
			super.reset();
			this._active = true;
			this._content.reset();
			this._dragable.reset();
		}
		
		public function addChild(p_child:BasicObject):BasicObject
		{
			this._content.addChild(p_child);
			return p_child;
		}
		
		public function checkMove(p_from:Vector2D, p_to:Vector2D):Vector2D
		{
			if (!this._active)
			{
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
		
		public function getCapture():BitmapData
		{
			var bmp:BitmapData = new BitmapData(this._content.instance.width, this._content.instance.height);
			bmp.draw(this._content.instance);
			return bmp;
		}
		
		public function onMoveComplete(p_to:Vector2D):void
		{
			this.signal.dispatch({pos: p_to});
		}
		
		public function resize(p_width:int, p_height:int):void
		{
			this._borderWidth = p_width;
			this._borderHeight = p_height;
			this._mask.width = this._borderWidth;
			this._mask.height = this._borderHeight;
		}
		
		public function set active(p_value:Boolean):void
		{
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
		
		public function slideToX(p_posX:int, p_isUpdate:Boolean = false):void
		{
			this._dragable.slideToX(p_posX, p_isUpdate);
		}
		
		public function slideToY(p_posY:int, p_isUpdate:Boolean = false):void
		{
			this._dragable.slideToY(p_posY, p_isUpdate);
		}
	
	}
}