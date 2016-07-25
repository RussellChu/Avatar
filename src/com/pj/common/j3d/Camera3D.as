package com.pj.common.j3d
{
	import com.pj.common.math.Matrix4D;
	import com.pj.common.math.Vector3D;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class Camera3D
	{
		public static const MODE_ORTHOGONAL:int = 0;
		public static const MODE_PERSPECTIVE:int = 1;
		
		private var _mode:int = 0;
		private var _target:Vector3D = null;
		private var _pos:Vector3D = null;
		private var _up:Vector3D = null;
		private var _planeDepth:Number = 0; // dist between near plane and far plane
		private var _planeDist:Number = 0; // near plane
		private var _planeWidth:Number = 0; // near plane radius
		private var _screenWidth:Number = 0; // screen radius
		private var _screenHeight:Number = 0; // screen radius
		
		public function Camera3D(p_pos:Vector3D = null, p_target:Vector3D = null, p_up:Vector3D = null):void
		{
			this._pos = p_pos;
			this._target = p_target;
			this._up = p_up;
			if (!this._pos)
			{
				this._pos = new Vector3D();
			}
			if (!this._target)
			{
				this._target = new Vector3D();
			}
			if (!this._up)
			{
				this._up = new Vector3D();
			}
		}
		
		public function move(p_pos:Vector3D):void
		{
			this._pos.addEql(p_pos);
			this._target.addEql(p_pos);
		}
		
		// Rotate by _target and _up
		public function rotateByX(p_theta:Number):void
		{
			var front:Vector3D = this._target.minus(this._pos).normal();
			var left:Vector3D = this._up.cross(front);
			var mx:Matrix4D = new Matrix4D().setRotate(p_theta, left);
			var pos:Vector3D = this._target.minus(mx.transform(this._target.minus(this._pos).clone4(1)).clone3());
			this._pos = pos;
			this._up = mx.transform(this._up.clone4(1)).clone3();
		}
		
		public function rotateByY(p_theta:Number):void
		{
			var mx:Matrix4D = new Matrix4D().setRotate(p_theta, this._up);
			var pos:Vector3D = this._target.minus(mx.transform(this._target.minus(this._pos).clone4(1)).clone3());
			this._pos = pos;
		}
		
		public function rotateByZ(p_theta:Number):void
		{
			var front:Vector3D = this._target.minus(this._pos).normal();
			var mx:Matrix4D = new Matrix4D().setRotate(p_theta, front);
			var pos:Vector3D = this._target.minus(mx.transform(this._target.minus(this._pos).clone4(1)).clone3());
			this._pos = pos;
			this._up = mx.transform(this._up.clone4(1)).clone3();
		}
		
		public function setDefault():void
		{
			this._pos = new Vector3D(0, 0, 0);
			this._target = new Vector3D(0, 0, 1);
			this._up = new Vector3D(0, 1, 0);
			
			this._planeDepth = 1;
			this._planeDist = 1;
			this._planeWidth = 1;
			this._screenWidth = 1;
		}
		
		public function setProject(p_depth:Number, p_dist:Number, p_camWidth:Number, p_projWidth:Number, p_projHeight:Number):void
		{
			this._planeDepth = p_depth;
			this._planeDist = p_dist;
			this._planeWidth = p_camWidth;
			this._screenWidth = p_projWidth;
			this._screenHeight = p_projHeight;
		}
		
		public function set mode(p_mode:int):void
		{
			this._mode = p_mode;
		}
		
		public function set position(p_vtr:Vector3D):void
		{
			this._pos = p_vtr;
		}
		
		public function set target(p_vtr:Vector3D):void
		{
			this._target = p_vtr;
		}
		
		public function set up(p_vtr:Vector3D):void
		{
			this._up = p_vtr;
		}
		
		public function getTransform():Matrix4D
		{
			var front:Vector3D = this._target.minus(this._pos);
			var left:Vector3D = this._up.cross(front);
			var top:Vector3D = front.cross(left);
			var u:Vector3D = left.normal();
			var v:Vector3D = top.normal();
			var w:Vector3D = front.normal();
			
			var targetDist:Number = Math.sqrt(front.lengthStr());
			
			var mx:Matrix4D = new Matrix4D();
			mx.setIdentity();
			
			var n:Number = this._planeDist;
			var f:Number = this._planeDepth + n;
			var r:Number = this._planeWidth / targetDist;
			var a:Number = this._screenWidth / this._planeWidth;
			var b:Number = r * a / (1 - n / f);
			var c:Number = r * a;
			var d:Number = r * a / (1 / f - 1 / n);
			var mxC:Matrix4D = new Matrix4D();
			mxC.e[0][0] = a;
			mxC.e[1][1] = a * this._screenWidth / this._screenHeight;
			mxC.e[2][2] = b;
			mxC.e[2][3] = c;
			mxC.e[3][2] = d;
			
			var mxB:Matrix4D = new Matrix4D();
			mxB.setIdentity();
			mxB.e[3][2] = targetDist;
			
			var mxA:Matrix4D = new Matrix4D();
			mxA.e[0][0] = u.x;
			mxA.e[1][0] = u.y;
			mxA.e[2][0] = u.z;
			mxA.e[0][1] = v.x;
			mxA.e[1][1] = v.y;
			mxA.e[2][1] = v.z;
			mxA.e[0][2] = w.x;
			mxA.e[1][2] = w.y;
			mxA.e[2][2] = w.z;
			mxA.e[3][3] = 1;
			
			var mx0:Matrix4D = new Matrix4D();
			mx0.setIdentity();
			mx0.e[3][0] = -this._target.x;
			mx0.e[3][1] = -this._target.y;
			mx0.e[3][2] = -this._target.z;
			
			mx.productEqual(mxC);
			mx.productEqual(mxB);
			mx.productEqual(mxA);
			mx.productEqual(mx0);
			/*
			mx.productEqual(mx0);
			mx.productEqual(mxA);
			mx.productEqual(mxB);
			mx.productEqual(mxC);
			*/
			return mx;
		}
	
	}
}