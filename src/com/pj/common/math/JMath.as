package com.pj.common.math
{
	
	/**
	 * ...
	 * @author Russell
	 */
	public class JMath
	{
		
		static public function bound(p_value:Number, p_b0:Number, p_b1:Number):Number
		{
			var b0:Number = p_b0;
			var b1:Number = p_b1;
			if (b0 > b1)
			{
				b0 = p_b1;
				b1 = p_b0;
			}
			if (p_value < b0)
			{
				return b0;
			}
			if (p_value > b1)
			{
				return b1;
			}
			return p_value;
		}
		
		static public function ratio(p_value:Number, p_from:Number, p_to:Number):Number {
			if (p_from == p_to) {
				return 0;
			}
			
			return (p_value - p_from) / (p_to - p_from);
		}
		
		static public function randCirleArea():Object
		{
			var v0:Number = Math.random();
			var r:Number = Math.sqrt(v0);
			var result:Object = randCirlePerimeter();
			return {x: result.x * r, y: result.y * r, z: 0};
		}
		
		static public function randCirlePerimeter():Object
		{
			var v0:Number = Math.random();
			var x:Number = Math.sin(v0 * Math.PI * 2);
			var y:Number = Math.cos(v0 * Math.PI * 2);
			return {x: x, y: y, z: 0};
		}
		
		static public function randSphereSurface():Object
		{
			var v0:Number = Math.random();
			var z:Number = v0 * 2 - 1;
			var r:Number = Math.sqrt(1 - z * z);
			var result:Object = randCirlePerimeter();
			return {x: result.x * r, y: result.y * r, z: z};
		}
		
		static public function randSphereVolume():Object
		{
			var v0:Number = Math.random();
			var r:Number = Math.pow(v0, 1 / 3);
			var result:Object = randSphereSurface();
			return {x: result.x * r, y: result.y * r, z: result.z * r};
		}
		
		public function JMath()
		{
			;
		}
	
	}
}