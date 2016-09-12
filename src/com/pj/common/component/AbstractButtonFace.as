package com.pj.common.component 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class AbstractButtonFace extends BasicObject 
	{
		
		public function AbstractButtonFace() 
		{
			super();
		}
		
		protected function get container():Sprite {
			return this.instance as Sprite;
		}
		
	}

}