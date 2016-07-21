package com.pj.common.j3d
{
	import com.pj.common.Helper;
	import com.pj.common.IDisposable;
	import com.pj.common.j3d.shader.IShadingVertex_Texture;
	import com.pj.common.j3d.shader.pixel.J3D_PS;
	import com.pj.common.j3d.shader.vertex.J3D_VS;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class J3DObject implements IDisposable, IShadingVertex_Texture
	{
		protected var _indices:J3DIndex = null;
		protected var _vertices:J3DVertex = null;
		private var _pixelShader:J3D_PS = null;
		private var _vertexShader:J3D_VS = null;
		protected var _textureKey:Array = null;
		
		public function J3DObject()
		{
			this._textureKey = [];
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
			this._textureKey = null;
		}
		
		public function draw(p_j3d:J3D):void
		{
			if (!p_j3d)
			{
				return;
			}
			
			p_j3d.drawObject(this._vertices, this._indices, this._vertexShader, this._pixelShader);
		}
		
		public function set pixelShader(p_shader:J3D_PS):void
		{
			this._pixelShader = p_shader;
		}
		
		public function set vertexShader(p_shader:J3D_VS):void
		{
			this._vertexShader = p_shader;
		}
		
		public function getShadingVertex_TextureKeyAt(p_index:int):String
		{
			if (!this._textureKey)
			{
				return "";
			}
			
			if (p_index < 0 || p_index > this._textureKey.length)
			{
				return "";
			}
			
			return this._textureKey[p_index];
		}
	
	}
}