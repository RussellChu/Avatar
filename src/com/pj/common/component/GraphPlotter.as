package com.pj.common.component
{
	import com.pj.common.component.BasicObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	
	/**
	 * ...
	 * @author Russell
	 */
	public class GraphPlotter extends BasicObject
	{
		private var _width:int = 0;
		private var _height:int = 0;
		private var _x0:int = 0;
		private var _x1:int = 0;
		private var _y0:int = 0;
		private var _y1:int = 0;
		
		public function GraphPlotter(p_width:int, p_height:int, p_x0:Number, p_x1:Number, p_y0:Number, p_y1:Number)
		{
			super();
			this._width = p_width;
			this._height = p_height;
			this._x0 = p_x0;
			this._x1 = p_x1;
			this._y0 = p_y0;
			this._y1 = p_y1;
		}
		
		private function get container():Sprite
		{
			return (this.instance as Sprite);
		}
		
		public function clearDraw():void
		{
			this.container.removeChildren();
		}
		
		public function drawByArr(p_arr:Array, p_color:uint = 0xff000000):void
		{
			if (!(p_arr) || this._width <= 0 || this._y1 == this._y0)
			{
				return;
			}
			if (p_arr.length <= 1)
			{
				return;
			}
			
			var sp:Sprite = new Sprite();
			var graphics:Graphics = sp.graphics;
			graphics.clear();
			graphics.lineStyle(1, p_color, 1);
			for (var i:int = 0; i < p_arr.length; i++)
			{
				var x:Number = this._width * i / (p_arr.length - 1);
				var y:Number = this._height * (1 - (p_arr[i] - this._y0) / (this._y1 - this._y0));
				if (i == 0)
				{
					graphics.moveTo(x, y);
				}
				else
				{
					graphics.lineTo(x, y);
				}
			}
			this.container.addChild(sp);
		}
		
		public function drawByPole(p_func:Function, p_a0:Number, p_a1:Number, p_step:Number):void
		{
			if (!(p_func) || p_a1 <= p_a0 || p_step <= 0)
			{
				return;
			}
			
			var sp:Sprite = new Sprite();
			var graphics:Graphics = sp.graphics;
			graphics.clear();
			graphics.lineStyle(1, 0xff000000, 1);
			var angle:Number = p_a0;
			while (angle <= p_a1)
			{
				var r:Number = p_func(angle);
				var x:Number = (1 + r * Math.cos(angle) / this._x0) * this._width * 0.5;
				var y:Number = (1 - r * Math.sin(angle) / this._x0) * this._width * 0.5;
				if (angle == p_a0)
				{
					graphics.moveTo(x, y);
				}
				else
				{
					graphics.lineTo(x, y);
				}
				if (angle == p_a1)
				{
					break;
				}
				angle += p_step;
				if (angle == p_a1)
				{
					angle = p_a1;
				}
			}
			this.container.addChild(sp);
		}
		
		public function drawByX(p_func:Function, p_color:uint = 0xff000000):void
		{
			if (!(p_func) || this._width <= 0 || this._y1 == this._y0)
			{
				return;
			}
			
			var sp:Sprite = new Sprite();
			var graphics:Graphics = sp.graphics;
			graphics.clear();
			graphics.lineStyle(1, p_color, 1);
			for (var i:int = 0; i < this._width; i++)
			{
				var x:Number = this._x0 + (this._x1 - this._x0) * i / this._width;
				var y:Number = p_func(x);
				var j:int = this._height - this._height * (y - this._y0) / (this._y1 - this._y0);
				if (i == 0)
				{
					graphics.moveTo(i, j);
				}
				else
				{
					graphics.lineTo(i, j);
				}
			}
			this.container.addChild(sp);
		}
	
	}

}