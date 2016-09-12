package com.pj.common.component 
{
	import com.pj.common.JColor;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	/**
	 * ...
	 * @author Russell
	 */
	public class LabelButton extends AbstractButton 
	{
		private var _faceDown:AbstractButtonFace = null;
		private var _faceIdle:AbstractButtonFace = null;
		private var _faceOver:AbstractButtonFace = null;
		protected var _txtTitle:TextField = null;
		
		private var _initTitle:String = "";
		private var _initWidth:int = 0;
		private var _initHeight:int = 0;
		private var _alignType:int = 0;
		private var _alignValue:int = 0;
		
		protected var _isMouseOver:Boolean = false;
		private var _stateImg:int = 0;
		
		public function LabelButton(p_title:String, p_width:int, p_height:int, p_faceDown:AbstractButtonFace, p_faceIdle:AbstractButtonFace, p_faceOver:AbstractButtonFace, p_data:Object = null, p_textAlignType:int = 0, p_textAlignValue:int = 0):void
		{
			this._initTitle = p_title;
			this._initWidth = p_width;
			this._initHeight = p_height;
			this._faceDown = p_faceDown;
			this._faceIdle = p_faceIdle;
			this._faceOver = p_faceOver;
			this._alignType = p_textAlignType;
			this._alignValue = p_textAlignValue;
			super(p_data);
		}
		
		override public function dispose():void
		{
			this._faceDown = null;
			this._faceIdle = null;
			this._faceOver = null;
			this._txtTitle = null;
			
			super.dispose();
		}
		
		override protected function init():void
		{
			super.init();
			
			this.container.addChild(this._faceDown.instance);
			this.container.addChild(this._faceIdle.instance);
			this.container.addChild(this._faceOver.instance);
			
			var mask:Quad = new Quad(this._initWidth, this._initHeight, new JColor(1, 1, 1, 0).value);
			this.container.addChild(mask.instance);
			
			this._txtTitle = new TextField();
			this._txtTitle.width = this._initWidth;
		//	this._txtTitle.height = this._initHeight;
			this._txtTitle.mask = mask.instance;
			this._txtTitle.text = "";
			//	var format:TextFormat = new TextFormat();
			//	format.align = TextFormatAlign.CENTER;
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
		
		protected function setImage(p_code:int):void
		{
			this._stateImg = p_code;
			
			switch (this._stateImg)
			{
			case IMG_DOWN: 
				this._faceDown.instance.visible = true;
				this._faceIdle.instance.visible = false;
				this._faceOver.instance.visible = false;
				break;
			case IMG_OVER: 
				this._faceOver.instance.visible = true;
				this._faceDown.instance.visible = false;
				this._faceIdle.instance.visible = false;
				break;
			case IMG_IDLE: 
				this._faceIdle.instance.visible = true;
				this._faceDown.instance.visible = false;
				this._faceOver.instance.visible = false;
			default: 
				break;
			}
		}
		
		public function set text(p_text:String):void
		{
			this._txtTitle.text = p_text;
			this._txtTitle.height = this._txtTitle.textHeight;
			var posY:int = 0;
			switch (this._alignType)
			{
			case ALIGN_BOTTON: 
				posY = (this._initHeight - this._txtTitle.height) + this._alignValue;
				break;
			case ALIGN_CENTER: 
				posY = (this._initHeight - this._txtTitle.height) * 0.5 + this._alignValue;
				if (posY < 0)
				{
					posY = 0;
				}
				break;
			default: 
				posY = this._alignValue;
			}
			this._txtTitle.y = posY;
			
			if (this._txtTitle.textWidth > this._initWidth)
			{
				this._txtTitle.autoSize = TextFieldAutoSize.LEFT;
			}
			else
			{
				this._txtTitle.autoSize = TextFieldAutoSize.CENTER;
			}
		}
		
		public function get faceIdle():AbstractButtonFace {
			return this._faceIdle;
		}
	
	}
}