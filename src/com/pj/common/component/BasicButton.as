package com.pj.common.component
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class BasicButton extends AbstractButton
	{
		private static const IMG_DOWN:int = 0;
		private static const IMG_IDLE:int = 1;
		private static const IMG_OVER:int = 2;
		
		private var _bmpDown:BitmapData = null;
		private var _bmpIdle:BitmapData = null;
		private var _bmpOver:BitmapData = null;
		private var _imgDown:Bitmap = null;
		private var _imgIdle:Bitmap = null;
		private var _imgOver:Bitmap = null;
		private var _txtTitle:TextField = null;
		
		private var _initTitle:String = "";
		private var _initWidth:int = 0;
		private var _initHeight:int = 0;
		
		private var _isMouseOver:Boolean = false;
		private var _stateImg:int = 0;
		
		public function BasicButton(p_title:String, p_width:int, p_height:int, p_bmpDown:BitmapData, p_bmpIdle:BitmapData, p_bmpOver:BitmapData, p_data:Object = null):void
		{
			this._initTitle = p_title;
			this._initWidth = p_width;
			this._initHeight = p_height;
			this._bmpDown = p_bmpDown;
			this._bmpIdle = p_bmpIdle;
			this._bmpOver = p_bmpOver;
			super(p_data);
		}
		
		override public function dispose():void
		{
			this._bmpDown = null;
			this._bmpIdle = null;
			this._bmpOver = null;
			this._imgDown = null;
			this._imgIdle = null;
			this._imgOver = null;
			this._txtTitle = null;
			
			super.dispose();
		}
		
		override protected function init():void
		{
			super.init();
			
			this._imgDown = new Bitmap(this._bmpDown);
			this._imgIdle = new Bitmap(this._bmpIdle);
			this._imgOver = new Bitmap(this._bmpOver);
			this._imgDown.width = this._initWidth;
			this._imgIdle.width = this._initWidth;
			this._imgOver.width = this._initWidth;
			this._imgDown.height = this._initHeight;
			this._imgIdle.height = this._initHeight;
			this._imgOver.height = this._initHeight;
			this.container.addChild(this._imgDown);
			this.container.addChild(this._imgIdle);
			this.container.addChild(this._imgOver);
			
			this._txtTitle = new TextField();
			this._txtTitle.width = this._initWidth;
			//	this._txtTitle.height = this._initHeight;
			this._txtTitle.text = "";
			//	var format:TextFormat = new TextFormat();
			//	format.align = TextFormatAlign.CENTER;
			this._txtTitle.autoSize = TextFieldAutoSize.CENTER;
			//	setTextFormat: format will reset if text change; defaultTextFormat: not
			//	this._txtTitle.setTextFormat(format);
			//	this._txtTitle.defaultTextFormat = format;
			this._txtTitle.mouseEnabled = false;
			this.container.addChild(this._txtTitle);
		}
		
		override public function reset():void
		{
			super.reset();
			this.text = this._initTitle;
			this._isMouseOver = false;
			this.setImage(IMG_IDLE);
		}
		
		private function setImage(p_code:int):void
		{
			this._stateImg = p_code;
			
			switch (this._stateImg)
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
		
		public function set text(p_text:String):void
		{
			
			this._txtTitle.text = p_text;
			this._txtTitle.height = this._txtTitle.textHeight;
			var posY:int = (this._initHeight - this._txtTitle.height) * 0.5;
			if (posY < 0)
			{
				posY = 0;
			}
			this._txtTitle.y = posY;
		}
		
		public function set bmpIdle(p_bmp:BitmapData):void
		{
			this.container.removeChild(this._imgIdle);
			if (p_bmp)
			{
				this._imgIdle = new Bitmap(p_bmp);
			}
			else
			{
				this._imgIdle = new Bitmap(this._bmpIdle);
			}
			this._imgIdle.width = this._initWidth;
			this._imgIdle.height = this._initHeight;
			this.container.addChild(this._imgIdle);
			this.setImage(this._stateImg);
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