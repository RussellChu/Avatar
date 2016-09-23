package com.pj.common.component
{
	import com.pj.common.Helper;
	import com.pj.common.JColor;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class BasicButton extends AbstractButton
	{
		static public const ACTION_VALUE_CHANGE:String = 'value_change';
		
		static public const SKIN_IDLE:int = 0;
		static public const SKIN_DOWN:int = 1;
		static public const SKIN_OVER:int = 2;
		
		static protected const ALIGN_CENTER:int = 0;
		static protected const ALIGN_BOTTON:int = 1;
		
		protected var _isMouseDown:Boolean = false;
		protected var _isMouseOver:Boolean = false;
		protected var _skin:BasicSkin = null;
		protected var _txtTitle:TextField = null;
		
		private var _initTitle:String = "";
		private var _initWidth:int = 0;
		private var _initHeight:int = 0;
		private var _alignType:int = 0;
		private var _alignValue:int = 0;
		private var _id:int = 0;
		private var _toggle:Boolean = false;
		private var _value:Boolean = false;
		
		public function BasicButton(p_title:String, p_width:int, p_height:int, p_skin:BasicSkin, p_data:Object = null, p_textAlignType:int = 0, p_textAlignValue:int = 0, p_toggle:Boolean = false)
		{
			this._initTitle = p_title;
			this._initWidth = p_width;
			this._initHeight = p_height;
			this._skin = p_skin;
			this._alignType = p_textAlignType;
			this._alignValue = p_textAlignValue;
			this._toggle = p_toggle;
			super(p_data);
		}
		
		override public function dispose():void
		{
			Helper.dispose(this._skin);
			this._skin = null;
			this._txtTitle = null;
			
			super.dispose();
		}
		
		override protected function init():void
		{
			super.init();
			
			this.container.addChild(this._skin.instance);
			
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
		
		override public function clear():void
		{
			super.clear();
			this._skin.clear();
		}
		
		override public function reset():void
		{
			super.reset();
			this.text = this._initTitle;
			this._isMouseDown = false;
			this._isMouseOver = false;
			//	to do
			//	this._skin.reset();
			this._skin.show(SKIN_IDLE);
		}
		
		public function get id():int
		{
			return this._id;
		}
		
		public function get skin():BasicSkin
		{
			return this._skin;
		}
		
		public function get value():Boolean
		{
			return this._value;
		}
		
		public function set id(p_id:int):void
		{
			this._id = p_id;
		}
		
		public function set value(p_value:Boolean):void
		{
			this._value = p_value;
			if (this._value)
			{
				this._skin.show(SKIN_DOWN);
			}
			else
			{
				this._skin.show(SKIN_IDLE);
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
		
		override protected function onMouseClick(p_evt:MouseEvent):void
		{
			if (this._toggle)
			{
				this._value = !this._value;
				this._signal.dispatch({action: ACTION_VALUE_CHANGE, data: this._data, target: this});
			}
			super.onMouseClick(p_evt);
		}
		
		override protected function onMouseDown(p_evt:MouseEvent):void
		{
			this._isMouseDown = true;
			this._skin.show(SKIN_DOWN);
			super.onMouseDown(p_evt);
		}
		
		override protected function onMouseOver(p_evt:MouseEvent):void
		{
			this._isMouseOver = true;
			if (this._isMouseDown)
			{
				this._skin.show(SKIN_DOWN);
			}
			else
			{
				this._skin.show(SKIN_OVER);
			}
			super.onMouseOver(p_evt);
		}
		
		override protected function onMouseUp(p_evt:MouseEvent):void
		{
			this._isMouseDown = false;
			if (this._isMouseOver)
			{
				this._skin.show(SKIN_OVER);
			}
			else
			{
				if (this._value)
				{
					this._skin.show(SKIN_DOWN);
				}
				else
				{
					this._skin.show(SKIN_IDLE);
				}
			}
			super.onMouseUp(p_evt);
		}
		
		override protected function onMouseRollOut(p_evt:MouseEvent):void
		{
			this._isMouseDown = false;
			this._isMouseOver = false;
			this._skin.show(SKIN_IDLE);
			if (this._value)
			{
				this._skin.show(SKIN_DOWN);
			}
			else
			{
				this._skin.show(SKIN_IDLE);
			}
			super.onMouseRollOut(p_evt);
		}
	
	}
}