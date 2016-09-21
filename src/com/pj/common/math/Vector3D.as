package com.pj.common.math
{
	
	/**
	 * ...
	 * @author Russell
	 */
	public class Vector3D
	{
		public var x:Number = 0;
		public var y:Number = 0;
		public var z:Number = 0;
		
		public function Vector3D(p_x:Number = 0, p_y:Number = 0, p_z:Number = 0)
		{
			this.x = p_x;
			this.y = p_y;
			this.z = p_z;
		}
		
		public function clone():Vector3D
		{
			return new Vector3D(this.x, this.y, this.z);
		}
		
		public function clone4(p_w:Number = 0):Vector4D
		{
			return new Vector4D(this.x, this.y, this.z, p_w);
		}
		
		public function cloneFrom(p_vtr:Vector3D):Vector3D
		{
			this.x = p_vtr.x;
			this.y = p_vtr.y;
			this.z = p_vtr.z;
			return this;
		}
		
		public function lengthStr():Number
		{
			return this.x * this.x + this.y * this.y + this.z * this.z;
		}
		
		public function normal():Vector3D
		{
			var result:Vector3D = new Vector3D();
			var lenStr:Number = this.lengthStr();
			if (lenStr > 0)
			{
				var factor:Number = 1 / Math.sqrt(lenStr);
				result.x = this.x * factor;
				result.y = this.y * factor;
				result.z = this.z * factor;
			}
			return result;
		}
		
		public function negative():Vector3D
		{
			return new Vector3D(-this.x, -this.y, -this.z);
		}
		
		public function add(p_vtr:Vector3D):Vector3D
		{
			return new Vector3D(this.x + p_vtr.x, this.y + p_vtr.y, this.z + p_vtr.z);
		}
		
		public function minus(p_vtr:Vector3D):Vector3D
		{
			return new Vector3D(this.x - p_vtr.x, this.y - p_vtr.y, this.z - p_vtr.z);
		}
		
		public function multiply(p_value:Number):Vector3D
		{
			return new Vector3D(this.x * p_value, this.y * p_value, this.z * p_value);
		}
		
		public function divide(p_value:Number):Vector3D
		{
			var invM:Number = 0;
			if (p_value != 0)
			{
				invM = 1 / p_value;
			}
			return this.multiply(invM);
		}
		
		public function addEql(p_vtr:Vector3D):Vector3D
		{
			return this.cloneFrom(this.add(p_vtr));
		}
		
		public function minusEql(p_vtr:Vector3D):Vector3D
		{
			return this.cloneFrom(this.minus(p_vtr));
		}
		
		public function multiplyEql(p_value:Number):Vector3D
		{
			return this.cloneFrom(this.multiply(p_value));
		}
		
		public function divideEql(p_value:Number):Vector3D
		{
			return this.cloneFrom(this.divide(p_value));
		}
		
		public function dot(p_vtr:Vector3D):Number
		{
			return this.x * p_vtr.x + this.y * p_vtr.y + this.z * p_vtr.z;
		}
		
		public function cross(p_vtr:Vector3D):Vector3D
		{
			var result:Vector3D = new Vector3D();
			result.x = this.y * p_vtr.z - this.z * p_vtr.y;
			result.y = this.z * p_vtr.x - this.x * p_vtr.z;
			result.z = this.x * p_vtr.y - this.y * p_vtr.x;
			return result;
		}
	
	}
}