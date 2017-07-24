package com.pj
{
	import com.pj.common.component.BasicContainer;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class ProjectTest extends BasicContainer
	{
		public function ProjectTest(p_inst:Sprite = null)
		{
			super(null, p_inst);
		
		}
		
		override protected function init():void
		{
			super.init();
			var mov:Star = new Star(1024, 512);
			this.addChild(mov);
		}
	
	}
}

import com.pj.common.JColor;
import com.pj.common.JTimer;
import com.pj.common.component.BasicObject;
import com.pj.common.component.Quad;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

class Star extends BasicObject
{
	static private const IMG_NUM:int = 8;
	static private const STAR_NUM:int = 256;
	private var _width:int = 0;
	private var _height:int = 0;
	private var _list:Array = null;
	private var _timer:JTimer = null;
	
	public function Star(p_width:int, p_height:int)
	{
		this._width = p_width;
		this._height = p_height;
		super();
	}
	
	override protected function init():void
	{
		var i:int = 0;
		var j:int = 0;
		var k:int = 0;
		var m:int = 0;
		
		var bg:Quad = new Quad(this._width, this._height, 0x000044);
		this.container.addChild(bg.instance);
		
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
			this._list.push({img: null, bmp: bmp2, sum: Math.random() * 2 - 1, delta: Math.random() * 0.001, max: 4 * alphaList[i] / alphaSum});
		}
		
		for (k = 0; k < STAR_NUM; k++)
		{
			var numA:Number = int(-12 + Math.random() * 16);
			var numR:Number = int(5 + Math.random() * 5);
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
			var img:Bitmap = new Bitmap(bmp2);
			this._list[i].img = img;
			img.alpha = Math.abs(this._list[i].sum) * this._list[i].max;
			this.container.addChild(img);
		}
		
		this._timer = new JTimer(this.onTime);
		this._timer.start();
	}
	
	private function onTime(p_delta:Number):void
	{
		var alphaSum:Number
		for (var i:int = 0; i < this._list.length; i++)
		{
			var img:Bitmap = this._list[i].img;
			this._list[i].sum += this._list[i].delta * p_delta;
			if (this._list[i].sum > 1)
			{
				this._list[i].sum -= 2;
			}
			img.alpha = Math.abs(this._list[i].sum) * this._list[i].max;
		}
	}
	
	private function get container():Sprite
	{
		return (this.instance) as Sprite;
	}

}