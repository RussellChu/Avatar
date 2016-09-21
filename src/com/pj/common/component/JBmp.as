package com.pj.common.component
{
	import com.pj.common.IDisposable;
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class JBmp implements IDisposable
	
	{
		private var _width:int = 0;
		private var _height:int = 0;
		private var _data:Object = null;
		
		public function JBmp(p_width:int, p_height:int):void
		{
			this._width = p_width;
			this._height = p_height;
			this._data = {};
		}
		
		public function dispose():void
		{
			;
		}
		
		public function add(p_x:int, p_y:int, p_a:int, p_r:int, p_g:int, p_b:int):void
		{
			var data:Object = this.getData(p_x, p_y);
			data.a += p_a;
			data.r += p_r;
			data.g += p_g;
			data.b += p_b;
		}
		
		public function mul(p_x:int, p_y:int, p_m:Number):void
		{
			var data:Object = this.getData(p_x, p_y);
			data.a *= p_m;
			data.r *= p_m;
			data.g *= p_m;
			data.b *= p_m;
		}
		
		public function sharp(p_x:int, p_y:int):void
		{
			var data:Object = this.getData(p_x, p_y);
			var r:Number = 1;
			data.a = (-1 * r * (data.a / 255) * (data.a / 255) * (data.a / 255) + r * (data.a / 255) * (data.a / 255) + (data.a / 255)) * 255;
			data.r = (-1 * r * (data.r / 255) * (data.r / 255) * (data.r / 255) + r * (data.r / 255) * (data.r / 255) + (data.r / 255)) * 255;
			data.g = (-1 * r * (data.g / 255) * (data.g / 255) * (data.g / 255) + r * (data.g / 255) * (data.g / 255) + (data.g / 255)) * 255;
			data.b = (-1 * r * (data.b / 255) * (data.b / 255) * (data.b / 255) + r * (data.b / 255) * (data.b / 255) + (data.b / 255)) * 255;
		}
		
		public function getData(p_x:int, p_y:int):Object
		{
			var key:String = p_x + ":" + p_y;
			if (!this._data[key])
			{
				this._data[key] = {a: 0, r: 0, g: 0, b: 0};
			}
			return this._data[key];
		}
		
		public function getBmp():BitmapData
		{
			var bmp:BitmapData = new BitmapData(this._width, this._height, true, 0);
			for (var i:int = 0; i < this._width; i++)
			{
				for (var j:int = 0; j < this._height; j++)
				{
					var key:String = i + ":" + j;
					if (!this._data[key])
					{
						continue;
					}
					var data:Object = this._data[key];
					var colorA:uint = (data.a > 0 ? data.a : 0);
					var colorR:uint = (data.r > 0 ? data.r : 0);
					var colorG:uint = (data.g > 0 ? data.g : 0);
					var colorB:uint = (data.b > 0 ? data.b : 0);
					if (colorA > 255)
					{
						colorA = 255;
					}
					if (colorR > 255)
					{
						colorR = 255;
					}
					if (colorG > 255)
					{
						colorG = 255;
					}
					if (colorB > 255)
					{
						colorB = 255;
					}
					var color:uint = (colorA << 24) + (colorR << 16) + (colorG << 8) + colorB;
					bmp.setPixel32(i, j, color);
				}
			}
			return bmp;
		}
		
		public function isData(p_x:int, p_y:int):Boolean
		{
			if (p_x < 0)
			{
				return false;
			}
			if (p_x >= this._width)
			{
				return false;
			}
			if (p_y < 0)
			{
				return false;
			}
			if (p_y >= this._height)
			{
				return false;
			}
			return true;
		}
	
	}
}