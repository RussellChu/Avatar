package com.pj.common.math
{
	
	/**
	 * ...
	 * @author Russell
	 */
	public class Matrix4D
	{
		public var e:Array = null;
		
		public function Matrix4D():void
		{
			this.e = [];
			this.e.push([0, 0, 0, 0]);
			this.e.push([0, 0, 0, 0]);
			this.e.push([0, 0, 0, 0]);
			this.e.push([0, 0, 0, 0]);
		}
		
		public function cloneFrom(p_mx:Matrix4D):Matrix4D
		{
			for (var i:int = 0; i <= 3; i++)
			{
				for (var j:int = 0; j <= 3; j++)
				{
					this.e[i][j] = p_mx.e[i][j];
				}
			}
			return this;
		}
		
		public function setIdentity():Matrix4D
		{
			this.e = [];
			this.e.push([1, 0, 0, 0]);
			this.e.push([0, 1, 0, 0]);
			this.e.push([0, 0, 1, 0]);
			this.e.push([0, 0, 0, 1]);
			return this;
		}
		
		public function setRandom():Matrix4D
		{
			for (var i:int = 0; i <= 3; i++)
			{
				for (var j:int = 0; j <= 3; j++)
				{
					this.e[i][j] = Math.random();
				}
			}
			return this;
		}
		
		public function setRotateX(p_theta:Number):Matrix4D
		{
			var c:Number = Math.cos(p_theta);
			var s:Number = Math.sin(p_theta);
			this.e = [];
			this.e.push([1, 0, 0, 0]);
			this.e.push([0, c, -s, 0]);
			this.e.push([0, s, c, 0]);
			this.e.push([0, 0, 0, 1]);
			return this;
		}
		
		public function setRotateY(p_theta:Number):Matrix4D
		{
			var c:Number = Math.cos(p_theta);
			var s:Number = Math.sin(p_theta);
			this.e = [];
			this.e.push([c, 0, s, 0]);
			this.e.push([0, 1, 0, 0]);
			this.e.push([-s, 0, c, 0]);
			this.e.push([0, 0, 0, 1]);
			return this;
		}
		
		public function setRotateZ(p_theta:Number):Matrix4D
		{
			var c:Number = Math.cos(p_theta);
			var s:Number = Math.sin(p_theta);
			this.e = [];
			this.e.push([c, -s, 0, 0]);
			this.e.push([s, c, 0, 0]);
			this.e.push([0, 0, 1, 0]);
			this.e.push([0, 0, 0, 1]);
			return this;
		}
		
		public function setTranslate(p_vtr:Vector3D):Matrix4D
		{
			this.e = [];
			this.e.push([1, 0, 0, p_vtr.x]);
			this.e.push([0, 1, 0, p_vtr.y]);
			this.e.push([0, 0, 1, p_vtr.z]);
			this.e.push([0, 0, 0, 1]);
			return this;
		}
		
		public function product(p_mx:Matrix4D):Matrix4D
		{
			var result:Matrix4D = new Matrix4D();
			for (var i:int = 0; i <= 3; i++)
			{
				for (var j:int = 0; j <= 3; j++)
				{
					result.e[i][j] = this.e[0][j] * p_mx.e[i][0] + this.e[1][j] * p_mx.e[i][1] + this.e[2][j] * p_mx.e[i][2] + this.e[3][j] * p_mx.e[i][3];
				}
			}
			return result;
		}
		
		public function productEqual(p_mx:Matrix4D):Matrix4D
		{
			return this.cloneFrom(this.product(p_mx));
		}
		
		public function inverse3x3():Matrix4D
		{
			var result:Matrix4D = new Matrix4D();
			var det:Number = 0;
			var i:int = 0;
			var j:int = 0;
			for (i = 0; i <= 2; i++)
			{
				det += this.e[0][i] * (this.e[1][(i + 1) % 3] * this.e[2][(i + 2) % 3] - this.e[1][(i + 2) % 3] * this.e[2][(i + 1) % 3]);
			}
			if (det == 0)
			{
				return result;
			}
			var invDet:Number = 1 / det;
			for (i = 0; i <= 2; i++)
			{
				for (j = 0; j <= 2; j++)
				{
					result.e[j][i] = ((this.e[(i + 1) % 3][(j + 1) % 3] * this.e[(i + 2) % 3][(j + 2) % 3]) - (this.e[(i + 1) % 3][(j + 2) % 3] * this.e[(i + 2) % 3][(j + 1) % 3])) * invDet;
				}
			}
			result.e[3][3] = 1;
			return result;
		}
		
		/*
		 *  (x,y,z,w) * M -> (x',y',z',w')
		 */
		public function transform(p_vtr:Vector4D):Vector4D
		{
			var vtr:Vector4D = new Vector4D();
			vtr.x = p_vtr.x * this.e[0][0] + p_vtr.y * this.e[0][1] + p_vtr.z * this.e[0][2] + p_vtr.w * this.e[0][3];
			vtr.y = p_vtr.x * this.e[1][0] + p_vtr.y * this.e[1][1] + p_vtr.z * this.e[1][2] + p_vtr.w * this.e[1][3];
			vtr.z = p_vtr.x * this.e[2][0] + p_vtr.y * this.e[2][1] + p_vtr.z * this.e[2][2] + p_vtr.w * this.e[2][3];
			vtr.w = p_vtr.x * this.e[3][0] + p_vtr.y * this.e[3][1] + p_vtr.z * this.e[3][2] + p_vtr.w * this.e[3][3];
			return vtr;
		}
		
		public function printSelf():void
		{
			trace("print");
			var str:String = "";
			str = "" + this.e[0][0] + ", " + this.e[1][0] + ", " + this.e[2][0] + ", " + this.e[3][0];
			trace(str);
			str = "" + this.e[0][1] + ", " + this.e[1][1] + ", " + this.e[2][1] + ", " + this.e[3][1];
			trace(str);
			str = "" + this.e[0][2] + ", " + this.e[1][2] + ", " + this.e[2][2] + ", " + this.e[3][2];
			trace(str);
			str = "" + this.e[0][3] + ", " + this.e[1][3] + ", " + this.e[2][3] + ", " + this.e[3][3];
			trace(str);
		}
	
	}
}