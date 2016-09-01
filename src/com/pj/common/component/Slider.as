package com.pj.common.component
{
	import com.pj.common.Helper;
	import com.pj.common.component.BasicObject;
	import com.pj.common.component.DragableContainer;
	import com.pj.common.component.IContainer;
	import com.pj.common.component.Quad;
	import com.pj.common.events.JComponentEvent;
	import com.pj.common.events.JEvent;
	import com.pj.common.math.Vector2D;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class Slider extends BasicObject implements IContainer
	{
		private static const WHEEL_STEP:int = 10; // 10 * 3(3:system setting) = 30
		
		private static const CTRL_BAR_COLOR:uint = 0xffc8c8c8;
		private static const CTRL_BG_COLOR:uint = 0xfff0f0f0;
		private static const CTRL_WIDTH:int = 15;
		
		private var _ctrlX:SliderCtrlX = null;
		private var _ctrlY:SliderCtrlY = null;
		private var _content:DragableContainer = null;
		
		private var _contentMoveXMax:int = 0;
		private var _contentMoveYMax:int = 0;
		private var _ctrlMoveXMax:int = 0;
		private var _ctrlMoveYMax:int = 0;
		
		public function Slider(p_parent:IContainer, p_borderWidth:int = 0, p_borderHeight:int = 0, p_contentWidth:int = 0, p_contentHeight:int = 0):void
		{
			super(null, p_parent);
			var borderWidth:int = p_borderWidth;
			var borderHeight:int = p_borderHeight;
			var contentWidth:int = p_contentWidth;
			var contentHeight:int = p_contentHeight;
			if (borderWidth < CTRL_WIDTH)
			{
				borderWidth = CTRL_WIDTH;
			}
			if (borderHeight < 0)
			{
				borderHeight = 0;
			}
			if (contentWidth < 0)
			{
				contentWidth = 0;
			}
			if (contentHeight < 0)
			{
				contentHeight = 0;
			}
			this._content = new DragableContainer(null, borderWidth - CTRL_WIDTH, borderHeight - CTRL_WIDTH, contentWidth, contentHeight);
			this._content.setWheel(0, WHEEL_STEP);
			this._content.addEventListener(JComponentEvent.DRAGABLE_EVENT, this.onSlide);
			this.container.addChild(this._content.instance);
			
			var ratioX:Number = 1;
			if (contentWidth > 0)
			{
				ratioX = borderWidth / contentWidth;
			}
			if (ratioX > 1)
			{
				ratioX = 1;
			}
			var ctrlWidthX:int = borderWidth - CTRL_WIDTH;
			this._contentMoveXMax = contentWidth - borderWidth;
			this._ctrlMoveXMax = ctrlWidthX * (1 - ratioX);
			var ctrlBgX:Quad = new Quad(ctrlWidthX, CTRL_WIDTH, CTRL_BG_COLOR);
			var ctrlBarX:Quad = new Quad(ctrlWidthX * ratioX, CTRL_WIDTH, CTRL_BAR_COLOR);
			this._ctrlX = new SliderCtrlX(null, ctrlBgX, ctrlBarX);
			this._ctrlX.setWheelStep(WHEEL_STEP);
			this._ctrlX.instance.y = borderHeight - CTRL_WIDTH;
			this._ctrlX.addEventListener(JComponentEvent.DRAGABLE_EVENT, this.onSlideCtrlX);
			this.container.addChild(this._ctrlX.instance);
			
			var ratioY:Number = 1;
			if (contentHeight > 0)
			{
				ratioY = borderHeight / contentHeight;
			}
			if (ratioY > 1)
			{
				ratioY = 1;
			}
			var ctrlWidthY:int = borderHeight - CTRL_WIDTH;
			this._contentMoveYMax = contentHeight - borderHeight;
			this._ctrlMoveYMax = ctrlWidthY * (1 - ratioY);
			var ctrlBgY:Quad = new Quad(CTRL_WIDTH, ctrlWidthY, CTRL_BG_COLOR);
			var ctrlBarY:Quad = new Quad(CTRL_WIDTH, ctrlWidthY * ratioY, CTRL_BAR_COLOR);
			this._ctrlY = new SliderCtrlY(null, ctrlBgY, ctrlBarY);
			this._ctrlY.setWheelStep(WHEEL_STEP);
			this._ctrlY.instance.x = borderWidth - CTRL_WIDTH;
			this._ctrlY.addEventListener(JComponentEvent.DRAGABLE_EVENT, this.onSlideCtrlY);
			this.container.addChild(this._ctrlY.instance);
			
		}
		
		override public function dispose():void
		{
			Helper.dispose(this._content);
			Helper.dispose(this._ctrlX);
			Helper.dispose(this._ctrlY);
			this._content = null;
			this._ctrlX = null;
			this._ctrlY = null;
			super.dispose();
		}
		
		public function addChild(p_child:BasicObject):BasicObject
		{
			this._content.addChild(p_child);
			return p_child;
		}
		
		private function get container():Sprite
		{
			return this.instance as Sprite;
		}
		
		private function onSlide(p_evt:JEvent):void
		{
			var pos:Vector2D = p_evt.data.pos as Vector2D;
			var posX:int = -pos.x;
			if (this._contentMoveXMax > 0)
			{
				this._ctrlX.slideTo(posX * this._ctrlMoveXMax / this._contentMoveXMax, true);
			}
			var posY:int = -pos.y;
			if (this._contentMoveYMax > 0)
			{
				this._ctrlY.slideTo(posY * this._ctrlMoveYMax / this._contentMoveYMax, true);
			}
		}
		
		private function onSlideCtrlX(p_evt:JEvent):void
		{
			var pos:Vector2D = p_evt.data.pos as Vector2D;
			var posX:int = -pos.x;
			if (this._ctrlMoveXMax > 0)
			{
				this._content.slideToX(posX * this._contentMoveXMax / this._ctrlMoveXMax, true);
			}
		}
		
		private function onSlideCtrlY(p_evt:JEvent):void
		{
			var pos:Vector2D = p_evt.data.pos as Vector2D;
			var posY:int = -pos.y;
			if (this._ctrlMoveYMax > 0)
			{
				this._content.slideToY(posY * this._contentMoveYMax / this._ctrlMoveYMax, true);
			}
		}
		
		public function set active(p_value:Boolean):void
		{
			this._content.active = p_value;
			this._ctrlX.active = p_value;
			this._ctrlY.active = p_value;
		}
	
	}
}

import com.pj.common.Helper;
import com.pj.common.component.BasicObject;
import com.pj.common.component.DragableObject;
import com.pj.common.component.IContainer;
import com.pj.common.component.IMoveHandler;
import com.pj.common.events.JComponentEvent;
import com.pj.common.events.JEvent;
import com.pj.common.math.Vector2D;
import flash.display.Sprite;
import flash.events.MouseEvent;


class SliderCtrl extends BasicObject implements IMoveHandler
{
	protected var _active:Boolean = false;
	protected var _barWidth:int = 0;
	protected var _barHeight:int = 0;
	protected var _bgWidth:int = 0;
	protected var _bgHeight:int = 0;
	protected var _ctrlBar:BasicObject = null;
	protected var _ctrlBg:BasicObject = null;
	protected var _dragable:DragableObject = null;
	private var _wheelStepX:int = 0;
	private var _wheelStepY:int = 0;
	
	public function SliderCtrl(p_parent:IContainer, p_ctrlBg:BasicObject, p_ctrlBar:BasicObject):void
	{
		this._ctrlBar = p_ctrlBar;
		this._ctrlBg = p_ctrlBg;
		super(null, p_parent);
	}
	
	override public function dispose():void
	{
		if (this._ctrlBg)
		{
			this._ctrlBg.instance.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
			this._ctrlBg.instance.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
		}
		if (this._ctrlBar)
		{
			this._ctrlBar.instance.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
		}
		Helper.dispose(this._ctrlBar);
		Helper.dispose(this._ctrlBg);
		Helper.dispose(this._dragable);
		this._ctrlBar = null;
		this._ctrlBg = null;
		this._dragable = null;
	}
	
	override protected function init():void
	{
		if (!this._ctrlBg || !this._ctrlBar)
		{
			throw new Error();
		}
		
		this._ctrlBg.instance.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
		this._ctrlBg.instance.addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
		this._ctrlBar.instance.addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
		
		this.container.addChild(this._ctrlBg.instance);
		this.container.addChild(this._ctrlBar.instance);
		
		this._dragable = new DragableObject(this._ctrlBar, this, false);
	}
	
	override public function reset():void
	{
		this._active = true;
		this._ctrlBar.reset();
		this._ctrlBg.reset();
		this._dragable.reset();
		this._wheelStepX = 0;
		this._wheelStepY = 0;
	}
	
	public function checkMove(p_from:Vector2D, p_to:Vector2D):Vector2D
	{
		return p_from.clone();
	}
	
	private function get container():Sprite
	{
		return this.instance as Sprite;
	}
	
	public function onMoveComplete(p_to:Vector2D):void
	{
		var evt:JEvent = new JEvent(JComponentEvent.DRAGABLE_EVENT, {pos: p_to});
		this.dispatchEvent(evt);
	}
	
	private function onMouseDown(p_evt:MouseEvent):void
	{
		if (!this._active)
		{
			return;
		}
		this._dragable.slideTo(this._ctrlBg.instance.mouseX - this._barWidth * 0.5, this._ctrlBg.instance.mouseY - this._barHeight * 0.5);
	}
	
	private function onMouseWheel(p_evt:MouseEvent):void
	{
		if (!this._active)
		{
			return;
		}
		this._dragable.slide(-this._wheelStepX * p_evt.delta, -this._wheelStepY * p_evt.delta);
	}
	
	public function set active(p_value:Boolean):void
	{
		this._active = p_value;
	}
	
	protected function setWheelStepFinal(p_x:int, p_y:int):void
	{
		this._wheelStepX = p_x;
		if (this._wheelStepX < 0)
		{
			this._wheelStepX = 0;
		}
		this._wheelStepY = p_y;
		if (this._wheelStepY < 0)
		{
			this._wheelStepY = 0;
		}
	}
	
	public function setWheelStep(p_value:int):void {
		;
	}
	
	public function slideTo(p_pos:int, p_isUpdate:Boolean = false):void {
		;
	}

}

class SliderCtrlX extends SliderCtrl implements IMoveHandler
{
	public function SliderCtrlX(p_parent:IContainer, p_ctrlBg:BasicObject, p_ctrlBar:BasicObject):void
	{
		super(p_parent, p_ctrlBg, p_ctrlBar);
	}
	
	override protected function init():void
	{
		super.init();
		
		this._bgWidth = this._ctrlBg.instance.width;
		this._barWidth = this._ctrlBar.instance.width;
		if (this._barWidth > this._bgWidth)
		{
			this._barWidth = this._bgWidth;
		}
	}
	
	override public function checkMove(p_from:Vector2D, p_to:Vector2D):Vector2D
	{
		if (!this._active)
		{
			return p_from.clone();
		}
		
		var result:Vector2D = p_to.clone();
		if (result.x > this._bgWidth - this._barWidth)
		{
			result.x = this._bgWidth - this._barWidth;
		}
		result.y = p_from.y;
		if (result.x < 0)
		{
			result.x = 0;
		}
		return result;
	}
	
	override public function setWheelStep(p_value:int):void
	{
		this.setWheelStepFinal(p_value, 0);
	}
	
	override public function slideTo(p_pos:int, p_isUpdate:Boolean = false):void
	{
		this._dragable.slideToX(p_pos, p_isUpdate);
	}

}

class SliderCtrlY extends SliderCtrl implements IMoveHandler
{
	public function SliderCtrlY(p_parent:IContainer, p_ctrlBg:BasicObject, p_ctrlBar:BasicObject):void
	{
		super(p_parent, p_ctrlBg, p_ctrlBar);
	}
	
	override protected function init():void
	{
		super.init();
		
		this._bgHeight = this._ctrlBg.instance.height;
		this._barHeight = this._ctrlBar.instance.height;
		if (this._barHeight > this._bgHeight)
		{
			this._barHeight = this._bgHeight;
		}
	}
	
	override public function checkMove(p_from:Vector2D, p_to:Vector2D):Vector2D
	{
		if (!this._active)
		{
			return p_from.clone();
		}
		
		var result:Vector2D = p_to.clone();
		if (result.y > this._bgHeight - this._barHeight)
		{
			result.y = this._bgHeight - this._barHeight;
		}
		result.x = p_from.x;
		if (result.y < 0)
		{
			result.y = 0;
		}
		return result;
	}
	
	override public function setWheelStep(p_value:int):void
	{
		this.setWheelStepFinal(0, p_value);
	}
	
	override public function slideTo(p_pos:int, p_isUpdate:Boolean = false):void
	{
		this._dragable.slideToY(p_pos, p_isUpdate);
	}

}