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
		
		public function Quad(p_width:int, p_height:int, p_color:uint)
		{
			super();
			
			var width:int = p_width;
			var height:int = p_height;
			if (width < 0)
			{
				width = 0;
			}
			if (height < 0)
			{
				height = 0;
			}
			
			var bg:Shape = new Shape();
			bg.width = 1;
			bg.height = 1;
			bg.graphics.beginFill(p_color, 1);
			bg.graphics.drawRect(0, 0, 1, 1);
			bg.graphics.endFill();
			bg.scaleX = width;
			bg.scaleY = height;
			var sp:Sprite = this.instance as Sprite;
			sp.addChild(bg);
		}
	
	}

}