package com.pj.common.component
{
	import com.pj.common.JColor;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @author Russell
	 */
	
	public class SimpleButtonFace extends AbstractButtonFace
	{
		public function SimpleButtonFace(p_width:int, p_height:int, p_color:JColor)
		{
			super();
			var bmp:BitmapData = new BitmapData(1, 1, true, 0);
			bmp.lock();
			bmp.setPixel32(0, 0, p_color.value);
			bmp.unlock();
			var img:Bitmap = new Bitmap(bmp);
			img.width = p_width;
			img.height = p_height;
			this.container.addChild(img);
		}
		
	}
}