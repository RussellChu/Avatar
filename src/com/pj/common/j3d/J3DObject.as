package com.pj.common.j3d
{
	import com.pj.common.Helper;
	import com.pj.common.IDisposable;
	import flash.display3D.Context3D;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.VertexBuffer3D;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class J3DObject implements IDisposable
	{
		protected var _indices:J3DIndex = null;
		protected var _vertices:J3DVertex = null;
		
		public function J3DObject()
		{
			;
			var indices:J3DIndexDelta = new J3DIndexDelta();
			var vertices:J3DVertexSimple = new J3DVertexSimple();
			
			this._indices = indices;
			this._vertices = vertices;
			
			indices.addData(0, 1, 2);
			indices.addData(0, 2, 3);
			
			vertices.addData(0.7, -0.3, 0, 1, 0, 0);
			vertices.addData(0.7, 0.3, 0, 0, 1, 0);
			vertices.addData(1.3, 0.3, 0, 0, 0, 1);
			vertices.addData(1.3, -0.3, 0, 1, 0, 1);
		}
		
		public function dispose():void
		{
			Helper.dispose(this._indices);
			Helper.dispose(this._vertices);
			this._indices = null;
			this._vertices = null;
		}
		
		public function draw(p_context:Context3D):void
		{
			if (!p_context || !this._indices || !this._vertices) {
				return;
			}
			var indexbuffer:IndexBuffer3D = this._indices.setupBuffer(p_context);
			var vertexbuffer:VertexBuffer3D = this._vertices.setupBuffer(p_context);
			p_context.drawTriangles(indexbuffer);
		}
	
	}
}