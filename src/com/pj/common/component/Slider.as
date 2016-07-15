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
		
		private var _ctrl:SliderCtrl = null;
		private var _content:DragableContainer = null;
		
		private var _contentMoveMax:int = 0;
		private var _ctrlMoveMax:int = 0;
		
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
			this._content = new DragableContainer(null, borderWidth - CTRL_WIDTH, borderHeight, contentWidth, contentHeight);
			this._content.setWheel(0, WHEEL_STEP);
			this._content.addEventListener(JComponentEvent.DRAGABLE_SLIDE, this.onSlide);
			this.container.addChild(this._content.instance);
			
			var ratio:Number = 1;
			if (contentHeight > 0)
			{
				ratio = borderHeight / contentHeight;
			}
			if (ratio > 1)
			{
				ratio = 1;
			}
			var ctrlBg:Quad = new Quad(CTRL_WIDTH, borderHeight, CTRL_BG_COLOR);
			var ctrlBar:Quad = new Quad(CTRL_WIDTH, borderHeight * ratio, CTRL_BAR_COLOR);
			this._ctrl = new SliderCtrl(null, ctrlBg, ctrlBar);
			this._ctrl.setWheelStep(WHEEL_STEP);
			this._ctrl.instance.x = borderWidth - CTRL_WIDTH;
			this._ctrl.addEventListener(JComponentEvent.DRAGABLE_SLIDE, this.onSlideCtrl);
			this.container.addChild(this._ctrl.instance);
			
			this._contentMoveMax = contentHeight - borderHeight;
			this._ctrlMoveMax = borderHeight * (1 - ratio);
		}
		
		override public function dispose():void
		{
			Helper.dispose(this._content);
			Helper.dispose(this._ctrl);
			this._content = null;
			this._ctrl = null;
			super.dispose();
		}
		
		private function get container():Sprite
		{
			return this.instance as Sprite;
		}
		
		public function addChild(p_child:BasicObject):BasicObject
		{
			this._content.addChild(p_child);
			return p_child;
		}
		
		private function onSlide(p_evt:JEvent):void
		{
			var pos:Vector2D = p_evt.data.pos as Vector2D;
			var posY:int = -pos.y;
			if (this._contentMoveMax > 0)
			{
				this._ctrl.slideTo(0, posY * this._ctrlMoveMax / this._contentMoveMax, true);
			}
		}
		
		private function onSlideCtrl(p_evt:JEvent):void
		{
			var pos:Vector2D = p_evt.data.pos as Vector2D;
			var posY:int = -pos.y;
			if (this._ctrlMoveMax > 0)
			{
				this._content.slideTo(this._content.instance.x, posY * this._contentMoveMax / this._ctrlMoveMax, true);
			}
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
	private var _barHeight:int = 0;
	private var _bgHeight:int = 0;
	private var _ctrlBar:BasicObject = null;
	private var _ctrlBg:BasicObject = null;
	private var _dragable:DragableObject = null;
	private var _wheelStep:int = 0;
	
	public function SliderCtrl(p_parent:IContainer, p_ctrlBg:BasicObject, p_ctrlBar:BasicObject):void
	{
		super(null, p_parent);
		
		this._bgHeight = p_ctrlBg.instance.height;
		this._barHeight = p_ctrlBar.instance.height;
		if (this._barHeight > this._bgHeight)
		{
			this._barHeight = this._bgHeight;
		}
		
		this._ctrlBar = p_ctrlBar;
		this._ctrlBg = p_ctrlBg;
		
		this._ctrlBg.instance.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
		this._ctrlBg.instance.addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
		
		this.container.addChild(this._ctrlBg.instance);
		this.container.addChild(this._ctrlBar.instance);
		
		this._dragable = new DragableObject(this._ctrlBar, this, false);
	}
	
	override public function dispose():void
	{
		Helper.dispose(this._ctrlBar);
		Helper.dispose(this._ctrlBg);
		Helper.dispose(this._dragable);
		this._ctrlBar = null;
		this._ctrlBg = null;
		this._dragable = null;
	}
	
	private function get container():Sprite
	{
		return this.instance as Sprite;
	}
	
	public function checkMove(p_from:Vector2D, p_to:Vector2D):Vector2D
	{
		var result:Vector2D = p_to.clone();
		if (result.y > this._bgHeight - this._barHeight)
		{
			result.y = this._bgHeight - this._barHeight;
		}
		result.x = 0;
		if (result.y < 0)
		{
			result.y = 0;
		}
		return result;
	}
	
	public function onMoveComplete(p_to:Vector2D):void
	{
		var evt:JEvent = new JEvent(JComponentEvent.DRAGABLE_SLIDE, {pos: p_to});
		this.dispatchEvent(evt);
	}
	
	public function setWheelStep(p_value:int):void{
		this._wheelStep = p_value;
		if (this._wheelStep < 0){
			this._wheelStep = 0;
		}
	}
	
	public function slideTo(p_posX:int, p_posY:int, p_isUpdate:Boolean = false):void
	{
		this._dragable.slideTo(p_posX, p_posY, p_isUpdate);
	}
	
	private function onMouseDown(p_evt:MouseEvent):void
	{
		this._dragable.slideTo(this._ctrlBg.instance.mouseX, this._ctrlBg.instance.mouseY - this._barHeight * 0.5);
	}
	
	private function onMouseWheel(p_evt:MouseEvent):void{
		this._dragable.slide(0, -this._wheelStep * p_evt.delta);
	}

}