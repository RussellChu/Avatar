package com.pj.common.math
{
	
	/**
	 * ...
	 * @author Russell
	 */
	public class Vector2D
	{
		public var x:Number = 0;
		public var y:Number = 0;
		
		public function Vector2D(p_x:Number = 0, p_y:Number = 0):void
		{
			this.x = p_x;
			this.y = p_y;
		}
		
		public function clone():Vector2D
		{
			return new Vector2D(this.x, this.y);
		}
	
	}

}