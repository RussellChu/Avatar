package com.pj.common.component
{
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class BasicToggleButton extends LabelButton
	{
		private var _id:int = 0;
		private var _value:Boolean = false;
		
		public function BasicToggleButton(p_title:String, p_width:int, p_height:int, p_faceDown:BasicButtonFace, p_faceFront:BasicButtonFace, p_faceIdle:BasicButtonFace, p_faceOver:BasicButtonFace, p_data:Object = null, p_textAlignType:int = 0, p_textAlignValue:int = 0)
		{
			super(p_title, p_width, p_height, p_faceDown, p_faceFront, p_faceIdle, p_faceOver, p_data, p_textAlignType, p_textAlignValue);
		}
		
		override public function reset():void
		{
			super.reset();
			this._value = false;
		}
		
		public function setId(p_id:int):void
		{
			this._id = p_id;
		}
		
		public function set value(p_value:Boolean):void
		{
			if (this._value == p_value)
			{
				return;
			}
			
			this._value = p_value;
			if (this._value)
			{
				this.setImage(IMG_DOWN);
			}
			else
			{
				this.setImage(IMG_IDLE);
			}
		}
		
		override protected function onMouseClick(p_evt:MouseEvent):void
		{
			this._value = !this._value;
			//	super.onMouseClick(p_evt);
			this.signal.dispatch({action: ACTION_CLICK, data: this._data, id: this._id, value: this._value});
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
				if (this._value)
				{
					this.setImage(IMG_DOWN);
				}
				else
				{
					this.setImage(IMG_IDLE);
				}
			}
			super.onMouseUp(p_evt);
		}
		
		override protected function onMouseRollOut(p_evt:MouseEvent):void
		{
			this._isMouseOver = false;
			if (this._value)
			{
				this.setImage(IMG_DOWN);
			}
			else
			{
				this.setImage(IMG_IDLE);
			}
			super.onMouseRollOut(p_evt);
		}
	
	}
}