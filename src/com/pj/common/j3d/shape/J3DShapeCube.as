package com.pj.common.j3d.shape
{
	import com.pj.common.Helper;
	import com.pj.common.JColor;
	import com.pj.common.j3d.J3DIndexDelta;
	import com.pj.common.j3d.J3DObject;
	import com.pj.common.j3d.vertex.J3DVertexSimple;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class J3DShapeCube extends J3DObject
	{
		
		public function J3DShapeCube(p_color:JColor = null, p_setting:Object = null)
		{
			super();
			
			var setting:Object = {};
			if (p_setting)
			{
				setting = p_setting;
			}
			
			var indices:J3DIndexDelta = new J3DIndexDelta();
			var vertices:J3DVertexSimple = new J3DVertexSimple();
			
			this._indices = indices;
			this._vertices = vertices;
			
			var isInbound:Boolean = Helper.getValueBoolean(setting, "isInbound");
			if (isInbound)
			{
				indices.addData(0, 2, 1);
				indices.addData(1, 2, 3);
				indices.addData(0, 7, 2);
				indices.addData(2, 7, 5);
				indices.addData(2, 4, 3);
				indices.addData(2, 5, 4);
				indices.addData(1, 3, 6);
				indices.addData(3, 4, 6);
				indices.addData(4, 5, 6);
				indices.addData(5, 7, 6);
				indices.addData(1, 6, 8);
				indices.addData(6, 7, 8);
			}
			else
			{
				indices.addData(0, 1, 2);
				indices.addData(1, 3, 2);
				indices.addData(0, 2, 7);
				indices.addData(2, 5, 7);
				indices.addData(2, 3, 4);
				indices.addData(2, 4, 5);
				indices.addData(1, 6, 3);
				indices.addData(3, 6, 4);
				indices.addData(4, 6, 5);
				indices.addData(5, 6, 7);
				indices.addData(1, 8, 6);
				indices.addData(6, 8, 7);
			}
			var alpha:Number = Helper.getValueNumber(setting, "alpha", 1);
			
			/* texture uv
			   vertices.addData(0, 1, 0, 0, 0, 1);
			   vertices.addData(1, 1, 0, 1, 0, 1);
			   vertices.addData(0.25, 0.75, 0, 0, 1, 1);
			   vertices.addData(0.75, 0.75, 0, 1, 1, 1);
			   vertices.addData(0.5, 0.5, 0, 1, 1, 0);
			   vertices.addData(0.25, 0.25, 0, 0, 1, 0);
			   vertices.addData(0.75, 0.25, 0, 1, 0, 0);
			   vertices.addData(0, 0, 0, 0, 0, 0);
			   vertices.addData(1, 0, 0, 0, 0, 1);
			 */
			
			
			vertices.addData(-1, -1, 1, 0, 0, 1, alpha);
			vertices.addData(1, -1, 1, 1, 0, 1, alpha);
			vertices.addData(-1, 1, 1, 0, 1, 1, alpha);
			vertices.addData(1, 1, 1, 1, 1, 1, alpha);
			vertices.addData(1, 1, -1, 1, 1, 0, alpha);
			vertices.addData(-1, 1, -1, 0, 1, 0, alpha);
			vertices.addData(1, -1, -1, 1, 0, 0, alpha);
			vertices.addData(-1, -1, -1, 0, 0, 0, alpha);
			vertices.addData(-1, -1, 1, 0, 0, 1,alpha);
			
		}
	
	}
}