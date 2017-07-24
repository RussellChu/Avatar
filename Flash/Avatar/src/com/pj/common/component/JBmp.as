package com.pj.common.component
{
	import com.pj.common.IDisposable;
	import com.pj.common.JColor;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class JBmp implements IDisposable
	
	{
		private var _width:int = 0;
		private var _height:int = 0;
		private var _data:Object = null;
		
		public function JBmp(p_width:int, p_height:int)
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
		
		public function addLight(p_x:int, p_y:int, p_a:Number, p_r:Number, p_g:Number, p_b:Number):void
		{
			var data:Object = this.getData(p_x, p_y);
			var key:String = p_x + ":" + p_y;
			this._data[key] = JColor.addLight(data.r, data.g, data.b, data.a, p_r, p_g, p_b, p_a);
		}
		
		public function mul(p_x:int, p_y:int, p_m:Number):void
		{
			var data:Object = this.getData(p_x, p_y);
			data.a *= p_m;
			data.r *= p_m;
			data.g *= p_m;
			data.b *= p_m;
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
			bmp.lock();
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
					bmp.setPixel32(i, j, new JColor(data.r, data.g, data.b, data.a).value);
				}
			}
			bmp.unlock();
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