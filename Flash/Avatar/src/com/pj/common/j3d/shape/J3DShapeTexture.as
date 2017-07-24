package com.pj.common.j3d.shape
{
	import com.pj.common.j3d.J3DIndexDelta;
	import com.pj.common.j3d.J3DObject;
	import com.pj.common.j3d.vertex.J3DVertexTexture;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class J3DShapeTexture extends J3DObject
	{
		
		public function J3DShapeTexture(p_texKey:String = null)
		{
			super();
			var indices:J3DIndexDelta = new J3DIndexDelta();
			var vertices:J3DVertexTexture = new J3DVertexTexture();
			
			this._indices = indices;
			this._vertices = vertices;
			
			indices.addData(0, 1, 2);
			indices.addData(0, 2, 3);
			
			vertices.addData(0, 0, 0, 0, 0);
			vertices.addData(0, 1, 0, 0, 1);
			vertices.addData(1, 1, 0, 1, 1);
			vertices.addData(1, 0, 0, 1, 0);
			
			this._textureKey.push(p_texKey);
		}
	
	}
}