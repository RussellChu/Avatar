package com.pj.common.component
{
	import com.pj.common.Helper;
	import flash.events.MouseEvent;
	
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
		
		protected var _isMouseDown:Boolean = false;
		protected var _isMouseOver:Boolean = false;
		protected var _skin:BasicSkin = null;
		
		private var _id:int = 0;
		private var _toggle:Boolean = false;
		private var _value:Boolean = false;
		
		public function BasicButton(p_skin:BasicSkin, p_data:Object = null, p_toggle:Boolean = false)
		{
			this._skin = p_skin;
			this._toggle = p_toggle;
			super(p_data);
		}
		
		override public function dispose():void
		{
			Helper.dispose(this._skin);
			this._skin = null;
			
			super.dispose();
		}
		
		override protected function init():void
		{
			super.init();
			this.container.addChild(this._skin.instance);
		}
		
		override public function clear():void
		{
			super.clear();
			this._skin.clear();
		}
		
		override public function reset():void
		{
			super.reset();
			this._isMouseDown = false;
			this._isMouseOver = false;
			this._skin.reset();
			this.skin = SKIN_IDLE;
		}
		
		public function get id():int
		{
			return this._id;
		}
		
		public function get value():Boolean
		{
			return this._value;
		}
		
		public function set id(p_id:int):void
		{
			this._id = p_id;
		}
		
		public function set skin(p_id:int):void
		{
			this._skin.show(p_id);
		}
		
		public function set value(p_value:Boolean):void
		{
			this._value = p_value;
			if (this._value)
			{
				this.skin = SKIN_DOWN;
			}
			else
			{
				this.skin = SKIN_IDLE;
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
			this.skin = SKIN_DOWN;
			super.onMouseDown(p_evt);
		}
		
		override protected function onMouseOver(p_evt:MouseEvent):void
		{
			this._isMouseOver = true;
			if (this._isMouseDown)
			{
				this.skin = SKIN_DOWN;
			}
			else
			{
				this.skin = SKIN_OVER;
			}
			super.onMouseOver(p_evt);
		}
		
		override protected function onMouseUp(p_evt:MouseEvent):void
		{
			this._isMouseDown = false;
			if (this._isMouseOver)
			{
				this.skin = SKIN_OVER;
			}
			else
			{
				if (this._value)
				{
					this.skin = SKIN_DOWN;
				}
				else
				{
					this.skin = SKIN_IDLE;
				}
			}
			super.onMouseUp(p_evt);
		}
		
		override protected function onMouseRollOut(p_evt:MouseEvent):void
		{
			this._isMouseDown = false;
			this._isMouseOver = false;
			if (this._value)
			{
				this.skin = SKIN_DOWN;
			}
			else
			{
				this.skin = SKIN_IDLE;
			}
			super.onMouseRollOut(p_evt);
		}
	
	}
}