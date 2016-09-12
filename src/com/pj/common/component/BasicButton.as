package com.pj.common.component
{
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class BasicButton extends LabelButton
	{
		public function BasicButton(p_title:String, p_width:int, p_height:int, p_faceDown:AbstractButtonFace, p_faceIdle:AbstractButtonFace, p_faceOver:AbstractButtonFace, p_data:Object = null, p_textAlignType:int = 0, p_textAlignValue:int = 0):void
		{
			super(p_title, p_width, p_height, p_faceDown, p_faceIdle, p_faceOver, p_data, p_textAlignType, p_textAlignValue);
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