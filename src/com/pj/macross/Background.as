package com.pj.macross
{
	import com.pj.common.JColor;
	import com.pj.common.component.BasicObject;
	import com.pj.common.component.JBmp;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class Background extends BasicObject
	{
		private var _xCount:int = 0;
		private var _yCount:int = 0;
		private var _width:int = 0;
		private var _height:int = 0;
		private var _bmp:BitmapData = null;
		
		public function Background(p_width:int, p_height:int):void
		{
			this._width = p_width;
			this._height = p_height;
			if (this._width < 0)
			{
				this._width = 0;
			}
			if (this._height < 0)
			{
				this._height = 0;
			}
			super();
		}
		
		override protected function onCreate():void
		{
			var blur:int = 5;
			var radius:int = 2;
			var star:int = 0.002 * this._width * this._height;
			var step:int = 2;
			var i:int = 0;
			var j:int = 0;
			var x:int = 0;
			var y:int = 0;
			
			var srcRadius:int = radius;
			for (i = 0; i < step; i++)
			{
				srcRadius *= 2;
			}
			
			var c0:JBmp = new JBmp(srcRadius * 2, srcRadius * 2);
			var p:Object = null;
			var p2:Object = null;
			for (x = 0; x < srcRadius * 2; x++)
			{
				for (y = 0; y < srcRadius * 2; y++)
				{
					var r:Number = srcRadius * srcRadius - (x - srcRadius) * (x - srcRadius) - (y - srcRadius) * (y - srcRadius);
					if (r < 0)
					{
						continue;
					}
					var c:Number = Math.sqrt(r) / srcRadius;
					p = c0.getData(x, y);
					p.r = 1;
					p.g = 1;
					p.b = 1;
					p.a = c * c * c * c;
				}
			}
			
			var c1:JBmp = null;
			for (i = 0; i < step; i++)
			{
				c1 = new JBmp(srcRadius, srcRadius);
				for (x = 0; x < srcRadius * 2; x++)
				{
					for (y = 0; y < srcRadius * 2; y++)
					{
						var x2:int = x / 2;
						var y2:int = y / 2;
						p = c0.getData(x, y);
						p2 = c1.getData(x2, y2);
						p2.r += p.r * 0.25;
						p2.g += p.g * 0.25;
						p2.b += p.b * 0.25;
						p2.a += p.a * 0.25;
					}
				}
				c0 = c1;
				srcRadius = srcRadius / 2;
			}
			
			var circle:BitmapData = new BitmapData(radius * 2, radius * 2, true, 0);
			for (x = 0; x < radius * 2; x++)
			{
				for (y = 0; y < radius * 2; y++)
				{
					p = c0.getData(x, y);
					circle.setPixel32(x, y, new JColor(p.r, p.g, p.b, p.a).value);
				}
			}
			
			var bmp:BitmapData = new BitmapData(this._width, this._height, true, new JColor(0, 0, 0.2, 1).value);
			for (j = 0; j < blur; j++)
			{
				bmp.lock();
				for (i = 0; i < star; i++)
				{
					x = Math.random() * this._width;
					y = Math.random() * this._height;
					var ct:ColorTransform = new ColorTransform(Math.random(), Math.random(), 1, Math.random());
					var mx:Matrix = new Matrix();
					mx.translate(x, y);
					bmp.draw(circle, mx, ct);
				}
				bmp.unlock();
				if (j == blur - 1)
				{
					break;
				}
				
				var bmp2:BitmapData = new BitmapData(this._width, this._height, true, 0);
				bmp2.applyFilter(bmp, new Rectangle(0, 0, bmp.width, bmp.height), new Point(0, 0), new BlurFilter(4, 4, BitmapFilterQuality.HIGH));
				bmp = bmp2;
			}
			
			this._bmp = bmp;
			this._xCount = 1;
			this._yCount = 1;
			
			var img:Bitmap = new Bitmap(bmp);
			var sp:Sprite = this.instance as Sprite;
			sp.addChild(img);
		}
		
		public function resize(p_width:int, p_height:int):void
		{
			var i:int = 0;
			var img:Bitmap = null;
			var sp:Sprite = this.instance as Sprite;
			while (p_width > this._xCount * this._width)
			{
				for (i = 0; i < this._yCount; i++)
				{
					img = new Bitmap(this._bmp);
					img.x = this._xCount * this._width;
					img.y = i * this._height;
					sp.addChild(img);
				}
				this._xCount++;
			}
			while (p_height > this._yCount * this._height)
			{
				for (i = 0; i < this._xCount; i++)
				{
					img = new Bitmap(this._bmp);
					img.x = i * this._width;
					img.y = this._yCount * this._height;
					sp.addChild(img);
				}
				this._yCount++;
			}
		}
	
	}

}