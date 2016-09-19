package com.pj.common.component
{
	import com.pj.common.JColor;
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class SimpleButton extends BasicButton
	{
		public function SimpleButton(p_title:String, p_width:int, p_height:int, p_data:Object = null):void
		{
			super(p_title, p_width, p_height //
				, new SimpleButtonFace(p_width, p_height, new JColor(0.8, 0.8, 0.7, 1)) //
				, null //
				, new SimpleButtonFace(p_width, p_height, new JColor(0.9, 0.9, 0.9, 1)) //
				, new SimpleButtonFace(p_width, p_height, new JColor(0.8, 0.8, 0.9, 1)) //
				, p_data);
		}
	
	}
}