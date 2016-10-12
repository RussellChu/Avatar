package com.pj.common.component
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class BasicSkin extends BasicObject
	{
		public function BasicSkin()
		{
			super();
		}
		
		override public function dispose():void
		{
			super.dispose();
		}
		
		override protected function init():void
		{
			super.init();
			//this.container.mouseEnabled = false;
			//this.container.mouseChildren = false;
		}
		
		override public function clear():void
		{
			super.clear();
		}
		
		override public function reset():void
		{
			super.reset();
		}
		
		protected function get container():Sprite
		{
			return this.instance as Sprite;
		}
		
		public function show(p_id:int):void
		{
			;
		}
	
	}
}