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
	public class J3DShapeSquare extends J3DObject
	{
		
		public function J3DShapeSquare(p_color:JColor = null, p_setting:Object = null)
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
			for (var i:int = 0; i < 6; i++)
			{
					//indices.addData(i * 4 + 0, i * 4 + 2, i * 4 + 1);
					//indices.addData(i * 4 + 0, i * 4 + 3, i * 4 + 2);
					
				if (isInbound)
				{
					indices.addData(i * 4 + 0, i * 4 + 2, i * 4 + 1);
					indices.addData(i * 4 + 0, i * 4 + 3, i * 4 + 2);
				}
				else
				{
					indices.addData(i * 4 + 0, i * 4 + 1, i * 4 + 2);
					indices.addData(i * 4 + 0, i * 4 + 2, i * 4 + 3);
				}
			}
			
			var cR:Number = 1;
			var cG:Number = 1;
			var cB:Number = 1;
			var cA:Number = 1;
			if (p_color)
			{
				cR = p_color.r;
				cG = p_color.g;
				cB = p_color.b;
				cA = p_color.a;
			}
			
			vertices.addData(-1, -1, -1, cR, cG, cB, cA);
			vertices.addData(-1, 1, -1, cR, cG, cB, cA);
			vertices.addData(1, 1, -1, cR, cG, cB, cA);
			vertices.addData(1, -1, -1, cR, cG, cB, cA);
			
			vertices.addData(-1, -1, -1, cR, cG, cB, cA);
			vertices.addData(-1, -1, 1, cR, cG, cB, cA);
			vertices.addData(-1, 1, 1, cR, cG, cB, cA);
			vertices.addData(-1, 1, -1, cR, cG, cB, cA);
			
			vertices.addData(-1, -1, -1, cR, cG, cB, cA);
			vertices.addData(1, -1, -1, cR, cG, cB, cA);
			vertices.addData(1, -1, 1, cR, cG, cB, cA);
			vertices.addData(-1, -1, 1, cR, cG, cB, cA);
			
			vertices.addData(1, 1, 1, cR, cG, cB, cA);
			vertices.addData(-1, 1, 1, cR, cG, cB, cA);
			vertices.addData(-1, -1, 1, cR, cG, cB, cA);
			vertices.addData(1, -1, 1, cR, cG, cB, cA);
			
			vertices.addData(1, 1, 1, cR, cG, cB, cA);
			vertices.addData(1, -1, 1, cR, cG, cB, cA);
			vertices.addData(1, -1, -1, cR, cG, cB, cA);
			vertices.addData(1, 1, -1, cR, cG, cB, cA);
			
			vertices.addData(1, 1, 1, cR, cG, cB, cA);
			vertices.addData(1, 1, -1, cR, cG, cB, cA);
			vertices.addData(-1, 1, -1, cR, cG, cB, cA);
			vertices.addData(-1, 1, 1, cR, cG, cB, cA);
		}
	
	}
}