package com.pj.common.component
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class BasicImage extends BasicObject
	{
		public function BasicImage(p_bmp:BitmapData)
		{
			var img:Bitmap = new Bitmap(p_bmp);
			super(img);
		}
		
	}
}