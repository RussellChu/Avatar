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
		private var _target:Vector3D = null;
		private var _pos:Vector3D = null;
		private var _up:Vector3D = null;
		private var _planeDepth:Number = 0; // dist between near plane and far plane
		private var _planeDist:Number = 0; // near plane
		private var _planeWidth:Number = 0; // near plane radius
		private var _screenWidth:Number = 0; // screen radius
		
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
		
		public function rotateByX(p_theta:Number):void
		{
			this._pos = new Matrix4D().setRotateX(p_theta).transform(this._pos.minus(this._target).clone4(1)).clone3().add(this._target);
		}
		
		public function rotateByY(p_theta:Number):void
		{
			this._pos = new Matrix4D().setRotateY(p_theta).transform(this._pos.minus(this._target).clone4(1)).clone3().add(this._target);
		}
		
		public function rotateByZ(p_theta:Number):void
		{
			this._pos = new Matrix4D().setRotateZ(p_theta).transform(this._pos.minus(this._target).clone4(1)).clone3().add(this._target);
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
		
		public function setProject(p_depth:Number, p_dist:Number, p_camWidth:Number, p_projWidth:Number):void
		{
			this._planeDepth = p_depth;
			this._planeDist = p_dist;
			this._planeWidth = p_camWidth;
			this._screenWidth = p_projWidth;
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
			
			var mxB:Matrix4D = new Matrix4D();
			mxB.setIdentity();
			mxB.e[0][3] = -this._pos.x;
			mxB.e[1][3] = -this._pos.y;
			mxB.e[2][3] = -this._pos.z;
			
			var mx:Matrix4D = mxB.product(mxA.inverse3x3());
			var mxPlane:Matrix4D = new Matrix4D();
			if (this._planeWidth > 0)
			{
				mxPlane.e[0][0] = this._screenWidth / this._planeWidth;
			}
			mxPlane.e[1][1] = mxPlane.e[0][0];
			if (this._planeDepth > 0)
			{
				mxPlane.e[2][2] = 1 / this._planeDepth;
			}
			if (this._planeDist > 0)
			{
				mxPlane.e[3][2] = 1 / this._planeDist;
			}
			if (this._planeDepth > 0)
			{
				mxPlane.e[2][3] = -this._planeDist / this._planeDepth;
			}
			return mx.product(mxPlane);
		}
	
	}
}