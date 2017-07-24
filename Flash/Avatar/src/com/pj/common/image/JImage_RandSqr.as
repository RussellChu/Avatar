package com.pj.common.image
{
	import com.pj.common.JColor;
	import com.pj.common.component.BasicObject;
	import com.pj.common.component.IContainer;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class JImage_RandSqr extends BasicObject
	{
		public function JImage_RandSqr(p_parent:IContainer, p_width:int, p_height:int)
		{
			super(new Sprite(), p_parent);
			
			var bmpData:BitmapData = new BitmapData(p_width, p_height, true, 0);
			
			bmpData.lock();
			for (var i:int = 0; i < p_width; i++)
			{
				for (var j:int = 0; j < p_height; j++)
				{
					var color:uint = new JColor(Math.random(), Math.random(), Math.random(), 1).value;
					bmpData.setPixel32(i, j, color);
				}
			}
			bmpData.unlock();
			
			var img:Bitmap = new Bitmap(bmpData);
			this.container.addChild(img);
		}
		
		private function get container():Sprite
		{
			return this.instance as Sprite;
		}
	
	}
}