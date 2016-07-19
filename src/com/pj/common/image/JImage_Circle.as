package com.pj.common.image
{
	import com.pj.common.JColor;
	import com.pj.common.component.BasicObject;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class JImage_Circle extends BasicObject
	{
		public static const STYLE_DEFAULT:int = 0;
		public static const STYLE_RAND:int = 1;
		
		public function JImage_Circle(p_radius:Number, p_style:int = STYLE_DEFAULT, p_setting:Object = null):void
		{
			super();
			
			var color:JColor = null;
			
			switch(p_style) {
				case STYLE_RAND:
					;
					break;
				case STYLE_DEFAULT:
				default:
					var colorCode:int = 0xffffffff;
					if ( p_setting ) {
						if ( p_setting.color ) {
							colorCode = p_setting.color;
						}
					}
					color = JColor.createColorByHex(colorCode);
			}
			
			var bmpData:BitmapData = new BitmapData(p_radius * 2 + 1, p_radius * 2 + 1, true, 0);
			bmpData.lock();
			if (p_radius >= 1)
			{
				var maxR:Number = (p_radius - 0.5) * (p_radius - 0.5);
				var invR:Number = 1 / maxR;
				for (var i:int = -p_radius; i <= p_radius; i++)
				{
					for (var j:int = -p_radius; j <= p_radius; j++)
					{
						var checkR:Number = i * i + j * j;
						if (checkR <= maxR)
						{
							var c:JColor = null;
							switch(p_style) {
								case STYLE_RAND:
									c = new JColor(Math.random(), Math.random(), Math.random(), 1);
									break;
								case STYLE_DEFAULT:
								default:
									c = color.clone();
							}
							c.a = 1 - checkR * invR;
							bmpData.setPixel32(i + p_radius, j + p_radius, c.value);
						}
					}
				}
			}
			bmpData.unlock();
			
			var bmp:Bitmap = new Bitmap(bmpData);
			bmp.x = -p_radius;
			bmp.y = -p_radius;
			(this.instance as Sprite).addChild(bmp);
		}
	
	}
}