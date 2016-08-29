package com.pj.common.component
{
	import com.pj.common.JColor;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class SimpleButton extends AbstractButton
	{
		private static const IMG_DOWN:int = 0;
		private static const IMG_IDLE:int = 1;
		private static const IMG_OVER:int = 2;
		
		private var _imgDown:Bitmap = null;
		private var _imgIdle:Bitmap = null;
		private var _imgOver:Bitmap = null;
		private var _txtTitle:TextField = null;
		private var _format:TextFormat = null;
		
		private var _initTitle:String = "";
		private var _initWidth:int = 0;
		private var _initHeight:int = 0;
		
		private var _isMouseOver:Boolean = false;
		
		public function SimpleButton(p_title:String, p_width:int, p_height:int, p_data:Object = null):void
		{
			this._initTitle = p_title;
			this._initWidth = p_width;
			this._initHeight = p_height;
			super(p_data);
		}
		
		override public function dispose():void
		{
			this._imgDown = null;
			this._imgIdle = null;
			this._imgOver = null;
			this._txtTitle = null;
			
			super.dispose();
		}
		
		override protected function init():void
		{
			super.init();
			
			var colorDown:uint = new JColor(0.8, 0.8, 0.7, 1).value;
			var colorIdle:uint = new JColor(0.9, 0.9, 0.9, 1).value;
			var colorOver:uint = new JColor(0.8, 0.8, 0.9, 1).value;
			
			var bmpDataDown:BitmapData = new BitmapData(1, 1, true, 0);
			var bmpDataIdle:BitmapData = new BitmapData(1, 1, true, 0);
			var bmpDataOver:BitmapData = new BitmapData(1, 1, true, 0);
			
			bmpDataDown.lock();
			bmpDataIdle.lock();
			bmpDataOver.lock();
			
			for (var i:int = 0; i < 1; i++)
			{
				for (var j:int = 0; j < 1; j++)
				{
					bmpDataDown.setPixel32(i, j, colorDown);
					bmpDataIdle.setPixel32(i, j, colorIdle);
					bmpDataOver.setPixel32(i, j, colorOver);
				}
			}
			
			bmpDataDown.unlock();
			bmpDataIdle.unlock();
			bmpDataOver.unlock();
			
			this._imgDown = new Bitmap(bmpDataDown);
			this._imgIdle = new Bitmap(bmpDataIdle);
			this._imgOver = new Bitmap(bmpDataOver);
			this._imgDown.scaleX = this._initWidth;
			this._imgIdle.scaleX = this._initWidth;
			this._imgOver.scaleX = this._initWidth;
			this._imgDown.scaleY = this._initHeight;
			this._imgIdle.scaleY = this._initHeight;
			this._imgOver.scaleY = this._initHeight;
			this.container.addChild(this._imgDown);
			this.container.addChild(this._imgIdle);
			this.container.addChild(this._imgOver);
			
			this._txtTitle = new TextField();
			this._txtTitle.width = this._initWidth;
			this._txtTitle.height = this._initHeight;
			this._txtTitle.text = "";
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			//	setTextFormat: format will reset if text change; defaultTextFormat: not
			//	this._txtTitle.setTextFormat(format);
			this._txtTitle.defaultTextFormat = format;
			this._txtTitle.mouseEnabled = false;
			this.container.addChild(this._txtTitle);
		}
		
		override public function reset():void
		{
			super.reset();
			this._txtTitle.text = this._initTitle;
			this._isMouseOver = false;
			this.setImage(IMG_IDLE);
		}
		
		private function setImage(p_code:int):void
		{
			switch (p_code)
			{
			case IMG_DOWN: 
				this._imgDown.visible = true;
				this._imgIdle.visible = false;
				this._imgOver.visible = false;
				break;
			case IMG_OVER: 
				this._imgOver.visible = true;
				this._imgDown.visible = false;
				this._imgIdle.visible = false;
				break;
			case IMG_IDLE: 
				this._imgIdle.visible = true;
				this._imgDown.visible = false;
				this._imgOver.visible = false;
			default: 
				break;
			}
		}
		
		override protected function onMouseClick(p_evt:MouseEvent):void
		{
			super.onMouseClick(p_evt);
		}
		
		override protected function onMouseDown(p_evt:MouseEvent):void
		{
			this.setImage(IMG_DOWN);
			super.onMouseDown(p_evt);
		}
		
		override protected function onMouseOver(p_evt:MouseEvent):void
		{
			this._isMouseOver = true;
			this.setImage(IMG_OVER);
			super.onMouseOver(p_evt);
		}
		
		override protected function onMouseUp(p_evt:MouseEvent):void
		{
			if (this._isMouseOver)
			{
				this.setImage(IMG_OVER);
			}
			else
			{
				this.setImage(IMG_IDLE);
			}
			super.onMouseUp(p_evt);
		}
		
		override protected function onMouseRollOut(p_evt:MouseEvent):void
		{
			this._isMouseOver = false;
			this.setImage(IMG_IDLE);
			super.onMouseRollOut(p_evt);
		
		}
	
	}
}