package com.pj.macross.asset
{
	import com.pj.common.Creater;
	import com.pj.common.ICreatable;
	import com.pj.common.JColor;
	import com.pj.common.JSignal;
	import com.pj.macross.GameAsset;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class CellSkin implements ICreatable
	{
		static public const IMG_DOWN:int = 1;
		static public const IMG_BLANK:int = 2;
		static public const IMG_OVER:int = 3;
		static public const IMG_BASE_0:int = 4;
		static public const IMG_BASE_1:int = 5;
		static public const IMG_BASE_2:int = 6;
		static public const IMG_ROAD_0:int = 7;
		static public const IMG_ROAD_1:int = 8;
		static public const IMG_ROAD_2:int = 9;
		static public const IMG_FOLD:int = 10;
		static public const IMG_ATTACK:int = 11;
		static public const IMG_HOSTAGE:int = 12;
		static public const IMG_OBSTACLE:int = 13;
		
		private var _bmpDown:BitmapData = null;
		private var _bmpIdle:BitmapData = null;
		private var _bmpOver:BitmapData = null;
		private var _bmpIdleBase0:BitmapData = null;
		private var _bmpIdleBase1:BitmapData = null;
		private var _bmpIdleBase2:BitmapData = null;
		private var _bmpIdleRoad0:BitmapData = null;
		private var _bmpIdleRoad1:BitmapData = null;
		private var _bmpIdleRoad2:BitmapData = null;
		private var _bmpIdleAttack:BitmapData = null;
		private var _bmpFold:BitmapData = null;
		private var _bmpIdleObstacle:BitmapData = null;
		private var _bmpHostageList:Array = null;
		
		private var _width:int = 0;
		private var _height:int = 0;
		private var _margin:int = 0;
		private var _creater:Creater = null;
		private var _signal:JSignal = null;
		
		public function CellSkin(p_width:int, p_height:int, p_margin:int)
		{
			this._width = p_width;
			this._height = p_height;
			this._margin = p_margin;
			this._creater = new Creater(this);
			this._signal = new JSignal();
		}
		
		public function get creater():Creater
		{
			return this._creater;
		}
		
		public function onCreate():void
		{
			var colorDown:uint = new JColor(0, 1, 1, 0.5).value;
			var colorIdle:uint = new JColor(0.5, 0.5, 0.5, 0.5).value;
			var colorOver:uint = new JColor(1, 1, 0, 0.5).value;
			var colorBase0:uint = new JColor(1, 0.411, 0.411, 1).value;
			var colorBase1:uint = new JColor(0, 1, 0, 1).value;
			var colorBase2:uint = new JColor(0.534, 0.534, 1, 1).value;
			var colorRoad0:uint = new JColor(1, 0, 0, 1).value;
			var colorRoad1:uint = new JColor(0, 0.509, 0, 1).value;
			var colorRoad2:uint = new JColor(0.209, 0.209, 1, 1).value;
			var colorAttack:uint = new JColor(0.967, 0.673, 0.9055, 0.5).value;
			var colorObstacle:uint = new JColor(0.286, 0.0485, 0, 0.5).value;
			
			this._bmpDown = new BitmapData(this._width, this._height, true, 0);
			this._bmpIdle = new BitmapData(this._width, this._height, true, 0);
			this._bmpOver = new BitmapData(this._width, this._height, true, 0);
			this._bmpIdleBase0 = new BitmapData(this._width, this._height, true, 0);
			this._bmpIdleBase1 = new BitmapData(this._width, this._height, true, 0);
			this._bmpIdleBase2 = new BitmapData(this._width, this._height, true, 0);
			this._bmpIdleRoad0 = new BitmapData(this._width, this._height, true, 0);
			this._bmpIdleRoad1 = new BitmapData(this._width, this._height, true, 0);
			this._bmpIdleRoad2 = new BitmapData(this._width, this._height, true, 0);
			this._bmpIdleAttack = new BitmapData(this._width, this._height, true, 0);
			this._bmpIdleObstacle = new BitmapData(this._width, this._height, true, 0);
			this._bmpDown.lock();
			this._bmpIdle.lock();
			this._bmpOver.lock();
			this._bmpIdleBase0.lock();
			this._bmpIdleBase1.lock();
			this._bmpIdleBase2.lock();
			this._bmpIdleRoad0.lock();
			this._bmpIdleRoad1.lock();
			this._bmpIdleRoad2.lock();
			this._bmpIdleAttack.lock();
			this._bmpIdleObstacle.lock();
			
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
					
					if (funcHex(this._margin))
					{
						this._bmpDown.setPixel32(i, j, colorDown);
						this._bmpIdle.setPixel32(i, j, colorIdle);
						this._bmpOver.setPixel32(i, j, colorOver);
						this._bmpIdleBase0.setPixel32(i, j, colorBase0);
						this._bmpIdleBase1.setPixel32(i, j, colorBase1);
						this._bmpIdleBase2.setPixel32(i, j, colorBase2);
						this._bmpIdleObstacle.setPixel32(i, j, colorObstacle);
					}
					
					if (funcHex(this._height * 0.1875))
					{
						this._bmpIdleRoad0.setPixel32(i, j, colorRoad0);
						this._bmpIdleRoad1.setPixel32(i, j, colorRoad1);
						this._bmpIdleRoad2.setPixel32(i, j, colorRoad2);
					}
					
					// var a:Number = this._width * 0.2; // max
					var a:Number = this._width * 0.1;
					var k:int = 0;
					var s:int = 6;
					var sum:int = 0;
					for (k = 0; k < s; k++)
					{
						sum += ((Math.cos(Math.PI * (2 / s * k - 0.5)) * (i - this._width * 0.5) + Math.sin(Math.PI * (2 / s * k - 0.5)) * (j - this._height * 0.5) < a) ? 1 : 0);
					}
					if (sum == s - 1)
					{
						this._bmpIdleRoad0.setPixel32(i, j, colorBase0);
						this._bmpIdleRoad1.setPixel32(i, j, colorBase1);
						this._bmpIdleRoad2.setPixel32(i, j, colorBase2);
					}
					
					a = this._width * 0.2;
					sum = 0;
					for (k = 0; k < s; k++)
					{
						sum += ((Math.cos(Math.PI * (2 / s * k)) * (i - this._width * 0.5) + Math.sin(Math.PI * (2 / s * k)) * (j - this._height * 0.5) < a) ? 1 : 0);
					}
					if (sum == s - 1)
					{
						this._bmpIdleAttack.setPixel32(i, j, colorAttack);
					}
				}
			}
			this._bmpDown.unlock();
			this._bmpIdle.unlock();
			this._bmpOver.unlock();
			this._bmpIdleBase0.unlock();
			this._bmpIdleBase1.unlock();
			this._bmpIdleBase2.unlock();
			this._bmpIdleRoad0.unlock();
			this._bmpIdleRoad1.unlock();
			this._bmpIdleRoad2.unlock();
			this._bmpIdleAttack.unlock();
			this._bmpIdleObstacle.unlock();
			
			this._bmpHostageList = [];
			this._bmpHostageList.push({key: "s01", bmp: null});
			this._bmpHostageList.push({key: "s02", bmp: null});
			this._bmpHostageList.push({key: "s03", bmp: null});
			this._bmpHostageList.push({key: "s04", bmp: null});
			this._bmpHostageList.push({key: "s05", bmp: null});
			this._bmpHostageList.push({key: "s06", bmp: null});
			this._bmpHostageList.push({key: "s07", bmp: null});
			this._bmpHostageList.push({key: "s08", bmp: null});
			
			var ratio:Number = 0;
			var mx:Matrix = null;
			
			for (i = 0; i < this._bmpHostageList.length; i++)
			{
				var hostage:Bitmap = GameAsset.loader.getAsset(this._bmpHostageList[i].key) as Bitmap;
				var bmpHostage:BitmapData = new BitmapData(this._width, this._height, true, 0);
				ratio = this._height / hostage.height;
				mx = new Matrix();
				mx.scale(ratio, ratio);
				mx.translate((this._width - hostage.width * this._height / hostage.height) * 0.5, 0);
				bmpHostage.lock();
				bmpHostage.draw(hostage.bitmapData, mx);
				bmpHostage.unlock();
				this._bmpHostageList[i].bmp = bmpHostage;
			}
			
			var imgFold:Bitmap = GameAsset.loader.getAsset("fold") as Bitmap;
			this._bmpFold = new BitmapData(this._width, this._height, true, 0);
			ratio = this._height / imgFold.height;
			mx = new Matrix();
			mx.scale(ratio, ratio);
			mx.translate((this._width - imgFold.width * this._height / imgFold.height) * 0.5, 0);
			this._bmpFold.lock();
			this._bmpFold.draw(imgFold.bitmapData, mx);
			this._bmpFold.unlock();
		}
		
		public function get signal():JSignal
		{
			return this._signal;
		}
		
		public function get width():int
		{
			return this._width;
		}
		
		public function get height():int
		{
			return this._height;
		}
		
		public function getBitmap(p_id:int):BitmapData
		{
			switch (p_id)
			{
			case IMG_DOWN: 
				return this._bmpDown;
			case IMG_BLANK: 
				return this._bmpIdle;
			case IMG_OVER: 
				return this._bmpOver;
			case IMG_BASE_0: 
				return this._bmpIdleBase0;
			case IMG_BASE_1: 
				return this._bmpIdleBase1;
			case IMG_BASE_2: 
				return this._bmpIdleBase2;
			case IMG_ROAD_0: 
				return this._bmpIdleRoad0;
			case IMG_ROAD_1: 
				return this._bmpIdleRoad1;
			case IMG_ROAD_2: 
				return this._bmpIdleRoad2;
			case IMG_FOLD: 
				return this._bmpFold;
			case IMG_ATTACK: 
				return this._bmpIdleAttack;
			case IMG_HOSTAGE: 
				return this._bmpHostageList[int(Math.random() * this._bmpHostageList.length)].bmp as BitmapData;
			case IMG_OBSTACLE: 
				return this._bmpIdleObstacle;
			default: 
				return null;
			}
		}
	
	}
}