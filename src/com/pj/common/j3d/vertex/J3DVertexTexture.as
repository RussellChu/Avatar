package com.pj.common.j3d.vertex
{
	import com.pj.common.j3d.shader.J3DShaderData;
	import com.pj.common.j3d.vertex.J3DVertex;
	import flash.display3D.Context3DVertexBufferFormat;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class J3DVertexTexture extends J3DVertex
	{
		
		public function J3DVertexTexture()
		{
			super();
			
			this._vSize = 5;
			this._attribute = [ //
			{name: J3DShaderData.ATTRIBUTE_POS, offset: 0, format: Context3DVertexBufferFormat.FLOAT_3} //
			, {name: J3DShaderData.ATTRIBUTE_UV, offset: 3, format: Context3DVertexBufferFormat.FLOAT_2} //
			];
		}
		
		public function addData(p_x:Number, p_y:Number, p_z:Number, p_u:Number, p_v:Number):void
		{
			this._data.push(p_x, p_y, p_z, p_u, p_v);
			this._vNum++;
		}
	
	}
}