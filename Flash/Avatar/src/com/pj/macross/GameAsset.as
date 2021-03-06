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
		static public const KEY_GALAXY_ANI:String = "galaxyAni";
		static public const KEY_GALAXY_MC:String = "galaxyMc";
		static public const KEY_GALAXY:String = "galaxy";
		static public const KEY_METEOR:String = "meteor";
		
		static public const KEY_FIRE_ANI:String = "fireAni";
		static public const KEY_FIRE_MC:String = "fireMc";
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
		static public const KEY_CELL_LIGHT:String = "KEY_CELL_LIGHT";
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
				__loader.addCreate(KEY_GALAXY_ANI, new GalaxyAni(1024, 512));
				__loader.addShared(KEY_GALAXY_MC, GalaxyMc);
				__loader.addShared(KEY_GALAXY, Galaxy);
				__loader.addShared(KEY_METEOR, Meteor);
				__loader.addCreate(KEY_FIRE_ANI, new FireAni());
				__loader.addShared(KEY_FIRE_MC, FireMc);
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
				
				var width:int = GameConfig.getCellRadius() * 2 + 0.5;
				var height:int = GameConfig.getCellRadius() * 1.732 + 0.5;
				__loader.addCreate(KEY_CELL_BLANK, new CellImage(CellImage.TYPE_BASE, width, height, GameConfig.getCellMargin(), new JColor(0.3, 0.3, 0.5, 0.2).value));
				__loader.addCreate(KEY_CELL_DOWN, new CellImage(CellImage.TYPE_BASE, width, height, GameConfig.getCellMargin(), new JColor(0, 1, 1, 0.5).value));
				__loader.addCreate(KEY_CELL_OVER, new CellImage(CellImage.TYPE_BASE, width, height, GameConfig.getCellMargin(), new JColor(1, 1, 0, 0.5).value));
				__loader.addCreate(KEY_CELL_BASE_A, new CellImage(CellImage.TYPE_BASE, width, height, GameConfig.getCellMargin(), new JColor(1, 0.411, 0.411, 1).value));
				__loader.addCreate(KEY_CELL_BASE_B, new CellImage(CellImage.TYPE_BASE, width, height, GameConfig.getCellMargin(), new JColor(0, 1, 0, 1).value));
				__loader.addCreate(KEY_CELL_BASE_C, new CellImage(CellImage.TYPE_BASE, width, height, GameConfig.getCellMargin(), new JColor(0.534, 0.534, 1, 1).value));
				__loader.addCreate(KEY_CELL_OBSTACLE, new CellImage(CellImage.TYPE_BASE, width, height, GameConfig.getCellMargin(), new JColor(0.286, 0.0485, 0, 0.5).value));
				__loader.addCreate(KEY_CELL_LIGHT, new CellImage(CellImage.TYPE_BASE, width, height, GameConfig.getCellMargin(), new JColor(1, 1, 1, 1).value));
				__loader.addCreate(KEY_CELL_ROAD_A, new CellImage(CellImage.TYPE_ROAD_A, width, height, GameConfig.getCellMargin(), new JColor(1, 0, 0, 1).value));
				__loader.addCreate(KEY_CELL_ROAD_B, new CellImage(CellImage.TYPE_ROAD_A, width, height, GameConfig.getCellMargin(), new JColor(0, 0.509, 0, 1).value));
				__loader.addCreate(KEY_CELL_ROAD_C, new CellImage(CellImage.TYPE_ROAD_A, width, height, GameConfig.getCellMargin(), new JColor(0.209, 0.209, 1, 1).value));
				__loader.addCreate(KEY_CELL_ATTACK, new CellImage(CellImage.TYPE_ROAD_B, width, height, GameConfig.getCellMargin(), new JColor(0.967, 0.673, 0.9055, 0.5).value));
				__loader.addCreate(KEY_CELL_BORDER, new CellImage(CellImage.TYPE_BORDER, width, height, GameConfig.getCellMargin(), new JColor(0, 0, 0, 1).value));
				
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
import com.pj.common.JTimeLooper;
import com.pj.common.JTimer;
import com.pj.common.component.BasicContainer;
import com.pj.common.component.BasicObject;
import com.pj.common.component.Quad;
import com.pj.common.math.JMath;
import com.pj.common.math.Vector3D;
import com.pj.macross.GameAsset;
import com.pj.macross.GameConfig;
import com.pj.macross.GameData;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
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

class FireAni implements ICreatable
{
	static private const FRAME_NUM:int = 30;
	static private const PART_NUM:int = 200;
	
	private var _creater:Creater = null;
	private var _signal:JSignal = null;
	private var _list:Array = null;
	private var _ballList:Array = null;
	
	public function FireAni()
	{
		super();
		this._creater = new Creater(this);
		this._signal = new JSignal();
	}
	
	public function get creater():Creater
	{
		return this._creater;
	}
	
	private function get radius():Number
	{
		return GameConfig.getFoldAniSrcWidth();
	}
	
	public function onCreate():Boolean
	{
		this._ballList = [];
		this._list = [];
		
		var ball:Object = null;
		var pos:Vector3D = null;
		var vec:Vector3D = null;
		var i:int = 0;
		for (i = 0; i < PART_NUM; i++)
		{
			ball = {};
			var vecSrc:Object = JMath.randSphereSurface();
			pos = new Vector3D();
			vec = new Vector3D(vecSrc.x, vecSrc.y, vecSrc.z);
			vec.multiplyEql(3 + Math.random() * 3);
			ball.pos = pos;
			ball.vec = vec;
			this._ballList.push(ball);
		}
		
		for (var j:int = 0; j < FRAME_NUM; j++)
		{
			for (i = 0; i < this._ballList.length; i++)
			{
				ball = this._ballList[i];
				pos = ball.pos;
				vec = ball.vec;
				pos.addEql(vec);
			}
			
			var bmp:BitmapData = new BitmapData(this.radius * 2, this.radius * 2, true, 0);
			bmp.lock();
			for (i = 0; i < this._ballList.length; i++)
			{
				ball = this._ballList[i];
				pos = ball.pos;
				var len:Number = Math.sqrt(pos.lengthSqr());
				var alpha:Number = 0;
				if (len < this.radius)
				{
					alpha = 1 - len / this.radius;
				}
				alpha *= (1 - j / FRAME_NUM);
				var colorSrc:uint = bmp.getPixel32(pos.x + this.radius, pos.y + this.radius);
				var color:JColor = JColor.createColorByHex(colorSrc);
				color.addLight(1, 1, Math.random(), alpha);
				bmp.setPixel32(pos.x + this.radius, pos.y + this.radius, color.value);
			}
			bmp.unlock();
			this._list.push(bmp);
		}
		
		return true;
	}
	
	public function getFrameId(p_count:Number, p_delta:Number):Number
	{
		return (p_count + 0.01 * p_delta) % this._list.length;
	}
	
	public function getFrame(p_id:int):BitmapData
	{
		if (this._list.length == 0)
		{
			return null;
		}
		
		return this._list[p_id % this._list.length] as BitmapData;
	}
	
	public function get signal():JSignal
	{
		return this._signal;
	}

}

class FireMc extends BasicObject
{
	private var _count:Number = 0;
	private var _img:Bitmap = null;
	private var _timer:JTimer = null;
	
	public function FireMc(p_data:Object = null)
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
		
		this.container.scaleX = GameConfig.getCellRadius() * 2 / GameConfig.getFoldAniSrcWidth();
		this.container.scaleY = this.container.scaleX;
		
		this._timer = new JTimer(this.onTime);
		this._timer.start();
	}
	
	private function onTime(p_delta:Number):void
	{
		var src:FireAni = GameAsset.loader.getAsset(GameAsset.KEY_FIRE_ANI) as FireAni;
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

class FoldAni implements ICreatable
{
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
	
	private function getColor(p_x:Number, p_y:Number, p_side:Number, p_alpha:Number, p_add:Number):JColor
	{
		var angle:Number = Math.atan2(p_y, p_x);
		var dist:Number = Math.sqrt(p_x * p_x + p_y * p_y);
		
		var color:JColor = new JColor(0, 0, 0, 0);
		
		for (var i:int = 0; i <= 2; i++)
		{
			var maxA:Number = 1;
			var b0:Number = this.getLine(angle + Math.PI * 2 * i, p_side, (0.45 + 0.15) * p_alpha, (0.15 + 0.15) * p_alpha, p_add);
			var b1:Number = this.getLine(angle + Math.PI * 2 * i, p_side, (0.45 - 0.15) * p_alpha, (0.15 - 0.15) * p_alpha, p_add);
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
			if (dist < 0.3)
			{
				maxA = (dist - 0.15) / 0.15;
				if (addA > maxA)
				{
					addA = maxA;
				}
				if (addA < 0)
				{
					addA = 0;
				}
			}
			if (ratio >= 0 && ratio <= 1)
			{
				color.addLight(1, lv * 2, 1 - lv * 4 + lv * lv * 4, addA);
			}
		}
		
		//if (color.a > p_alpha)
		//{
		//color.a = p_alpha;
		//}
		
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
			var hill:Number = ((b0 - b1) / radius - (0.95 - 0.55)) / (0.5 - (0.95 - 0.55));
			if (ratio >= 0 && ratio <= 1)
			{
				var x:Number = Math.abs(2 * ratio - 1);
				var r:Number = Math.exp(-x * x * 12) * (0.4 + hill * 0.3) * 1.4;
				var g:Number = Math.exp(-x * x * 12) * (0.25 + hill * 0.15) * 1.4;
				var b:Number = Math.exp(-x * x * 4) * (0.55) * 1.4;
				var a:Number = (1 - x) * (0.8 + hill * 0.2);
				color.addLight(r, g, b, a);
			}
			radius *= 0.65;
		}
		
		if (dist < 0.5 * p_radius)
		{
			var c:Number = (0.6 + p_radius * 0.5 - dist / p_radius * 2);
			if (c > 1)
			{
				c = 1;
			}
			var c2:Number = (0.6 + p_radius * 0.5 - dist / p_radius * 4);
			if (c2 > 1)
			{
				c2 = 1;
			}
			color.addLight(c, c2, c, c);
		}
		
		return p_color.addLight(color.r, color.g, color.b, color.a);
	}
	
	private function addBitmap(p_side:Number, p_startSide:Number, p_endSide:Number):void
	{
		var width:int = GameConfig.getCellRadius() * 2;
		var height:int = GameConfig.getCellRadius() * 2;
		var startTime:Number = 1.5;
		var endTime:Number = 0.3;
		
		var bmp:BitmapData = new BitmapData(width, height, true, 0);
		bmp.lock();
		
		var alpha:Number = 1;
		if (p_side < p_startSide + startTime)
		{
			alpha = (p_side - p_startSide) / startTime;
		}
		if (p_side >= p_endSide - endTime)
		{
			alpha = (p_endSide - p_side) / endTime;
		}
		var side:Number = p_side;
		if (side > p_endSide - endTime)
		{
			side = p_endSide - endTime;
		}
		var add:Number = p_side - side;
		
		for (var x:int = 0; x < width; x++)
		{
			for (var y:int = 0; y < height; y++)
			{
				var color:JColor = this.getColor(x * 2 / width - 1, y * 2 / height - 1, side, alpha, add);
				color = this.getColorAdd(x * 2 / width - 1, y * 2 / height - 1, alpha, -p_side, color);
				bmp.setPixel32(x, y, color.value);
			}
		}
		bmp.unlock();
		this._list.push(bmp);
	}
	
	private function saveAll():void
	{
		var width:int = GameConfig.getCellRadius() * 2 * (10);
		var height:int = GameConfig.getCellRadius() * 2 * int(this._list.length / 10 + 1);
		var bmp:BitmapData = new BitmapData(width, height, true, 0);
		bmp.lock();
		for (var i:int = 0; i < this._list.length; i++)
		{
			var src:BitmapData = this._list[i] as BitmapData;
			var x:int = GameConfig.getCellRadius() * 2 * (i % 10);
			var y:int = GameConfig.getCellRadius() * 2 * int(i / 10);
			bmp.draw(src, new Matrix(1, 0, 0, 1, x, y));
		}
		bmp.unlock();
		var ba:ByteArray = PNGEncoder.encode(bmp);
		var fileReference:FileReference = new FileReference();
		fileReference.save(ba, "fold2.png");
	}
	
	public function onCreate():Boolean
	{
		this._list = [];
		
		if (GameConfig.getFoldAniSrcLoad())
		{
			var src:BitmapData = (GameAsset.loader.getAsset(GameAsset.KEY_FOLD_IMG) as Bitmap).bitmapData;
			for (var i:int = 0; i < 70; i++)
			{
				var x:int = GameConfig.getFoldAniSrcWidth() * (i % 10);
				var y:int = GameConfig.getFoldAniSrcWidth() * int(i / 10);
				var bmp:BitmapData = new BitmapData(GameConfig.getFoldAniSrcWidth(), GameConfig.getFoldAniSrcWidth(), true, 0);
				bmp.draw(src, new Matrix(1, 0, 0, 1, -x, -y));
				this._list.push(bmp);
			}
			return true;
		}
		
		//addBitmap(4, 3, 5);
		//return true;
		
		var startSide:Number = 2;
		var endSide:Number = 5.3;
		var step:Number = 0.05;
		
		new JTimeLooper(0, (endSide - startSide) / step, function(p_index:int):Boolean
		{
			addBitmap(startSide + p_index * step, startSide, endSide);
			return true;
		}, function():void
		{
			//	saveAll();
			_creater.createReady();
		}).loop();
		
		return false;
	}
	
	public function getFrameId(p_count:Number, p_delta:Number):Number
	{
		return (p_count + 0.01 * p_delta) % 90;
	}
	
	public function getFrame(p_id:int):BitmapData
	{
		if (this._list.length == 0)
		{
			return null;
		}
		
		if (p_id <= 65)
		{
			return this._list[p_id] as BitmapData;
		}
		
		var fire:FireAni = GameAsset.loader.getAsset(GameAsset.KEY_FIRE_ANI) as FireAni;
		
		return fire.getFrame(p_id - 66);
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
	private var _img2:Bitmap = null;
	private var _timer:JTimer = null;
	
	public function FoldMc(p_data:Object = null)
	{
		super();
	}
	
	override public function dispose():void
	{
		Helper.dispose(this._timer);
		this._img = null;
		this._img2 = null;
		this._timer = null;
		
		super.dispose();
	}
	
	override protected function init():void
	{
		super.init();
		
		this.container.scaleX = GameConfig.getCellRadius() * 2 / GameConfig.getFoldAniSrcWidth();
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
		super(GameConfig.getCellRadius() * 2, GameConfig.getCellRadius() * 2, true, 0);
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
		imgManA.scaleX = GameConfig.getCellRadius() * 2 / bmpMan.width;
		imgManA.scaleY = imgManA.scaleX;
		imgManA.x = -imgManA.width * 0.5;
		imgManA.y = -imgManA.height * 0.5;
		var imgManB:Bitmap = new Bitmap(bmpMan);
		imgManB.scaleX = GameConfig.getCellRadius() * 2 / bmpMan.width;
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
		
		this._angle = (this._angle + 0.0001 * p_delta) % 1;
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

/*
   class GalaxyAni implements ICreatable
   {
   static private const FRAME_NUM:int = 30;
   static private const PART_NUM:int = 200;

   private var _creater:Creater = null;
   private var _signal:JSignal = null;
   private var _list:Array = null;
   private var _ballList:Array = null;

   public function GalaxyAni()
   {
   super();
   this._creater = new Creater(this);
   this._signal = new JSignal();
   }

   public function get creater():Creater
   {
   return this._creater;
   }

   private function get radius():Number
   {
   return GameConfig.getFoldAniSrcWidth();
   }

   public function onCreate():Boolean
   {
   this._ballList = [];
   this._list = [];

   var ball:Object = null;
   var pos:Vector3D = null;
   var vec:Vector3D = null;
   var i:int = 0;
   for (i = 0; i < PART_NUM; i++)
   {
   ball = {};
   var vecSrc:Object = JMath.randSphereSurface();
   pos = new Vector3D();
   vec = new Vector3D(vecSrc.x, vecSrc.y, vecSrc.z);
   vec.multiplyEql(3 + Math.random() * 3);
   ball.pos = pos;
   ball.vec = vec;
   this._ballList.push(ball);
   }

   for (var j:int = 0; j < FRAME_NUM; j++)
   {
   for (i = 0; i < this._ballList.length; i++)
   {
   ball = this._ballList[i];
   pos = ball.pos;
   vec = ball.vec;
   pos.addEql(vec);
   }

   var bmp:BitmapData = new BitmapData(this.radius * 2, this.radius * 2, true, 0);
   bmp.lock();
   for (i = 0; i < this._ballList.length; i++)
   {
   ball = this._ballList[i];
   pos = ball.pos;
   var len:Number = Math.sqrt(pos.lengthSqr());
   var alpha:Number = 0;
   if (len < this.radius)
   {
   alpha = 1 - len / this.radius;
   }
   alpha *= (1 - j / FRAME_NUM);
   var colorSrc:uint = bmp.getPixel32(pos.x + this.radius, pos.y + this.radius);
   var color:JColor = JColor.createColorByHex(colorSrc);
   color.addLight(1, 1, Math.random(), alpha);
   bmp.setPixel32(pos.x + this.radius, pos.y + this.radius, color.value);
   }
   bmp.unlock();
   this._list.push(bmp);
   }

   return true;
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
   }

   public function get signal():JSignal
   {
   return this._signal;
   }

   }
 */

class GalaxyAni implements ICreatable
{
	static private const IMG_NUM:int = 8;
	static private const STAR_NUM:int = 1024;
	
	private var _creater:Creater = null;
	private var _signal:JSignal = null;
	
	private var _width:int = 0;
	private var _height:int = 0;
	private var _list:Array = null;
	private var _timer:JTimer = null;
	
	public function GalaxyAni(p_width:int, p_height:int)
	{
		this._width = p_width;
		this._height = p_height;
		this._creater = new Creater(this);
		this._signal = new JSignal();
	}
	
	public function get creater():Creater
	{
		return this._creater;
	}
	
	public function get signal():JSignal
	{
		return this._signal;
	}
	
	public function get imageNum():int
	{
		return IMG_NUM;
	}
	
	public function get width():int
	{
		return this._width;
	}
	
	public function get height():int
	{
		return this._height;
	}
	
	public function getImage(p_id:int):BitmapData
	{
		if (p_id >= 0 && p_id < this._list.length)
		{
			return this._list[p_id].bmp;
		}
		
		return null;
	}
	
	public function onCreate():Boolean
	{
		var i:int = 0;
		var j:int = 0;
		var k:int = 0;
		var m:int = 0;
		
		var bmp:BitmapData = new BitmapData(this._width, this._height, true, 0);
		var bmp2:BitmapData = null;
		var alphaList:Array = [];
		var alphaSum:Number = 0;
		for (i = 0; i < IMG_NUM; i++)
		{
			var v:Number = Math.random();
			alphaList.push(v);
			alphaSum += v;
		}
		
		this._list = [];
		for (i = 0; i < IMG_NUM; i++)
		{
			bmp2 = new BitmapData(this._width, this._height, true, 0);
			bmp2.lock();
			this._list.push({bmp: bmp2});
		}
		
		for (k = 0; k < STAR_NUM; k++)
		{
			var numA:Number = int(-12 + Math.random() * 16);
			var numR:Number = int(1 + Math.random() * 5);
			var numM:Number = Math.random();
			var addX:int = (this._width - numR * 2) * Math.random();
			var addY:int = (this._height - numR * 2) * Math.random();
			
			var colorList:Array = [];
			for (i = 0; i < this._list.length; i++)
			{
				colorList.push({r: 0.7 + Math.random() * 0.3, g: 0.4 + Math.random() * 0.6, b: 1, a: Math.random()});
			}
			
			for (i = 0; i < numR * 2; i++)
			{
				for (j = 0; j < numR * 2; j++)
				{
					var x:Number = Math.sqrt((i - numR) * (i - numR) + (j - numR) * (j - numR)) / numR;
					var x2:Number = x;
					x2 *= 1.5;
					var a0:Number = Math.abs(i - numR);
					var a1:Number = Math.abs(j - numR);
					x *= 2;
					if (a0 > a1)
					{
						x *= (1 - a1 / a0 * 0.8);
					}
					else if (a0 < a1)
					{
						x *= (1 - a0 / a1 * 0.8);
					}
					else
					{
						x *= 0.2;
					}
					if (x > 1)
					{
						x = 1;
					}
					if (x2 > 1)
					{
						x2 = 1;
					}
					var z:Number = (2 * x * x * x - 3 * x * x + 1) * (1 + numA * (x * x * (1 - x) * (1 - x)));
					z *= 0.7;
					var z2:Number = (2 * x2 * x2 * x2 - 3 * x2 * x2 + 1) * (1 + numA * (x2 * x2 * (1 - x2) * (1 - x2)));
					if (z2 > z)
					{
						z = z2;
					}
					
					var colorSrc:uint = bmp.getPixel32(i + addX, j + addY);
					var color:JColor = JColor.createColorByHex(colorSrc);
					color.addLight(1, 1, 1, z * numM);
					bmp.setPixel32(i + addX, j + addY, color.value);
					
					for (m = 0; m < this._list.length; m++)
					{
						var color2:JColor = new JColor(color.r * colorList[m].r, color.g * colorList[m].g, color.b * colorList[m].b, color.a * colorList[m].a);
						bmp2 = this._list[m].bmp;
						bmp2.setPixel32(i + addX, j + addY, color2.value);
					}
				}
			}
		}
		bmp.unlock();
		for (i = 0; i < this._list.length; i++)
		{
			bmp2 = this._list[i].bmp;
			bmp2.unlock();
		}
		
		return true;
	}

}

class GalaxyMc extends BasicObject
{
	private var _list:Array = null;
	private var _timer:JTimer = null;
	
	public function GalaxyMc()
	{
		super();
	}
	
	override protected function init():void
	{
		var i:int = 0;
		
		var src:GalaxyAni = GameAsset.loader.getAsset(GameAsset.KEY_GALAXY_ANI) as GalaxyAni;
		
		var bg:Quad = new Quad(src.width, src.height, 0x000020);
		this.container.addChild(bg.instance);
		
		var alphaList:Array = [];
		var alphaSum:Number = 0;
		for (i = 0; i < src.imageNum; i++)
		{
			var v:Number = Math.random();
			alphaList.push(v);
			alphaSum += v;
		}
		this._list = [];
		for (i = 0; i < src.imageNum; i++)
		{
			this._list.push({img: null, bmp: src.getImage(i), sum: Math.random() * 2 - 1, delta: Math.random() * 0.001, max: 4 * alphaList[i] / alphaSum});
		}
		
		for (i = 0; i < this._list.length; i++)
		{
			var bmp:BitmapData = this._list[i].bmp;
			var img:Bitmap = new Bitmap(bmp);
			this._list[i].img = img;
			img.alpha = Math.abs(this._list[i].sum) * this._list[i].max;
			this.container.addChild(img);
		}
		
		this._timer = new JTimer(this.onTime);
		this._timer.start();
	}
	
	private function onTime(p_delta:Number):void
	{
		for (var i:int = 0; i < this._list.length; i++)
		{
			var img:Bitmap = this._list[i].img;
			this._list[i].sum = (this._list[i].sum + this._list[i].delta * p_delta + 1) % 2 - 1;
			img.alpha = Math.abs(this._list[i].sum) * this._list[i].max;
		}
	}
	
	private function get container():Sprite
	{
		return (this.instance) as Sprite;
	}

}

class Galaxy extends BasicContainer
{
	private var _xCount:int = 0;
	private var _yCount:int = 0;
	
	public function Galaxy(p_data:Object)
	{
		super();
	}
	
	override public function resize(p_width:int, p_height:int):void
	{
		var i:int = 0;
		var src:GalaxyAni = GameAsset.loader.getAsset(GameAsset.KEY_GALAXY_ANI) as GalaxyAni;
		var img:GalaxyMc = null;
		var sp:Sprite = this.instance as Sprite;
		while (p_width > this._xCount * src.width)
		{
			for (i = 0; i < this._yCount; i++)
			{
				img = new GalaxyMc();
				img.instance.x = this._xCount * src.width;
				img.instance.y = i * src.height;
				this.addChild(img);
			}
			this._xCount++;
		}
		while (p_height > this._yCount * src.height)
		{
			for (i = 0; i < this._xCount; i++)
			{
				img = new GalaxyMc();
				img.instance.x = i * src.width;
				img.instance.y = this._yCount * src.height;
				this.addChild(img);
			}
			this._yCount++;
		}
	}

}

class Meteor extends BasicObject
{
	static public const RADIUS:int = 1000;
	
	private var _ballList:Array = null;
	private var _timer:JTimer = null;
	private var _img:Bitmap = null;
	
	public function Meteor(p_data:Object = null)
	{
		super();
	}
	
	override protected function init():void
	{
		this._ballList = [];
		
		this._img = new Bitmap(new BitmapData(RADIUS * 2, RADIUS * 2, true, 0));
		this._img.x = -RADIUS;
		this._img.y = -RADIUS;
		this.container.addChild(this._img);
		
		this._timer = new JTimer(this.onTime);
		this._timer.start();
	}
	
	private function get container():Sprite
	{
		return (this.instance) as Sprite;
	}
	
	private function onTime(p_delta:Number):void
	{
		var birthNum:int = 10;
		var maxNum:int = birthNum * 100;
		var minSpeed:Number = 1;
		var maxSpeed:Number = minSpeed + 5;
		
		var i:int = 0;
		for (i = 0; i < birthNum; i++)
		{
			var ball:Object = {};
			var vecSrc:Object = JMath.randSphereSurface();
			if (vecSrc.z < 0)
			{
				continue;
			}
			
			var pos:Vector3D = new Vector3D();
			var vec:Vector3D = new Vector3D(vecSrc.x, vecSrc.y, vecSrc.z);
			vec.multiplyEql(minSpeed + Math.random() * (maxSpeed - minSpeed));
			if (Math.random() > 0.5)
			{
				pos = new Vector3D(Math.random() * RADIUS * 2 - RADIUS, Math.random() * RADIUS * 2 - RADIUS, Math.random() * RADIUS * 2 - RADIUS);
				vec = new Vector3D();
			}
			ball.pos = pos;
			ball.vec = vec;
			this._ballList.push(ball);
		}
		
		while (this._ballList.length > maxNum)
		{
			this._ballList.shift();
		}
		
		for (i = 0; i < this._ballList.length; i++)
		{
			ball = this._ballList[i];
			pos = ball.pos;
			vec = ball.vec;
			pos.addEql(vec);
		}
		
		var bmp0:BitmapData = this._img.bitmapData;
		var bmp:BitmapData = new BitmapData(RADIUS * 2, RADIUS * 2, true, 0);
		bmp.lock();
		var ct:ColorTransform = new ColorTransform(0.9, 0.9, 0.9, 0.9);
		bmp.draw(bmp0, null, ct);
		for (i = 0; i < this._ballList.length; i++)
		{
			ball = this._ballList[i];
			pos = ball.pos;
			var r:int = 1;
			for (var x:int = -r; x <= r; x++)
			{
				for (var y:int = -r; y <= r; y++)
				{
					var colorSrc:uint = bmp.getPixel32(pos.x + RADIUS + x, pos.y + RADIUS + y);
					var color:JColor = JColor.createColorByHex(colorSrc);
					var a2:Number = 1 - Math.sqrt(x * x + y * y) / r;
					a2 *= 1 - (i + maxNum - this._ballList.length) / maxNum;
					color.addLight(Math.random() * 0.5 + 0.5, Math.random(), 1, a2);
					bmp.setPixel32(pos.x + RADIUS + x, pos.y + RADIUS + y, color.value);
				}
			}
		}
		bmp.unlock();
		this._img.bitmapData = bmp;
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