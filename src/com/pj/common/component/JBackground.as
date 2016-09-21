package com.pj.common.component
{
	import com.pj.common.component.BasicObject;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class JBackground extends BasicObject
	{
		private var _bmp:BitmapData = null;
		private var _xCount:int = 0;
		private var _yCount:int = 0;
		
		public function JBackground(p_bmp:BitmapData)
		{
			this._bmp = p_bmp;
			super();
		}
		
		override public function dispose():void {
			this._bmp = null;
			super.dispose();
		}
		
		public function resize(p_width:int, p_height:int):void
		{
			var i:int = 0;
			var img:Bitmap = null;
			var sp:Sprite = this.instance as Sprite;
			while (p_width > this._xCount * this._bmp.width)
			{
				for (i = 0; i < this._yCount; i++)
				{
					img = new Bitmap(this._bmp);
					img.x = this._xCount * this._bmp.width;
					img.y = i * this._bmp.height;
					sp.addChild(img);
				}
				this._xCount++;
			}
			while (p_height > this._yCount * this._bmp.height)
			{
				for (i = 0; i < this._xCount; i++)
				{
					img = new Bitmap(this._bmp);
					img.x = i * this._bmp.width;
					img.y = this._yCount * this._bmp.height;
					sp.addChild(img);
				}
				this._yCount++;
			}
		}
	
	}
}