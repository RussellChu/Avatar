package com.pj.common.component
{
	import com.adobe.images.PNGEncoder;
	import com.pj.common.Helper;
	import com.pj.common.component.BasicObject;
	import com.pj.common.component.DragableContainer;
	import com.pj.common.component.IContainer;
	import com.pj.common.math.Vector2D;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class Slider extends BasicObject implements IContainer
	{
		static private const WHEEL_STEP:int = 10; // 10 * 3(3:system setting) = 30
		
		static private const CTRL_BAR_COLOR:uint = 0xffc8c8c8;
		static private const CTRL_BG_COLOR:uint = 0xfff0f0f0;
		static private const CTRL_WIDTH:int = 15;
		
		private var _borderWidth:int = 0;
		private var _borderHeight:int = 0;
		private var _contentWidth:int = 0;
		private var _contentHeight:int = 0;
		
		private var _ctrlX:SliderCtrlX = null;
		private var _ctrlY:SliderCtrlY = null;
		private var _content:DragableContainer = null;
		
		private var _contentMoveXMax:int = 0;
		private var _contentMoveYMax:int = 0;
		private var _ctrlMoveXMax:int = 0;
		private var _ctrlMoveYMax:int = 0;
		private var _enableSideMoving:Boolean = false;
		
		public function Slider(p_parent:IContainer, p_borderWidth:int = 0, p_borderHeight:int = 0, p_contentWidth:int = 0, p_contentHeight:int = 0, p_enableSideMoving:Boolean = true):void
		{
			this._borderWidth = p_borderWidth;
			this._borderHeight = p_borderHeight;
			this._contentWidth = p_contentWidth;
			this._contentHeight = p_contentHeight;
			if (this._borderWidth < CTRL_WIDTH)
			{
				this._borderWidth = CTRL_WIDTH;
			}
			if (this._borderHeight < 0)
			{
				this._borderHeight = 0;
			}
			if (this._contentWidth < 0)
			{
				this._contentWidth = 0;
			}
			if (this._contentHeight < 0)
			{
				this._contentHeight = 0;
			}
			this._enableSideMoving = p_enableSideMoving;
			super(null, p_parent);
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
		
		override protected function init():void
		{
			super.init();
			
			this._content = new DragableContainer(null, this._borderWidth - CTRL_WIDTH, this._borderHeight - CTRL_WIDTH, this._contentWidth, this._contentHeight, this._enableSideMoving);
			this._content.setWheel(0, WHEEL_STEP);
			this._content.signal.add(this.onSlide);
			this.container.addChild(this._content.instance);
			
			var ratioX:Number = 1;
			if (this._contentWidth > 0)
			{
				ratioX = this._borderWidth / this._contentWidth;
			}
			if (ratioX > 1)
			{
				ratioX = 1;
			}
			var ctrlWidthX:int = this._borderWidth - CTRL_WIDTH;
			this._contentMoveXMax = this._contentWidth - this._borderWidth;
			this._ctrlMoveXMax = ctrlWidthX * (1 - ratioX);
			this._ctrlX = new SliderCtrlX(null, CTRL_WIDTH, ctrlWidthX, ratioX, CTRL_BG_COLOR, CTRL_BAR_COLOR);
			this.container.addChild(this._ctrlX.instance);
			
			this._ctrlX.setWheelStep(WHEEL_STEP);
			this._ctrlX.instance.y = this._borderHeight - CTRL_WIDTH;
			this._ctrlX.signal.add(this.onSlideCtrlX);
			
			var ratioY:Number = 1;
			if (this._contentHeight > 0)
			{
				ratioY = this._borderHeight / this._contentHeight;
			}
			if (ratioY > 1)
			{
				ratioY = 1;
			}
			var ctrlWidthY:int = this._borderHeight - CTRL_WIDTH;
			this._contentMoveYMax = this._contentHeight - this._borderHeight;
			this._ctrlMoveYMax = ctrlWidthY * (1 - ratioY);
			this._ctrlY = new SliderCtrlY(null, CTRL_WIDTH, ctrlWidthY, ratioY, CTRL_BG_COLOR, CTRL_BAR_COLOR);
			this.container.addChild(this._ctrlY.instance);
			
			this._ctrlY.setWheelStep(WHEEL_STEP);
			this._ctrlY.instance.x = this._borderWidth - CTRL_WIDTH;
			this._ctrlY.signal.add(this.onSlideCtrlY);
		}
		
		override public function reset():void
		{
			super.reset();
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
		
		public function getCapture():BitmapData
		{
			return this._content.getCapture();
		}
		
		public function saveCapture(p_path:String):void
		{
			var bmp:BitmapData = this.getCapture();
			var b:ByteArray = PNGEncoder.encode(bmp);
			var fileReference:FileReference = new FileReference();
			fileReference.save(b, p_path);
		}
		
		public function slideTo(p_x:int, p_y:int):void
		{
			this._ctrlX.slideTo(p_x, false);
			this._ctrlY.slideTo(p_y, false);
		}
		
		private function onSlide(p_result:Object):void
		{
			var pos:Vector2D = p_result.pos as Vector2D;
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
		
		private function onSlideCtrlX(p_result:Object):void
		{
			var pos:Vector2D = p_result.pos as Vector2D;
			var posX:int = -pos.x;
			if (this._ctrlMoveXMax > 0)
			{
				this._content.slideToX(posX * this._contentMoveXMax / this._ctrlMoveXMax, true);
			}
		}
		
		private function onSlideCtrlY(p_result:Object):void
		{
			var pos:Vector2D = p_result.pos as Vector2D;
			var posY:int = -pos.y;
			if (this._ctrlMoveYMax > 0)
			{
				this._content.slideToY(posY * this._contentMoveYMax / this._ctrlMoveYMax, true);
			}
		}
		
		public function resize(p_width:int, p_height:int):void
		{
			this._borderWidth = p_width;
			if (this._borderWidth < CTRL_WIDTH)
			{
				this._borderWidth = CTRL_WIDTH;
			}
			
			this._borderHeight = p_height;
			if (this._borderHeight < 0)
			{
				this._borderHeight = 0;
			}
			
			this._content.resize(this._borderWidth - CTRL_WIDTH, this._borderHeight - CTRL_WIDTH);
			
			var ratioX:Number = 1;
			if (this._contentWidth > 0)
			{
				ratioX = this._borderWidth / this._contentWidth;
			}
			if (ratioX > 1)
			{
				ratioX = 1;
			}
			var ctrlWidthX:int = this._borderWidth - CTRL_WIDTH;
			this._contentMoveXMax = this._contentWidth - this._borderWidth;
			this._ctrlMoveXMax = ctrlWidthX * (1 - ratioX);
			this._ctrlX.resize(CTRL_WIDTH, ctrlWidthX, ratioX);
			this._ctrlX.instance.y = this._borderHeight - CTRL_WIDTH;
			
			var ratioY:Number = 1;
			if (this._contentHeight > 0)
			{
				ratioY = this._borderHeight / this._contentHeight;
			}
			if (ratioY > 1)
			{
				ratioY = 1;
			}
			var ctrlWidthY:int = this._borderHeight - CTRL_WIDTH;
			this._contentMoveYMax = this._contentHeight - this._borderHeight;
			this._ctrlMoveYMax = ctrlWidthY * (1 - ratioY);
			this._ctrlY.resize(CTRL_WIDTH, ctrlWidthY, ratioY);
			this._ctrlY.instance.x = this._borderWidth - CTRL_WIDTH;
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
import com.pj.common.component.Quad;
import com.pj.common.math.Vector2D;
import flash.display.Sprite;
import flash.events.MouseEvent;

class SliderCtrl extends BasicObject implements IMoveHandler
{
	protected var _active:Boolean = false;
	protected var _colorBar:int = 0;
	protected var _colorBg:int = 0;
	protected var _heightBar:int = 0;
	protected var _heightBg:int = 0;
	protected var _width:int = 0;
	protected var _ctrlBar:BasicObject = null;
	protected var _ctrlBg:BasicObject = null;
	protected var _dragable:DragableObject = null;
	private var _wheelStepX:int = 0;
	private var _wheelStepY:int = 0;
	
	public function SliderCtrl(p_parent:IContainer, p_width:int, p_height:int, p_ratio:Number, p_colorBg:uint, p_colorBar:uint):void
	{
		this._width = p_width;
		this._heightBar = p_height * p_ratio;
		this._heightBg = p_height;
		this._colorBar = p_colorBar;
		this._colorBg = p_colorBg;
		super(null, p_parent);
	}
	
	override public function dispose():void
	{
		if (this._ctrlBg)
		{
			this._ctrlBg.instance.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
			this._ctrlBg.instance.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
			this._ctrlBg.instance.removeEventListener(MouseEvent.RELEASE_OUTSIDE, this.onMouseUp);
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
		
		super.dispose();
	}
	
	override protected function init():void
	{
		super.init();
		this.resetCtrl();
	}
	
	override public function reset():void
	{
		super.reset();
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
		this.signal.dispatch({pos: p_to});
	}
	
	private function onMouseDown(p_evt:MouseEvent):void
	{
		if (!this._active)
		{
			return;
		}
		this._dragable.slideTo(this._ctrlBg.instance.mouseX - this._heightBar * 0.5, this._ctrlBg.instance.mouseY - this._heightBar * 0.5);
		this._dragable.startDrag();
	}
	
	private function onMouseUp(p_evt:MouseEvent):void
	{
		if (!this._active)
		{
			return;
		}
		this._dragable.endDrag();
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
	
	protected function initCtrl():void
	{
		;
	}
	
	private function resetCtrl():void
	{
		this.initCtrl();
		
		this._ctrlBg.instance.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
		this._ctrlBg.instance.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
		this._ctrlBg.instance.addEventListener(MouseEvent.RELEASE_OUTSIDE, this.onMouseUp);
		this._ctrlBg.instance.addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
		this._ctrlBar.instance.addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
		
		this.container.addChild(this._ctrlBg.instance);
		this.container.addChild(this._ctrlBar.instance);
		
		this._dragable = new DragableObject(this._ctrlBar, this, false);
	}
	
	public function resize(p_width:int, p_height:int, p_ratio:Number):void
	{
		this._width = p_width;
		this._heightBar = p_height * p_ratio;
		this._heightBg = p_height;
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
	
	public function setWheelStep(p_value:int):void
	{
		;
	}
	
	public function slideTo(p_pos:int, p_isUpdate:Boolean = false):void
	{
		;
	}

}

class SliderCtrlX extends SliderCtrl implements IMoveHandler
{
	
	public function SliderCtrlX(p_parent:IContainer, p_width:int, p_height:int, p_ratio:Number, p_colorBg:uint, p_colorBar:uint):void
	{
		super(p_parent, p_width, p_height, p_ratio, p_colorBg, p_colorBar);
	}
	
	override protected function init():void
	{
		super.init();
	}
	
	override protected function initCtrl():void
	{
		this._ctrlBar = new Quad(this._heightBar, this._width, this._colorBar);
		this._ctrlBg = new Quad(this._heightBg, this._width, this._colorBg);
	}
	
	override public function checkMove(p_from:Vector2D, p_to:Vector2D):Vector2D
	{
		if (!this._active)
		{
			return p_from.clone();
		}
		
		var result:Vector2D = p_to.clone();
		if (result.x > this._heightBg - this._heightBar)
		{
			result.x = this._heightBg - this._heightBar;
		}
		result.y = p_from.y;
		if (result.x < 0)
		{
			result.x = 0;
		}
		return result;
	}
	
	override public function resize(p_width:int, p_height:int, p_ratio:Number):void
	{
		super.resize(p_width, p_height, p_ratio);
		(this._ctrlBar as Quad).resize(this._heightBar, this._width);
		(this._ctrlBg as Quad).resize(this._heightBg, this._width);
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
	public function SliderCtrlY(p_parent:IContainer, p_width:int, p_height:int, p_ratio:Number, p_colorBg:uint, p_colorBar:uint):void
	{
		super(p_parent, p_width, p_height, p_ratio, p_colorBg, p_colorBar);
	}
	
	override protected function init():void
	{
		super.init();
	}
	
	override protected function initCtrl():void
	{
		this._ctrlBar = new Quad(this._width, this._heightBar, this._colorBar);
		this._ctrlBg = new Quad(this._width, this._heightBg, this._colorBg);
	}
	
	override public function checkMove(p_from:Vector2D, p_to:Vector2D):Vector2D
	{
		if (!this._active)
		{
			return p_from.clone();
		}
		
		var result:Vector2D = p_to.clone();
		if (result.y > this._heightBg - this._heightBar)
		{
			result.y = this._heightBg - this._heightBar;
		}
		result.x = p_from.x;
		if (result.y < 0)
		{
			result.y = 0;
		}
		return result;
	}
	
	override public function resize(p_width:int, p_height:int, p_ratio:Number):void
	{
		super.resize(p_width, p_height, p_ratio);
		(this._ctrlBar as Quad).resize(this._width, this._heightBar);
		(this._ctrlBg as Quad).resize(this._width, this._heightBg);
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