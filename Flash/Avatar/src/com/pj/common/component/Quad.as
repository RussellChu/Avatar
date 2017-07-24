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
		private var _color:uint = 0;
		
		public function Quad(p_width:int, p_height:int, p_color:uint = 0)
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
			this._color = p_color;
			super();
		}
		
		override protected function init ():void {
			super.init();
			var bg:Shape = new Shape();
			bg.width = 1;
			bg.height = 1;
			bg.graphics.beginFill(this._color, 1);
			bg.graphics.drawRect(0, 0, 1, 1);
			bg.graphics.endFill();
			bg.scaleX = this._width;
			bg.scaleY = this._height;
			var sp:Sprite = this.instance as Sprite;
			sp.addChild(bg);
		}
		
		public function resize(p_width:int, p_height:int):void {
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
			var sp:Sprite = this.instance as Sprite;
			if (sp.numChildren == 0) {
				return;
			}
			var bg:Shape = sp.getChildAt(0) as Shape;
			if (!bg) {
				return;
			}
			bg.scaleX = this._width;
			bg.scaleY = this._height;
		}
	
	}
}