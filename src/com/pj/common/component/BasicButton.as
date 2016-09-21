package com.pj.common.component
{
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class BasicButton extends LabelButton
	{
		public function BasicButton(p_title:String, p_width:int, p_height:int, p_faceDown:BasicButtonFace, p_faceFront:BasicButtonFace, p_faceIdle:BasicButtonFace, p_faceOver:BasicButtonFace, p_data:Object = null, p_textAlignType:int = 0, p_textAlignValue:int = 0)
		{
			super(p_title, p_width, p_height, p_faceDown, p_faceFront, p_faceIdle, p_faceOver, p_data, p_textAlignType, p_textAlignValue);
		}
		
		override protected function onMouseClick(p_evt:MouseEvent):void
		{
			super.onMouseClick(p_evt);
		}
		
		override protected function onMouseDown(p_evt:MouseEvent):void
		{
			this._isMouseDown = true;
			this.setImage(IMG_DOWN);
			super.onMouseDown(p_evt);
		}
		
		override protected function onMouseOver(p_evt:MouseEvent):void
		{
			this._isMouseOver = true;
			if (this._isMouseDown)
			{
				this.setImage(IMG_DOWN);
			}
			else
			{
				this.setImage(IMG_OVER);
			}
			super.onMouseOver(p_evt);
		}
		
		override protected function onMouseUp(p_evt:MouseEvent):void
		{
			this._isMouseDown = false;
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
			this._isMouseDown = false;
			this._isMouseOver = false;
			this.setImage(IMG_IDLE);
			super.onMouseRollOut(p_evt);
		}
	
	}
}