package com.pj.common.j3d.shader.vertex
{
	import com.pj.common.j3d.J3DObject;
	import com.pj.common.j3d.data.J3DVertexShaderData;
	import com.pj.common.j3d.shader.IShadingVertex_Move3D;
	import com.pj.common.j3d.shader.vertex.J3D_VS;
	import com.pj.common.j3d.shader.vertex.J3D_VS_Simple;
	import com.pj.common.math.Matrix4D;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class J3D_VS_Simple extends J3D_VS
	{
		private var _mxCamera:Matrix4D = null;
		
		public function J3D_VS_Simple():void
		{
			super(J3DVertexShaderData.SHADER_SIMPLE);
			this._mxCamera = new Matrix4D();
			this._mxCamera.setIdentity();
		}
		
		override public function dispose():void
		{
			this._mxCamera = null;
			super.dispose();
		}
		
		override public function update(p_context:Context3D):void
		{
			p_context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, this._mxCamera.toM3D());
		}
		
		override public function updateObj(p_context:Context3D, p_obj:J3DObject):void
		{
			if (p_obj is IShadingVertex_Move3D)
			{
				p_context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, (p_obj as IShadingVertex_Move3D).getShadingVertex_Move3D().toM3D(), true);
			}
		}
		
		public function setCameraMatrix(p_mx:Matrix4D):void {
			if (!p_mx) {
				return;
			}
			
			this._mxCamera = p_mx;
		}
	
	}
}