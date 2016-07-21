package com.pj.common.j3d
{
	import com.pj.common.j3d.data.J3DVertexShaderData;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.VertexBuffer3D;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class J3DVertexTextureOnly extends J3DVertex
	{
		
		public function J3DVertexTextureOnly()
		{
			super();
			
			this._format = { //
				pos: J3DVertexShaderData.POS_0TO2_XYZ //
				, uv: J3DVertexShaderData.TEXTURE_3TO4_UV //
			};
			this._vSize = 5;
		}
		
		public function addData(p_x:Number, p_y:Number, p_z:Number, p_u:Number, p_v:Number):void
		{
			this._data.push(p_x, p_y, p_z, p_u, p_v);
			this._vNum++;
		}
		
		override public function setupBuffer(p_context:Context3D):VertexBuffer3D
		{
			var buffer:VertexBuffer3D = super.setupBuffer(p_context);
			p_context.setVertexBufferAt(0, buffer, 0, Context3DVertexBufferFormat.FLOAT_3);
			p_context.setVertexBufferAt(1, buffer, 3, Context3DVertexBufferFormat.FLOAT_2);
			return buffer;
		}
	
	}
}