package com.pj.macross
{
	import com.pj.common.AssetLoader;
	import com.pj.common.JColor;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class GameAsset
	{
		static public const KEY_CONFIG:String = "config";
		static public const KEY_IMAGE:String = "image";
		static public const KEY_S01:String = "s01";
		static public const KEY_S02:String = "s02";
		static public const KEY_S03:String = "s03";
		static public const KEY_S04:String = "s04";
		static public const KEY_S05:String = "s05";
		static public const KEY_S06:String = "s06";
		static public const KEY_S07:String = "s07";
		static public const KEY_S08:String = "s08";
		static public const KEY_GALAXY:String = "galaxy";
		static public const KEY_FOLD:String = "fold";
		static public const KEY_FOLD_IMG:String = "foldImg";
		static public const KEY_FOLD_ANI:String = "foldAni";
		static public const KEY_FOLD_MC:String = "foldMc";
		static public const KEY_TRI_A:String = "triA";
		static public const KEY_TRI_B:String = "triB";
		static public const KEY_TRI_C:String = "triC";
		static public const KEY_CELL_BLANK:String = "KEY_CELL_BLANK";
		static public const KEY_CELL_DOWN:String = "KEY_CELL_DOWN";
		static public const KEY_CELL_OVER:String = "KEY_CELL_OVER";
		static public const KEY_CELL_BASE_A:String = "KEY_CELL_BASE_A";
		static public const KEY_CELL_BASE_B:String = "KEY_CELL_BASE_B";
		static public const KEY_CELL_BASE_C:String = "KEY_CELL_BASE_C";
		static public const KEY_CELL_OBSTACLE:String = "KEY_CELL_OBSTACLE";
		static public const KEY_CELL_ROAD_A:String = "KEY_CELL_ROAD_A";
		static public const KEY_CELL_ROAD_B:String = "KEY_CELL_ROAD_B";
		static public const KEY_CELL_ROAD_C:String = "KEY_CELL_ROAD_C";
		static public const KEY_CELL_ATTACK:String = "KEY_CELL_ATTACK";
		static public const KEY_CELL_BORDER:String = "KEY_CELL_BORDER";
		
		[Embed(source = "/../bin/assets/config.txt", mimeType = "application/octet-stream")]
		static private var TXT_CONFIG:Class;
		[Embed(source = "/../bin/assets/image.txt", mimeType = "application/octet-stream")]
		static private var TXT_IMAGE:Class;
		[Embed(source = "/../bin/assets/image.png")]
		static private var BMP_IMAGE:Class;
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
		[Embed(source = "/../bin/assets/fold.png")]
		static private var BMP_FOLD:Class;
		
		static private var __loader:AssetLoader = null;
		
		static public function getHostageKeyById(p_id:int, p_side:int):String
		{
			var list:Array = [KEY_S01, KEY_S02, KEY_S03, KEY_S04, KEY_S05, KEY_S06, KEY_S07, KEY_S08];
			return getHostageKey(list[p_id], p_side);
		}
		
		static private function getHostageKey(p_key:String, p_side:int):String
		{
			return "KEY_CELL_HOSTAGE_" + p_key + "_" + p_side;
		}
		
		static public function get loader():AssetLoader
		{
			if (!__loader)
			{
				__loader = new AssetLoader();
				__loader.addObject(KEY_CONFIG, new TXT_CONFIG());
				__loader.addObject(KEY_S01, new BMP_S01());
				__loader.addObject(KEY_S02, new BMP_S02());
				__loader.addObject(KEY_S03, new BMP_S03());
				__loader.addObject(KEY_S04, new BMP_S04());
				__loader.addObject(KEY_S05, new BMP_S05());
				__loader.addObject(KEY_S06, new BMP_S06());
				__loader.addObject(KEY_S07, new BMP_S07());
				__loader.addObject(KEY_S08, new BMP_S08());
				__loader.addCreate(KEY_GALAXY, new Galaxy());
				__loader.addObject(KEY_FOLD_IMG, new BMP_FOLD());
				__loader.addCreate(KEY_FOLD_ANI, new FoldAni());
				__loader.addShared(KEY_FOLD_MC, FoldMc);
				__loader.addCreate(KEY_TRI_A, new HostageTriangle(new JColor(1, 0.706, 0.706, 1), new JColor(1, 0, 0, 1)));
				__loader.addCreate(KEY_TRI_B, new HostageTriangle(new JColor(0.5, 1, 0.5, 1), new JColor(0, 1, 0, 1)));
				__loader.addCreate(KEY_TRI_C, new HostageTriangle(new JColor(0.767, 0.767, 1, 1), new JColor(0, 0, 1, 1)));
				
				var sideList:Array = [GameData.SIDE_A, GameData.SIDE_B, GameData.SIDE_C];
				var keyList:Array = [KEY_S01, KEY_S02, KEY_S03, KEY_S04, KEY_S05, KEY_S06, KEY_S07, KEY_S08];
				for (var i:int = 0; i < sideList.length; i++)
				{
					for (var j:int = 0; j < keyList.length; j++)
					{
						var key:String = getHostageKey(keyList[j], sideList[i]);
						__loader.addShared(key, Hostage, {key: keyList[j], side: sideList[i]});
					}
				}
				
				var width:int = GameConfig.CELL_RADIUS_MAP * 2 + 0.5;
				var height:int = GameConfig.CELL_RADIUS_MAP * 1.732 + 0.5;
				__loader.addCreate(KEY_CELL_BLANK, new CellImage(CellImage.TYPE_BASE, width, height, GameConfig.CELL_SIDE_MAP, new JColor(0.5, 0.5, 0.5, 0.5).value));
				__loader.addCreate(KEY_CELL_DOWN, new CellImage(CellImage.TYPE_BASE, width, height, GameConfig.CELL_SIDE_MAP, new JColor(0, 1, 1, 0.5).value));
				__loader.addCreate(KEY_CELL_OVER, new CellImage(CellImage.TYPE_BASE, width, height, GameConfig.CELL_SIDE_MAP, new JColor(1, 1, 0, 0.5).value));
				__loader.addCreate(KEY_CELL_BASE_A, new CellImage(CellImage.TYPE_BASE, width, height, GameConfig.CELL_SIDE_MAP, new JColor(1, 0.411, 0.411, 1).value));
				__loader.addCreate(KEY_CELL_BASE_B, new CellImage(CellImage.TYPE_BASE, width, height, GameConfig.CELL_SIDE_MAP, new JColor(0, 1, 0, 1).value));
				__loader.addCreate(KEY_CELL_BASE_C, new CellImage(CellImage.TYPE_BASE, width, height, GameConfig.CELL_SIDE_MAP, new JColor(0.534, 0.534, 1, 1).value));
				__loader.addCreate(KEY_CELL_OBSTACLE, new CellImage(CellImage.TYPE_BASE, width, height, GameConfig.CELL_SIDE_MAP, new JColor(0.286, 0.0485, 0, 0.5).value));
				__loader.addCreate(KEY_CELL_ROAD_A, new CellImage(CellImage.TYPE_ROAD_A, width, height, GameConfig.CELL_SIDE_MAP, new JColor(1, 0, 0, 1).value));
				__loader.addCreate(KEY_CELL_ROAD_B, new CellImage(CellImage.TYPE_ROAD_A, width, height, GameConfig.CELL_SIDE_MAP, new JColor(0, 0.509, 0, 1).value));
				__loader.addCreate(KEY_CELL_ROAD_C, new CellImage(CellImage.TYPE_ROAD_A, width, height, GameConfig.CELL_SIDE_MAP, new JColor(0.209, 0.209, 1, 1).value));
				__loader.addCreate(KEY_CELL_ATTACK, new CellImage(CellImage.TYPE_ROAD_B, width, height, GameConfig.CELL_SIDE_MAP, new JColor(0.967, 0.673, 0.9055, 0.5).value));
				__loader.addCreate(KEY_CELL_BORDER, new CellImage(CellImage.TYPE_BORDER, width, height, GameConfig.CELL_SIDE_MAP, new JColor(0, 0, 0, 1).value));
				
				__loader.addImageOfGroup(KEY_IMAGE, TXT_IMAGE, BMP_IMAGE);
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
import com.pj.common.Helper;
import com.pj.common.ICreatable;
import com.pj.common.JColor;
import com.pj.common.JSignal;
import com.pj.common.JTimer;
import com.pj.common.component.BasicObject;
import com.pj.common.component.JBmp;
import com.pj.common.component.Quad;
import com.pj.common.math.JMath;
import com.pj.macross.GameAsset;
import com.pj.macross.GameConfig;
import com.pj.macross.GameData;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
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
	
	public function onCreate():Boolean
	{
		return true;
	}
	
	public function get signal():JSignal
	{
		return this._signal;
	}

}

class FoldAni implements ICreatable
{
	static public const DEFAULT_WIDTH:int = 64;
	static private const IS_LOAD_BMP:Boolean = true;
	private var _creater:Creater = null;
	private var _signal:JSignal = null;
	
	private var _list:Array = null;
	
	public function FoldAni()
	{
		super();
		this._creater = new Creater(this);
		this._signal = new JSignal();
	}
	
	public function get creater():Creater
	{
		return this._creater;
	}
	
	private function getLine(p_angle:Number, p_side:Number, p_out:Number, p_in:Number, p_add:Number):Number
	{
		return (Math.cos((p_angle + p_add) * p_side) + 1) * 0.5 * (p_out - p_in) + p_in;
	}
	
	private function getColor(p_x:Number, p_y:Number, p_side:Number, p_alpha:Number):JColor
	{
		var angle:Number = Math.atan2(p_y, p_x);
		var dist:Number = Math.sqrt(p_x * p_x + p_y * p_y);
		
		var color:JColor = new JColor(0, 0, 0, 0);
		
		for (var i:int = 0; i <= 2; i++)
		{
			var maxA:Number = 1;
			var b0:Number = this.getLine(angle + Math.PI * 2 * i, p_side, (0.4875 + 0.15) * p_alpha, (0.15 + 0.15) * p_alpha, 0);
			var b1:Number = this.getLine(angle + Math.PI * 2 * i, p_side, (0.4875 - 0.15) * p_alpha, (0.15 - 0.15) * p_alpha, 0);
			var ratio:Number = JMath.ratio(dist, b0, b1);
			var lv:Number = 1 - Math.abs(2 * ratio - 1);
			lv = lv * lv;
			if (i == 0)
			{
				maxA = (angle / Math.PI - 1) * 0.5 + 1;
			}
			if (i == 2)
			{
				maxA = 1 - (angle / Math.PI + 1) * 0.5;
			}
			var addA:Number = lv;
			if (addA > maxA)
			{
				addA = maxA;
			}
			if (ratio >= 0 && ratio <= 1)
			{
				color.addLight(1, lv * 2, 1 - lv * 4 + lv * lv * 4, addA);
			}
		}
		
		if (color.a > p_alpha)
		{
			color.a = p_alpha;
		}
		
		return color;
	}
	
	private function getColorAdd(p_x:Number, p_y:Number, p_radius:Number, p_angle:Number, p_color:JColor):JColor
	{
		var angle:Number = Math.atan2(p_y, p_x) + p_angle;
		var dist:Number = Math.sqrt(p_x * p_x + p_y * p_y);
		
		var color:JColor = new JColor(0, 0, 0, 0);
		
		var radius:Number = p_radius;
		for (var i:int = 0; i <= 2; i++)
		{
			var b0:Number = this.getLine(angle, 11, 1 * radius, 0.95 * radius, Math.PI / 11);
			var b1:Number = this.getLine(angle, 11, 0.55 * radius, 0.5 * radius, 0);
			var ratio:Number = JMath.ratio(dist, b0, b1);
			var lvMax:Number = (b0 - b1) / (0.5 * radius);
			var lv:Number = (1 - Math.abs(2 * ratio - 1)) * lvMax;
			if (ratio >= 0 && ratio <= 1)
			{
				color.addLight(lv * lv, lv * lv * 0.5, lv, lv * 0.9);
				color.addLight(lv, lv * 0.5, 1, lv * 0.9);
			}
			radius *= 0.65;
		}
		
		//var dist:Number = Math.sqrt(p_x * p_x + p_y * p_y);
		//if (dist < 1) {
		//var addLight:Number = 1 - dist;
		//addLight *= addLight;
		//addLight *= addLight;
		//}
		
		return p_color.addLight(color.r, color.g, color.b, color.a);
	}
	
	private function addBitmap(p_side:Number, p_startSide:Number, p_endSide:Number):void
	{
		var width:int = GameConfig.CELL_RADIUS_MAP * 2;
		var height:int = GameConfig.CELL_RADIUS_MAP * 2;
		var startTime:Number = 1.6;
		var endTime:Number = 0.4;
		
		var bmp:BitmapData = new BitmapData(width, height, true, 0);
		bmp.lock();
		
		for (var x:int = 0; x < width; x++)
		{
			for (var y:int = 0; y < height; y++)
			{
				var alpha:Number = 1;
				if (p_side < p_startSide + startTime)
				{
					alpha = (p_side - p_startSide) / startTime;
				}
				if (p_side >= p_endSide - endTime)
				{
					alpha = (p_endSide - p_side) / endTime;
				}
				var color:JColor = this.getColor(x * 2 / width - 1, y * 2 / height - 1, p_side, alpha);
				color = this.getColorAdd(x * 2 / width - 1, y * 2 / height - 1, alpha, -p_side, color);
				bmp.setPixel32(x, y, color.value);
			}
		}
		bmp.unlock();
		this._list.push(bmp);
	}
	
	private function saveAll():void
	{
		var width:int = GameConfig.CELL_RADIUS_MAP * 2 * (10);
		var height:int = GameConfig.CELL_RADIUS_MAP * 2 * int(this._list.length / 10 + 1);
		var bmp:BitmapData = new BitmapData(width, height, true, 0);
		bmp.lock();
		for (var i:int = 0; i < this._list.length; i++)
		{
			var src:BitmapData = this._list[i] as BitmapData;
			var x:int = GameConfig.CELL_RADIUS_MAP * 2 * (i % 10);
			var y:int = GameConfig.CELL_RADIUS_MAP * 2 * int(i / 10);
			bmp.draw(src, new Matrix(1, 0, 0, 1, x, y));
		}
		bmp.unlock();
		var ba:ByteArray = PNGEncoder.encode(bmp);
		var fileReference:FileReference = new FileReference();
		fileReference.save(ba, "fold.png");
	}
	
	public function onCreate():Boolean
	{
		this._list = [];
		
		if (IS_LOAD_BMP)
		{
			var src:BitmapData = (GameAsset.loader.getAsset(GameAsset.KEY_FOLD_IMG) as Bitmap).bitmapData;
			for (var i:int = 0; i < 80; i++)
			{
				var x:int = DEFAULT_WIDTH * (i % 10);
				var y:int = DEFAULT_WIDTH * int(i / 10);
				var bmp:BitmapData = new BitmapData(DEFAULT_WIDTH, DEFAULT_WIDTH, true, 0);
				bmp.draw(src, new Matrix(1, 0, 0, 1, -x, -y));
				this._list.push(bmp);
			}
			return true;
		}
		
		//addBitmap(4, 3, 5);
		//return true;
		
		var startSide:Number = 2;
		var endSide:Number = 6;
		var step:Number = 0.05;
		
		Helper.loopTime(0, (endSide - startSide) / step - 1, function(p_index:int):Boolean
		{
			addBitmap(startSide + p_index * step, startSide, endSide);
			return true;
		}, function():void
		{
			//	saveAll();
			_creater.createReady();
		});
		
		return false;
	}
	
	public function getFrameId(p_count:Number, p_delta:Number):Number
	{
		var count:Number = p_count + 0.01 * p_delta;
		if (int(count) > this._list.length)
		{
			count -= this._list.length;
		}
		return count;
	}
	
	public function getFrame(p_id:int):BitmapData
	{
		if (this._list.length == 0)
		{
			return null;
		}
		
		return this._list[p_id % this._list.length] as BitmapData;
		
		var realId:int = p_id / 2;
		if (realId >= this._list.length)
		{
			return this._list[this._list.length - 1] as BitmapData;
		}
		if (realId < 0)
		{
			return this._list[0] as BitmapData;
		}
		return this._list[realId] as BitmapData;
	}
	
	public function get signal():JSignal
	{
		return this._signal;
	}

}

class FoldMc extends BasicObject
{
	private var _count:Number = 0;
	private var _img:Bitmap = null;
	private var _timer:JTimer = null;
	
	public function FoldMc(p_data:Object)
	{
		super();
	}
	
	override public function dispose():void
	{
		Helper.dispose(this._timer);
		this._img = null;
		this._timer = null;
		
		super.dispose();
	}
	
	override protected function init():void
	{
		super.init();
		
		this.container.scaleX = GameConfig.CELL_RADIUS_MAP * 2 / FoldAni.DEFAULT_WIDTH;
		this.container.scaleY = this.container.scaleX;
		
		this._timer = new JTimer(this.onTime);
		this._timer.start();
	}
	
	private function onTime(p_delta:Number):void
	{
		var src:FoldAni = GameAsset.loader.getAsset(GameAsset.KEY_FOLD_ANI) as FoldAni;
		var bmp:BitmapData = src.getFrame(int(this._count));
		this._count = src.getFrameId(this._count, p_delta);
		
		if (!this._img)
		{
			this._img = new Bitmap(bmp);
			this.container.removeChildren();
			this.container.addChild(this._img);
		}
		else
		{
			this._img.bitmapData = bmp;
		}
		this._img.x = -this._img.width * 0.5;
		this._img.y = -this._img.height * 0.5;
	}
	
	private function get container():Sprite
	{
		return (this.instance as Sprite);
	}
}

class HostageTriangle extends CreatableBitmap
{
	private var _color:JColor = null;
	private var _color2:JColor = null;
	
	public function HostageTriangle(p_color:JColor, p_color2:JColor)
	{
		this._color = p_color;
		this._color2 = p_color2;
		super(GameConfig.CELL_RADIUS_MAP * 2, GameConfig.CELL_RADIUS_MAP * 2, true, 0);
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
			b0 = 0.4 / Math.cos(angle + Math.PI * 2 * 0 / 3);
			b1 = 0.1 / Math.cos(angle + Math.PI * 2 * 0 / 3);
		}
		else if (angle >= Math.PI * 1 / 3)
		{
			b0 = 0.4 / Math.cos(angle - Math.PI * 2 * 1 / 3);
			b1 = 0.1 / Math.cos(angle - Math.PI * 2 * 1 / 3);
		}
		else
		{
			b0 = 0.4 / Math.cos(angle + Math.PI * 2 * 1 / 3);
			b1 = 0.1 / Math.cos(angle + Math.PI * 2 * 1 / 3);
		}
		
		var ratio:Number = JMath.ratio(dist, b0, b1);
		var lv:Number = 1 - Math.abs(2 * ratio - 1);
		if (ratio >= 0 && ratio <= 1)
		{
			cR += this._color.r * ratio + this._color2.r * (1 - ratio);
			cG += this._color.g * ratio + this._color2.g * (1 - ratio);
			cB += this._color.b * ratio + this._color2.b * (1 - ratio);
			cA += lv;
		}
		
		return new JColor(cR, cG, cB, cA);
	}
	
	override public function onCreate():Boolean
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
		
		return true;
	}

}

class Hostage extends BasicObject
{
	private var _assetKey:String = "";
	private var _side:int = 0;
	private var _sp:Sprite = null;
	
	private var _angle:Number = 0;
	private var _timer:JTimer = null;
	
	public function Hostage(p_data:Object)
	{
		this._assetKey = p_data.key;
		this._side = p_data.side;
		super();
	}
	
	override public function dispose():void
	{
		Helper.dispose(this._timer);
		this._sp = null;
		this._timer = null;
		
		super.dispose();
	}
	
	override protected function init():void
	{
		super.init();
		
		var bmpTri:BitmapData = null;
		switch (this._side)
		{
		case GameData.SIDE_A: 
			bmpTri = (GameAsset.loader.getAsset(GameAsset.KEY_TRI_A) as Bitmap).bitmapData;
			break;
		case GameData.SIDE_B: 
			bmpTri = (GameAsset.loader.getAsset(GameAsset.KEY_TRI_B) as Bitmap).bitmapData;
			break;
		case GameData.SIDE_C: 
			bmpTri = (GameAsset.loader.getAsset(GameAsset.KEY_TRI_C) as Bitmap).bitmapData;
			break;
		}
		var bmpMan:BitmapData = (GameAsset.loader.getAsset(this._assetKey) as Bitmap).bitmapData;
		
		var imgTri:Bitmap = new Bitmap(bmpTri);
		this._sp = new Sprite();
		this._sp.addChild(imgTri);
		imgTri.x = -imgTri.width * 0.5;
		imgTri.y = -imgTri.height * 0.5;
		
		var sp:Sprite = new Sprite();
		sp.y = imgTri.height * 0.2;
		sp.addChild(this._sp);
		sp.scaleY = 0.5;
		
		var imgManA:Bitmap = new Bitmap(bmpMan);
		imgManA.scaleX = GameConfig.CELL_RADIUS_MAP * 2 / bmpMan.width;
		imgManA.scaleY = imgManA.scaleX;
		imgManA.x = -imgManA.width * 0.5;
		imgManA.y = -imgManA.height * 0.5;
		var imgManB:Bitmap = new Bitmap(bmpMan);
		imgManB.scaleX = GameConfig.CELL_RADIUS_MAP * 2 / bmpMan.width;
		imgManB.scaleY = imgManB.scaleX;
		imgManB.x = -imgManB.width * 0.5;
		imgManB.y = -imgManB.height * 0.5;
		
		this.container.addChild(imgManA);
		this.container.addChild(sp);
		this.container.addChild(imgManB);
		
		var mask:Quad = new Quad(imgManA.width, imgManA.height * 0.3);
		mask.instance.x = imgManA.x;
		mask.instance.y = imgManA.y + imgManA.height * 0.7;
		this.container.addChild(mask.instance);
		imgManA.mask = mask.instance;
		
		mask = new Quad(imgManB.width, imgManB.height * 0.7);
		mask.instance.x = imgManB.x;
		mask.instance.y = imgManB.y;
		this.container.addChild(mask.instance);
		imgManB.mask = mask.instance;
		
		this._timer = new JTimer(this.onTime);
		this._timer.start();
	}
	
	private function onTime(p_delta:Number):void
	{
		if (!this._sp)
		{
			return;
		}
		
		this._angle += 0.0001 * p_delta;
		if (this._angle > 1)
		{
			this._angle -= 1;
		}
		
		this._sp.rotation = 360 * this._angle;
	}
	
	private function get container():Sprite
	{
		return (this.instance as Sprite);
	}

}

class CellImage extends CreatableBitmap
{
	static public const TYPE_BASE:int = 1;
	static public const TYPE_ROAD_A:int = 2;
	static public const TYPE_ROAD_B:int = 3;
	static public const TYPE_BORDER:int = 4;
	
	private var _type:int = 0;
	private var _width:int = 0;
	private var _height:int = 0;
	private var _margin:int = 0;
	private var _color:uint = 0;
	
	public function CellImage(p_type:int, p_width:int, p_height:int, p_margin:int, p_color:uint)
	{
		this._type = p_type;
		this._width = p_width;
		this._height = p_height;
		this._margin = p_margin;
		this._color = p_color;
		super(p_width, p_height, true, 0);
	}
	
	override public function onCreate():Boolean
	{
		var bmp:BitmapData = this.bitmapData;
		bmp.lock();
		
		var v0:Number = 0;
		var v1:Number = 0;
		var v2:Number = 0;
		var v3:Number = 0;
		var v4:Number = 0;
		
		var funcHex:Function = function(p_d:Number):Boolean
		{
			var r:Number = p_d * _width * 4;
			var b0:Boolean = (v0 > r);
			var b1:Boolean = (v1 < -r);
			var b2:Boolean = (v2 < -r);
			var b3:Boolean = (v3 > r);
			var b4:Boolean = v4 >= p_d && v4 < _height - p_d;
			return b0 && b1 && b2 && b3 && b4;
		}
		
		for (var i:int = 0; i < this._width; i++)
		{
			for (var j:int = 0; j < this._height; j++)
			{
				v0 = 4 * this._height * i + 2 * this._width * j - this._width * this._height;
				v1 = -4 * this._height * i + 2 * this._width * j - this._width * this._height;
				v2 = 4 * this._height * i + 2 * this._width * j - 5 * this._width * this._height;
				v3 = -4 * this._height * i + 2 * this._width * j + 3 * this._width * this._height;
				v4 = j;
				
				if (this._type == TYPE_BASE)
				{
					if (funcHex(this._margin))
					{
						bmp.setPixel32(i, j, this._color);
					}
				}
				
				if (this._type == TYPE_BORDER)
				{
					if (funcHex(0) && !funcHex(this._margin))
					{
						bmp.setPixel32(i, j, this._color);
					}
				}
				
				var a:Number = 0;
				var sum:int = 0;
				if (this._type == TYPE_ROAD_A)
				{
					if (funcHex(this._height * 0.1875))
					{
						bmp.setPixel32(i, j, this._color);
					}
					
					var k:int = 0;
					var s:int = 6;
					a = this._width * 0.1;
					sum = 0;
					for (k = 0; k < s; k++)
					{
						sum += ((Math.cos(Math.PI * (2 / s * k - 0.5)) * (i - this._width * 0.5) + Math.sin(Math.PI * (2 / s * k - 0.5)) * (j - this._height * 0.5) < a) ? 1 : 0);
					}
					if (sum == s - 1)
					{
						bmp.setPixel32(i, j, 0);
					}
				}
				
				if (this._type == TYPE_ROAD_B)
				{
					a = this._width * 0.2;
					sum = 0;
					for (k = 0; k < s; k++)
					{
						sum += ((Math.cos(Math.PI * (2 / s * k)) * (i - this._width * 0.5) + Math.sin(Math.PI * (2 / s * k)) * (j - this._height * 0.5) < a) ? 1 : 0);
					}
					if (sum == s - 1)
					{
						bmp.setPixel32(i, j, this._color);
					}
				}
			}
		}
		bmp.unlock();
		
		return true;
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
	
	override public function onCreate():Boolean
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
		
		return true;
	}

}

//class GalaxyTest01 extends CreatableBitmap
//{
//static private const FULL_WIDTH:int = 1280;
//static private const FULL_HEIGHT:int = 720;
//
//public function GalaxyTest01()
//{
//super(FULL_WIDTH, FULL_HEIGHT, true, 0);
//}
//
//override public function onCreate():void
//{
//var srcImg:Bitmap = GameAsset.loader.getAsset("galaxySrc") as Bitmap;
//var srcBmp:BitmapData = srcImg.bitmapData;
//var bmp:BitmapData = this.bitmapData;
//bmp.lock();
//var getColor:Function = function(p_x:int, p_y:int):JColor
//{
//if (p_x < 0 || p_x >= srcBmp.width || p_y < 0 || p_y >= srcBmp.height)
//{
//return new JColor(0, 0, 0, 0);
//}
//
//var c:uint = srcBmp.getPixel32(p_x, p_y);
//return JColor.createColorByHex(c);
//}
//
//var s:Number = 0.49;
//for (var x:int = 0; x < srcBmp.width; x++)
//{
//for (var y:int = 0; y < srcBmp.height; y++)
//{
//var c0:JColor = getColor(x - 1, y - 1);
//var c1:JColor = getColor(x + 0, y - 1);
//var c2:JColor = getColor(x + 1, y - 1);
//var c3:JColor = getColor(x - 1, y + 0);
//var c4:JColor = getColor(x + 0, y + 0);
//var c5:JColor = getColor(x + 1, y + 0);
//var c6:JColor = getColor(x - 1, y + 1);
//var c7:JColor = getColor(x + 0, y + 1);
//var c8:JColor = getColor(x + 1, y + 1);
//var r:Number = (c0.r + c1.r + c2.r + c3.r + c5.r + c6.r + c7.r + c8.r - c4.r * 8 + 8) / 16;
//var g:Number = (c0.g + c1.g + c2.g + c3.g + c5.g + c6.g + c7.g + c8.g - c4.g * 8 + 8) / 16;
//var b:Number = (c0.b + c1.r + c2.b + c3.b + c5.b + c6.b + c7.b + c8.b - c4.b * 8 + 8) / 16;
//var a:Number = (c0.a + c1.a + c2.a + c3.a + c5.a + c6.a + c7.a + c8.a - c4.a * 8 + 8) / 16;
//r = JMath.bound((r - 0.5) / (1 - s * 2) + 0.5, 0, 1);
//g = JMath.bound((g - 0.5) / (1 - s * 2) + 0.5, 0, 1);
//b = JMath.bound((b - 0.5) / (1 - s * 2) + 0.5, 0, 1);
//a = JMath.bound((a - 0.5) / (1 - s * 2) + 0.5, 0, 1);
//bmp.setPixel32(x, y, JColor.setRGBA(r, g, b, a));
//}
//}
//bmp.unlock();
//var ba:ByteArray = PNGEncoder.encode(bmp);
//var fileReference:FileReference = new FileReference();
//fileReference.save(ba, "tg.png");
//}
//}