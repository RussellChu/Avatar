package com.pj.common.component
{
	import com.pj.common.Helper;
	import com.pj.common.JColor;
	import com.pj.common.component.BasicContainer;
	import com.pj.common.component.BasicObject;
	import com.pj.common.component.IContainer;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
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
		private var _txt:TextField = null;
		
		private var _isMouseOver:Boolean = false;
		
		public function SimpleButton(p_text:String, p_width:int, p_height:int):void
		{
			super();
			
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
			this._imgDown.scaleX = p_width;
			this._imgIdle.scaleX = p_width;
			this._imgOver.scaleX = p_width;
			this._imgDown.scaleY = p_height;
			this._imgIdle.scaleY = p_height;
			this._imgOver.scaleY = p_height;
			this.container.addChild(this._imgDown);
			this.container.addChild(this._imgIdle);
			this.container.addChild(this._imgOver);
			
			this.setImage(IMG_IDLE);
			
			this._txt = new TextField();
			this._txt.width = p_width;
			this._txt.height = p_height;
			this._txt.text = p_text;
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			this._txt.setTextFormat(format);
			this._txt.mouseEnabled = false;
			this.container.addChild(this._txt);
		}
		
		override public function dispose():void
		{
			this._imgDown = null;
			this._imgIdle = null;
			this._imgOver = null;
			this._txt = null;
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
			if (this._isMouseOver)
			{
				this.setImage(IMG_OVER);
			}
			else
			{
				this.setImage(IMG_IDLE);
			}
		}
		
		override protected function onMouseDown(p_evt:MouseEvent):void
		{
			this.setImage(IMG_DOWN);
		}
		
		override protected function onMouseOver(p_evt:MouseEvent):void
		{
			this._isMouseOver = true;
			this.setImage(IMG_OVER);
		}
		
		override protected function onMouseRollOut(p_evt:MouseEvent):void
		{
			this._isMouseOver = false;
			this.setImage(IMG_IDLE);
		}
	
	}
}