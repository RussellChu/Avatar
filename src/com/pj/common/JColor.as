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
			var a:uint = ((p_value & 0xff000000) >> 24) & 0xff;
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
		
		public function addOver(p_r:Number, p_g:Number, p_b:Number, p_a:Number):JColor {
			var addR:Number = JMath.bound(p_r, 0, 1);
			var addG:Number = JMath.bound(p_g, 0, 1);
			var addB:Number = JMath.bound(p_b, 0, 1);
			var addA:Number = JMath.bound(p_a, 0, 1);
			var newA:Number = this.a + addA - this.a * addA;
			if (newA <= 0) {
				this.r = 0;
				this.g = 0;
				this.b = 0;
				this.a = 0;
				return this;
			}
			var invA:Number = 1 / newA;
			this.r = (addR * addA + this.r * this.a * (1 - addA)) * invA;
			this.g = (addG * addA + this.g * this.a * (1 - addA)) * invA;
			this.b = (addB * addA + this.b * this.a * (1 - addA)) * invA;
			this.a = newA;
			return this;
		}
		
		public function addLight(p_r:Number, p_g:Number, p_b:Number, p_a:Number):JColor {
			if (p_a <= 0) {
				return this;
			}
			
			if (this.a <= 0) {
				this.r = p_r;
				this.g = p_g;
				this.b = p_b;
				this.a = p_a;
				return this;
			}
			
			var addR:Number = JMath.bound(p_r, 0, 1);
			var addG:Number = JMath.bound(p_g, 0, 1);
			var addB:Number = JMath.bound(p_b, 0, 1);
			var addA:Number = JMath.bound(p_a, 0, 1);
			
			var baseR:Number = this.r;
			var baseG:Number = this.g;
			var baseB:Number = this.b;
			var baseA:Number = this.a;
			
			if (addA > baseA) {
				baseR = addR;
				baseG = addG;
				baseB = addB;
				baseA = addA;
				
				addR = this.r;
				addG = this.g;
				addB = this.b;
				addA = this.a;
			}
			
			var ratio:Number = addA / baseA;
			addR *= ratio;
			addG *= ratio;
			addB *= ratio;
			
			baseR += addR;
			baseG += addG;
			baseB += addB;
			
			ratio = 1;
			if (baseR > ratio) {
				ratio = baseR;
			}
			if (baseG > ratio) {
				ratio = baseG;
			}
			if (baseB > ratio) {
				ratio = baseB;
			}
			if ( baseA * ratio > 1 ) {
				ratio = 1 / baseA;
			}
			baseR /= ratio;
			baseG /= ratio;
			baseB /= ratio;
			baseA *= ratio;
			if (baseR > 1) {
				baseR = 1;
			}
			if (baseG > 1) {
				baseG = 1;
			}
			if (baseB > 1) {
				baseB = 1;
			}
			
			this.r = baseR;
			this.g = baseG;
			this.b = baseB;
			this.a = baseA;
			
			return this;
		}
		
		public function clone():JColor
		{
			return new JColor(this.r, this.g, this.b, this.a);
		}
		
		public function toString():String
		{
			return "(" + this.r + ", " + this.g + ", " + this.b + ", " + this.a + ")";
		}
		
		public function get value():uint
		{
			return JColor.setRGBA(this.r, this.g, this.b, this.a);
		}
		
		public function get luma():Number
		{
			return 0.299 * this.r + 0.587 * this.g + 0.114 * this.b;
		}
	
	}
}