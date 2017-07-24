package com.pj.common.component
{
	import com.pj.common.component.BasicObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class JText extends BasicObject
	{
		static public const ALIGN_NONE:int = 0;
		static public const ALIGN_CENTER:int = 1;
		static public const ALIGN_BOTTON:int = 2;
		
		private var _alignType:int = 0;
		private var _alignValue:int = 0;
		private var _color:uint = 0;
		private var _size:int = 0;
		private var _txt:TextField = null;
		private var _width:int = 0;
		private var _height:int = 0;
		
		public function JText(p_size:int, p_color:uint, p_alignType:int = ALIGN_NONE, p_alignValue:int = 0, p_width:int = 0, p_height:int = 0)
		{
			this._size = p_size;
			this._color = p_color;
			this._width = p_width;
			this._height = p_height;
			this._alignType = p_alignType;
			this._alignValue = p_alignValue;
			super();
		}
		
		override public function dispose():void
		{
			this._txt = null;
			super.dispose();
		}
		
		override protected function init():void
		{
			super.init();
			
			this.container.mouseChildren = false;
			this.container.mouseEnabled = false;
			
			this._txt = new TextField();
			if (this._width > 0)
			{
				this._txt.width = this._width;
			}
			this._txt.text = "";
			this._txt.mouseEnabled = false;
			
			var format:TextFormat = new TextFormat();
			format.size = this._size;
			this._txt.defaultTextFormat = format;
			this._txt.textColor = this._color;
			
			this.container.addChild(this._txt);
		}
		
		protected function get container():Sprite
		{
			return this.instance as Sprite;
		}
		
		public function get textField():TextField
		{
			return this._txt;
		}
		
		public function get width():int {
			return this._width;
		}
		
		public function set color(p_color:uint):void {
			this._color = p_color;
			this._txt.textColor = this._color;
		}
		
		public function set text(p_text:String):void
		{
			this._txt.text = p_text;
			this._txt.height = this._txt.textHeight;
			var posY:int = 0;
			switch (this._alignType)
			{
			case ALIGN_BOTTON: 
				posY = (this._height - this._txt.height) + this._alignValue;
				break;
			case ALIGN_CENTER: 
				posY = (this._height - this._txt.height) * 0.5 + this._alignValue;
				if (posY < 0)
				{
					posY = 0;
				}
				break;
			case ALIGN_NONE: 
			default: 
				posY = this._alignValue;
			}
			this._txt.y = posY;
			
			if (this._txt.textWidth > this._width)
			{
				this._txt.autoSize = TextFieldAutoSize.LEFT;
			}
			else
			{
				this._txt.autoSize = TextFieldAutoSize.CENTER;
			}
		}
	}

}