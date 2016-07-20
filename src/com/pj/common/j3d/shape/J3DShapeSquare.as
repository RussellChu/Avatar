package com.pj.common.j3d.shape
{
	import com.pj.common.JColor;
	import com.pj.common.j3d.J3DIndexDelta;
	import com.pj.common.j3d.J3DObject;
	import com.pj.common.j3d.J3DVertexSimple;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class J3DShapeSquare extends J3DObject
	{
		
		public function J3DShapeSquare(p_color:JColor=null)
		{
			super();
			var indices:J3DIndexDelta = new J3DIndexDelta();
			var vertices:J3DVertexSimple = new J3DVertexSimple();
			
			this._indices = indices;
			this._vertices = vertices;
			
			indices.addData(0, 1, 2);
			indices.addData(0, 2, 3);
			
			var cR:Number = 1;
			var cG:Number = 1;
			var cB:Number = 1;
			if (p_color) {
				cR = p_color.r;
				cG = p_color.g;
				cB = p_color.b;
			}
			vertices.addData(0, 0, 0, cR, cG, cB);
			vertices.addData(0, 1, 0, cR, cG, cB);
			vertices.addData(1, 1, 0, cR, cG, cB);
			vertices.addData(1, 0, 0, cR, cG, cB);
		}
	
	}
}