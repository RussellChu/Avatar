package com.pj.common.component
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class BasicButtonFace extends BasicObject
	{
		protected var _imgDefault:Bitmap = null;
		
		public function BasicButtonFace(p_bmp:BitmapData = null)
		{
			if (p_bmp)
			{
				this._imgDefault = new Bitmap(p_bmp);
			}
			super();
		}
		
		override public function dispose():void
		{
			this._imgDefault = null;
			super.dispose();
		}
		
		override protected function init():void
		{
			super.init();
			if (this._imgDefault)
			{
				this.container.addChild(this._imgDefault);
			}
		}
		
		protected function get container():Sprite
		{
			return this.instance as Sprite;
		}
		
		protected function showImage(p_img:DisplayObject):void {
			for (var i:int = 0; i < this.container.numChildren; i++) {
				var item:DisplayObject = this.container.getChildAt(i);
				item.visible = (item == p_img);
			}
		}
	
	}
}