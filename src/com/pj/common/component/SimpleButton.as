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
			var colorDown:uint = new JColor(0.8, 0.8, 0.7, 1).value;
			var colorIdle:uint = new JColor(0.9, 0.9, 0.9, 1).value;
			var colorOver:uint = new JColor(0.8, 0.8, 0.9, 1).value;
			var bmpDown:BitmapData = new BitmapData(1, 1, true, 0);
			var bmpIdle:BitmapData = new BitmapData(1, 1, true, 0);
			var bmpOver:BitmapData = new BitmapData(1, 1, true, 0);
			bmpDown.lock();
			bmpIdle.lock();
			bmpOver.lock();
			for (var i:int = 0; i < 1; i++)
			{
				for (var j:int = 0; j < 1; j++)
				{
					bmpDown.setPixel32(i, j, colorDown);
					bmpIdle.setPixel32(i, j, colorIdle);
					bmpOver.setPixel32(i, j, colorOver);
				}
			}
			bmpDown.unlock();
			bmpIdle.unlock();
			bmpOver.unlock();
			super(p_title, p_width, p_height, bmpDown, bmpIdle, bmpOver, p_data);
		}
	
	}
}