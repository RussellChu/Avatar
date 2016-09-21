package com.pj.macross.asset
{
	
	import com.pj.common.Creater;
	import com.pj.common.ICreatable;
	import com.pj.common.JColor;
	import com.pj.common.JSignal;
	import com.pj.common.component.JBmp;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
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
	public class Galaxy extends Bitmap implements ICreatable
	{
		static private const FULL_WIDTH:int = 500;
		static private const FULL_HEIGHT:int = 500;
		
		private var _creater:Creater = null;
		private var _signal:JSignal = null;
		
		public function Galaxy():void
		{
			super(new BitmapData(FULL_WIDTH, FULL_HEIGHT, true, new JColor(0, 0, 0.2, 1).value));
			this._creater = new Creater(this);
			this._signal = new JSignal();
		}
		
		public function get creater():Creater {
			return this._creater;
		}
		
		public function onCreate():void
		{
			var blur:int = 5;
			var radius:int = 2;
			var star:int = 0.002 * FULL_WIDTH * FULL_HEIGHT;
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
			
			var bmp:BitmapData = this.bitmapData;
			for (j = 0; j < blur; j++)
			{
				bmp.lock();
				for (i = 0; i < star; i++)
				{
					x = Math.random() * FULL_WIDTH;
					y = Math.random() * FULL_HEIGHT;
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
				
				var bmp2:BitmapData = new BitmapData(FULL_WIDTH, FULL_HEIGHT, true, 0);
				bmp2.applyFilter(bmp, new Rectangle(0, 0, bmp.width, bmp.height), new Point(0, 0), new BlurFilter(4, 4, BitmapFilterQuality.HIGH));
				bmp = bmp2;
			}
			
			this.bitmapData = bmp;
		}
		
		public function get signal():JSignal
		{
			return this._signal;
		}
	
	}
}