package com.pj.common.j3d.shader.vertex
{
	import com.pj.common.j3d.J3DObject;
	import com.pj.common.j3d.data.J3DVertexShaderData;
	import com.pj.common.j3d.shader.IShadingVertex_Texture;
	import com.pj.common.j3d.shader.vertex.J3D_VS;
	import com.pj.common.math.Matrix4D;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class J3D_VS_Texture extends J3D_VS
	{
		public function J3D_VS_Texture():void
		{
			super(J3DVertexShaderData.SHADER_TEXTURE);
		}
		
		override public function dispose():void
		{
			super.dispose();
		}
		
		override public function update(p_context:Context3D):void
		{
			// to do
			var m0:Matrix4D = new Matrix4D();
			m0.setRotateZ(getTimer() / 40 / 180 * Math.PI);
			//var m:Matrix3D = new Matrix3D();
			//m.appendRotation(getTimer() / 40, Vector3D.Z_AXIS);
			//m = m0.toM3D();
			p_context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, m0.toM3D());
		}
		
		override public function updateObj(p_context:Context3D, p_obj:J3DObject):void
		{
			if (p_obj is IShadingVertex_Texture)
			{
				var texKey:String = (p_obj as IShadingVertex_Texture).getShadingVertex_TextureKeyAt(0);
				
			}
		}
	
	}
}