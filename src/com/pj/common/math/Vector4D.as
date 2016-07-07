package com.pj.common.math
{
	
	/**
	 * ...
	 * @author Russell
	 */
	public class Vector4D
	{
		public var x:Number = 0;
		public var y:Number = 0;
		public var z:Number = 0;
		public var w:Number = 0;
		
		public function Vector4D(p_x:Number = 0, p_y:Number = 0, p_z:Number = 0, p_w:Number = 0):void
		{
			this.x = p_x;
			this.y = p_y;
			this.z = p_z;
			this.w = p_w;
		}
		
		public function clone():Vector4D
		{
			return new Vector4D(this.x, this.y, this.z, this.w);
		}
		
		public function clone3():Vector3D
		{
			var invW:Number = 0;
			if (this.w != 0)
			{
				invW = 1 / this.w;
			}
			return new Vector3D(this.x * invW, this.y * invW, this.z * invW);
		}
		
		public function multiply(p_value:Number):Vector4D
		{
			return new Vector4D(this.x * p_value, this.y * p_value, this.z * p_value, this.w * p_value);
		}
		
		public function divide(p_value:Number):Vector4D
		{
			var invM:Number = 0;
			if (p_value != 0)
			{
				invM = 1 / p_value;
			}
			return this.multiply(invM);
		}
	
	}
}