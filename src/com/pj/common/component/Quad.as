package com.pj.common.component
{
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class Quad extends BasicObject
	{
		private var _width:int = 0;
		private var _height:int = 0;
		
		public function Quad(p_width:int, p_height:int, p_color:uint)
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
		
		override protected init ():void {
			var bg:Shape = new Shape();
			bg.width = 1;
			bg.height = 1;
			bg.graphics.beginFill(p_color, 1);
			bg.graphics.drawRect(0, 0, 1, 1);
			bg.graphics.endFill();
			bg.scaleX = this._width;
			bg.scaleY = this._height;
			var sp:Sprite = this.instance as Sprite;
			sp.addChild(bg);
		}
	
	}
}