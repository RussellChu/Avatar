package com.pj.common
{
	import com.pj.common.math.JMath;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class JColor
	{
		static public function setRGBA(p_r:Number, p_g:Number, p_b:Number, p_a:Number):uint
		{
			var r:int = JMath.bound(p_r * 255, 0, 255);
			var g:int = JMath.bound(p_g * 255, 0, 255);
			var b:int = JMath.bound(p_b * 255, 0, 255);
			var a:int = JMath.bound(p_a * 255, 0, 255);
			return (0x1000000 * a) | (0x10000 * r) | (0x100 * g) | b;
		}
		
		static public function setRGBAByInt(p_r:uint, p_g:uint, p_b:uint, p_a:uint):uint
		{
			var r:int = JMath.bound(p_r, 0, 255);
			var g:int = JMath.bound(p_g, 0, 255);
			var b:int = JMath.bound(p_b, 0, 255);
			var a:int = JMath.bound(p_a, 0, 255);
			return (0x1000000 * a) | (0x10000 * r) | (0x100 * g) | b;
		}
		
		static public function createColorByHex(p_value:uint):JColor
		{
			var a:uint = (p_value & 0xff000000) >> 24;
			var r:uint = (p_value & 0xff0000) >> 16;
			var g:uint = (p_value & 0xff00) >> 8;
			var b:uint = (p_value & 0xff);
			var inv:Number = 1 / 255;
			return new JColor(r * inv, g * inv, b * inv, a * inv);
		}
		
		public var r:Number = 0;
		public var g:Number = 0;
		public var b:Number = 0;
		public var a:Number = 0;
		
		public function JColor(p_r:Number, p_g:Number, p_b:Number, p_a:Number)
		{
			this.r = p_r;
			this.g = p_g;
			this.b = p_b;
			this.a = p_a;
		}
		
		public function clone():JColor
		{
			return new JColor(this.r, this.g, this.b, this.a);
		}
		
		public function toString():String {
			return "(" + this.r + ", " + this.g + ", " + this.b + ", " + this.a + ")";
		}
		
		public function get value():uint
		{
			return JColor.setRGBA(this.r, this.g, this.b, this.a);
		}
	
	}
}