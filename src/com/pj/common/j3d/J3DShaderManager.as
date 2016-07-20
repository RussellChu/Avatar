package com.pj.common.j3d
{
	import com.pj.common.IDisposable;
	import com.pj.common.j3d.shader.pixel.J3DPixelShader;
	import com.pj.common.j3d.shader.vertex.J3DVertexShader;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class J3DShaderManager implements IDisposable
	{
		private var _vMap:Object = null;
		private var _pMap:Object = null;
		
		public function J3DShaderManager():void
		{
			this._vMap = {};
			this._pMap = {};
		}
		
		public function dispose():void
		{
			this._vMap = null;
			this._pMap = null;
		}
		
		public function loadVertexShader(p_type:int):J3DVertexShader
		{
			if (this._vMap[p_type])
			{
				return this._vMap[p_type];
			}
			this._vMap[p_type] = new J3DVertexShader(p_type);
			return this._vMap[p_type];
		}
		
		public function loadPixelShader(p_type:int):J3DPixelShader
		{
			if (this._pMap[p_type])
			{
				return this._pMap[p_type];
			}
			this._pMap[p_type] = new J3DPixelShader(p_type);
			return this._pMap[p_type];
		}
	}
}