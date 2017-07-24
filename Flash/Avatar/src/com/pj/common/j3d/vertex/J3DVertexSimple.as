package com.pj.common.j3d.vertex
{
	import com.pj.common.j3d.shader.J3DShaderData;
	import com.pj.common.j3d.vertex.J3DVertex;
	import flash.display3D.Context3DVertexBufferFormat;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class J3DVertexSimple extends J3DVertex
	{
		
		public function J3DVertexSimple()
		{
			super();
			
			this._vSize = 7;
			this._attribute = [ //
			{name: J3DShaderData.ATTRIBUTE_POS, offset: 0, format: Context3DVertexBufferFormat.FLOAT_3} //
			, {name: J3DShaderData.ATTRIBUTE_DIFFUSE, offset: 3, format: Context3DVertexBufferFormat.FLOAT_4} //
			];
		}
		
		public function addData(p_x:Number, p_y:Number, p_z:Number, p_r:Number, p_g:Number, p_b:Number, p_a:Number = 1):void
		{
			this._data.push(p_x, p_y, p_z, p_r, p_g, p_b, p_a);
			this._vNum++;
		}
	
	}
}