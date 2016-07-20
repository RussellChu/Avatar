package com.pj.common.j3d
{
	import com.pj.common.j3d.data.J3DVertexShaderData;
	import com.pj.common.j3d.shader.vertex.J3D_VS_Test;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.VertexBuffer3D;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class J3DVertexSimple extends J3DVertex
	{
		
		public function J3DVertexSimple()
		{
			super();
			
			this._format = { //
				pos: J3DVertexShaderData.POS_0TO2_XYZ //
				, diffuse: J3DVertexShaderData.DIFFUSE_3TO5_RGB //
			};
			this._vSize = 6;
		}
		
		public function addData(p_x:Number, p_y:Number, p_z:Number, p_r:Number, p_g:Number, p_b:Number):void
		{
			this._data.push(p_x, p_y, p_z, p_r, p_g, p_b);
			this._vNum++;
		}
		
		override public function setupBuffer(p_context:Context3D):VertexBuffer3D
		{
			var buffer:VertexBuffer3D = super.setupBuffer(p_context);
			p_context.setVertexBufferAt(0, buffer, 0, Context3DVertexBufferFormat.FLOAT_3);
			p_context.setVertexBufferAt(1, buffer, 3, Context3DVertexBufferFormat.FLOAT_3);
			return buffer;
		}
	
	}
}