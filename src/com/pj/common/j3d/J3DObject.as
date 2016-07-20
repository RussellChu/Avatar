package com.pj.common.j3d
{
	import com.pj.common.Helper;
	import com.pj.common.IDisposable;
	import com.pj.common.j3d.shader.pixel.J3DPixelShader;
	import com.pj.common.j3d.shader.vertex.J3DVertexShader;
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
		private var _pixelShader:J3DPixelShader = null;
		private var _vertexShader:J3DVertexShader = null;
		
		public function J3DObject()
		{
			;
		}
		
		public function dispose():void
		{
			Helper.dispose(this._indices);
			Helper.dispose(this._vertices);
			Helper.dispose(this._pixelShader);
			Helper.dispose(this._vertexShader);
			this._indices = null;
			this._vertices = null;
			this._pixelShader = null;
			this._vertexShader = null;
		}
		
		public function draw(p_j3d:J3D):void
		{
			if (!p_j3d) {
				return;
			}
			
			p_j3d.drawObject( this._vertices, this._indices, this._vertexShader, this._pixelShader );
		}
		
		//public function get pixelShader():J3DPixelShader{
			//return this._pixelShader;
		//}
		
		public function set pixelShader(p_shader:J3DPixelShader):void{
			this._pixelShader = p_shader;
		}
		
		//public function get vertexShader():J3DVertexShader{
			//return this._vertexShader;
		//}
		
		public function set vertexShader(p_shader:J3DVertexShader):void{
			this._vertexShader = p_shader;
		}
	
	}
}