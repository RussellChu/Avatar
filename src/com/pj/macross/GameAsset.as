package com.pj.macross
{
	import com.pj.common.AssetLoader;
	import com.pj.common.JColor;
	import com.pj.macross.asset.CellSkin;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class GameAsset
	{
		[Embed(source = "/../bin/assets/s01.png")]
		static private var BMP_S01:Class;
		[Embed(source = "/../bin/assets/s02.png")]
		static private var BMP_S02:Class;
		[Embed(source = "/../bin/assets/s03.png")]
		static private var BMP_S03:Class;
		[Embed(source = "/../bin/assets/s04.png")]
		static private var BMP_S04:Class;
		[Embed(source = "/../bin/assets/s05.png")]
		static private var BMP_S05:Class;
		[Embed(source = "/../bin/assets/s06.png")]
		static private var BMP_S06:Class;
		[Embed(source = "/../bin/assets/s07.png")]
		static private var BMP_S07:Class;
		[Embed(source = "/../bin/assets/s08.png")]
		static private var BMP_S08:Class;
		//[Embed(source = "/../bin/assets/fold.png")]
		//static private var BMP_FOLD:Class;
		//[Embed(source = "/../bin/assets/moas03.png")]
		//static private var BMP_GALAXY_03:Class;
		
		static private var __loader:AssetLoader = null;
		
		static public function get loader():AssetLoader
		{
			if (!__loader)
			{
				__loader = new AssetLoader();
				__loader.addObject("s01", new BMP_S01());
				__loader.addObject("s02", new BMP_S02());
				__loader.addObject("s03", new BMP_S03());
				__loader.addObject("s04", new BMP_S04());
				__loader.addObject("s05", new BMP_S05());
				__loader.addObject("s06", new BMP_S06());
				__loader.addObject("s07", new BMP_S07());
				__loader.addObject("s08", new BMP_S08());
				//	__loader.addObject("fold", new BMP_FOLD());
				__loader.addCreate("galaxy", new Galaxy());
				//	__loader.addObject("galaxySrc", new BMP_GALAXY_03());
				//	__loader.addCreate("galaxyDes", new GalaxyTest01());
				__loader.addCreate("fold", new Fold());
				__loader.addCreate("triA", new HostageTriangle(new JColor(1, 0.411, 0.411, 1)));
				__loader.addCreate("triB", new HostageTriangle(new JColor(0, 1, 0, 1)));
				__loader.addCreate("triC", new HostageTriangle(new JColor(0.534, 0.534, 1, 1)));
				__loader.addCreate(GameConfig.ASSET_KEY_MAP_CELL, new CellSkin(GameConfig.CELL_RADIUS_MAP * 2 + 0.5, GameConfig.CELL_RADIUS_MAP * 1.732 + 0.5, GameConfig.CELL_SIDE_MAP));
				__loader.addCreate(GameConfig.ASSET_KEY_CMD_CELL, new CellSkin(GameConfig.CELL_RADIUS_CMD * 2 + 0.5, GameConfig.CELL_RADIUS_CMD * 1.732 + 0.5, GameConfig.CELL_SIDE_CMD));
			}
			return __loader;
		}
		
		public function GameAsset()
		{
			;
		}
	
	}
}

import com.adobe.images.PNGEncoder;
import com.pj.common.Creater;
import com.pj.common.ICreatable;
import com.pj.common.JColor;
import com.pj.common.JSignal;
import com.pj.common.component.JBmp;
import com.pj.common.math.JMath;
import com.pj.macross.GameAsset;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.filters.BitmapFilterQuality;
import flash.filters.BlurFilter;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.net.FileReference;
import flash.utils.ByteArray;

class CreatableBitmap extends Bitmap implements ICreatable
{
	private var _creater:Creater = null;
	private var _signal:JSignal = null;
	
	public function CreatableBitmap(p_width:int, p_height:int, p_transparent:Boolean = true, p_fillColor:uint = 4294967295)
	{
		super(new BitmapData(p_width, p_height, p_transparent, p_fillColor));
		this._creater = new Creater(this);
		this._signal = new JSignal();
	}
	
	public function get creater():Creater
	{
		return this._creater;
	}
	
	public function onCreate():void
	{
		;
	}
	
	public function get signal():JSignal
	{
		return this._signal;
	}
}

class Fold extends CreatableBitmap
{
	static private const FULL_WIDTH:int = 64;
	static private const FULL_HEIGHT:int = 64;
	
	public function Fold()
	{
		super(FULL_WIDTH, FULL_HEIGHT, true, 0);
	}
	
	private function getLine(p_angle:Number, p_side:int, p_out:Number, p_in:Number, p_add:Number):Number
	{
		return (Math.cos((p_angle + p_add) * p_side) + 1) * 0.5 * (p_out - p_in) + p_in;
	}
	
	private function getColor(p_x:Number, p_y:Number):JColor
	{
		var angle:Number = Math.atan2(p_y, p_x);
		var dist:Number = Math.sqrt(p_x * p_x + p_y * p_y);
		
		var cR:Number = 0;
		var cG:Number = 0;
		var cB:Number = 0;
		var cA:Number = 0;
		
		var radius:Number = 1;
		for (var i:int = 0; i <= 5; i++)
		{
			var b0:Number = this.getLine(angle, 11, 1 * radius, 0.96 * radius, Math.PI / 11);
			var b1:Number = this.getLine(angle, 11, 0.8 * radius, 0.65 * radius, 0);
			var ratio:Number = JMath.ratio(dist, b0, b1);
			var lv:Number = 1 - Math.abs(2 * ratio - 1);
			if (ratio >= 0 && ratio <= 1)
			{
				cR += lv * 3;
				cG += lv * (lv * 0.5) * 3;
				cB += lv * 3;
				cA += lv;
			}
			radius *= 0.7;
		}
		
		return new JColor(cR, cG, cB, cA);
	}
	
	override public function onCreate():void
	{
		var bmp:BitmapData = this.bitmapData;
		bmp.lock();
		
		for (var x:int = 0; x < this.width; x++)
		{
			for (var y:int = 0; y < this.height; y++)
			{
				var color:JColor = this.getColor(x * 2 / this.width - 1, y * 2 / this.height - 1);
				bmp.setPixel32(x, y, color.value);
			}
		}
		bmp.unlock();
		//var ba:ByteArray = PNGEncoder.encode(bmp);
		//var fileReference:FileReference = new FileReference();
		//fileReference.save(ba, "fold.png");
	}
}

class HostageTriangle extends CreatableBitmap
{
	static private const FULL_WIDTH:int = 64;
	static private const FULL_HEIGHT:int = 64;
	
	private var _color:JColor = null;
	
	public function HostageTriangle(p_color:JColor)
	{
		this._color = p_color;
		super(FULL_WIDTH, FULL_HEIGHT, true, 0);
	}
	
	private function getLine(p_angle:Number, p_side:int, p_out:Number, p_in:Number, p_add:Number):Number
	{
		return (Math.cos((p_angle + p_add) * p_side) + 1) * 0.5 * (p_out - p_in) + p_in;
	}
	
	private function getColor(p_x:Number, p_y:Number):JColor
	{
		var angle:Number = Math.atan2(p_y, p_x);
		var dist:Number = Math.sqrt(p_x * p_x + p_y * p_y);
		
		var cR:Number = 0;
		var cG:Number = 0;
		var cB:Number = 0;
		var cA:Number = 0;
		
		var b0:Number = 0;
		var b1:Number = 0;
		
		if (angle < Math.PI * 1 / 3 && angle >= -Math.PI * 1 / 3)
		{
			b0 = 0.5 / Math.cos(angle + Math.PI * 2 * 0 / 3);
			b1 = 0.1 / Math.cos(angle + Math.PI * 2 * 0 / 3);
		}
		else if (angle >= Math.PI * 1 / 3)
		{
			b0 = 0.5 / Math.cos(angle - Math.PI * 2 * 1 / 3);
			b1 = 0.1 / Math.cos(angle - Math.PI * 2 * 1 / 3);
		}
		else
		{
			b0 = 0.5 / Math.cos(angle + Math.PI * 2 * 1 / 3);
			b1 = 0.1 / Math.cos(angle + Math.PI * 2 * 1 / 3);
		}
		
		var ratio:Number = JMath.ratio(dist, b0, b1);
		var lv:Number = 1 - Math.abs(2 * ratio - 1);
		if (ratio >= 0 && ratio <= 1)
		{
			cR += lv * this._color.r;
			cG += lv * this._color.g;
			cB += lv * this._color.b;
			cA += lv * 3;
		}
		
		return new JColor(cR, cG, cB, cA);
	}
	
	override public function onCreate():void
	{
		var bmp:BitmapData = this.bitmapData;
		bmp.lock();
		
		for (var x:int = 0; x < this.width; x++)
		{
			for (var y:int = 0; y < this.height; y++)
			{
				var color:JColor = this.getColor(x * 2 / this.width - 1, y * 2 / this.height - 1);
				bmp.setPixel32(x, y, color.value);
			}
		}
		bmp.unlock();
		//var ba:ByteArray = PNGEncoder.encode(bmp);
		//var fileReference:FileReference = new FileReference();
		//fileReference.save(ba, "tri.png");
	}
}

class Galaxy extends CreatableBitmap
{
	static private const FULL_WIDTH:int = 500;
	static private const FULL_HEIGHT:int = 500;
	
	public function Galaxy()
	{
		super(FULL_WIDTH, FULL_HEIGHT, true, new JColor(0, 0, 0.2, 1).value);
	}
	
	override public function onCreate():void
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
}

class GalaxyTest01 extends CreatableBitmap
{
	static private const FULL_WIDTH:int = 1280;
	static private const FULL_HEIGHT:int = 720;
	
	public function GalaxyTest01()
	{
		super(FULL_WIDTH, FULL_HEIGHT, true, 0);
	}
	
	override public function onCreate():void
	{
		var srcImg:Bitmap = GameAsset.loader.getAsset("galaxySrc") as Bitmap;
		var srcBmp:BitmapData = srcImg.bitmapData;
		var bmp:BitmapData = this.bitmapData;
		bmp.lock();
		var getColor:Function = function(p_x:int, p_y:int):JColor
		{
			if (p_x < 0 || p_x >= srcBmp.width || p_y < 0 || p_y >= srcBmp.height)
			{
				return new JColor(0, 0, 0, 0);
			}
			
			var c:uint = srcBmp.getPixel32(p_x, p_y);
			return JColor.createColorByHex(c);
		}
		
		var s:Number = 0.49;
		for (var x:int = 0; x < srcBmp.width; x++)
		{
			for (var y:int = 0; y < srcBmp.height; y++)
			{
				var c0:JColor = getColor(x - 1, y - 1);
				var c1:JColor = getColor(x + 0, y - 1);
				var c2:JColor = getColor(x + 1, y - 1);
				var c3:JColor = getColor(x - 1, y + 0);
				var c4:JColor = getColor(x + 0, y + 0);
				var c5:JColor = getColor(x + 1, y + 0);
				var c6:JColor = getColor(x - 1, y + 1);
				var c7:JColor = getColor(x + 0, y + 1);
				var c8:JColor = getColor(x + 1, y + 1);
				var r:Number = (c0.r + c1.r + c2.r + c3.r + c5.r + c6.r + c7.r + c8.r - c4.r * 8 + 8) / 16;
				var g:Number = (c0.g + c1.g + c2.g + c3.g + c5.g + c6.g + c7.g + c8.g - c4.g * 8 + 8) / 16;
				var b:Number = (c0.b + c1.r + c2.b + c3.b + c5.b + c6.b + c7.b + c8.b - c4.b * 8 + 8) / 16;
				var a:Number = (c0.a + c1.a + c2.a + c3.a + c5.a + c6.a + c7.a + c8.a - c4.a * 8 + 8) / 16;
				r = JMath.bound((r - 0.5) / (1 - s * 2) + 0.5, 0, 1);
				g = JMath.bound((g - 0.5) / (1 - s * 2) + 0.5, 0, 1);
				b = JMath.bound((b - 0.5) / (1 - s * 2) + 0.5, 0, 1);
				a = JMath.bound((a - 0.5) / (1 - s * 2) + 0.5, 0, 1);
				bmp.setPixel32(x, y, JColor.setRGBA(r, g, b, a));
			}
		}
		bmp.unlock();
		var ba:ByteArray = PNGEncoder.encode(bmp);
		var fileReference:FileReference = new FileReference();
		fileReference.save(ba, "tg.png");
	}
}