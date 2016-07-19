package com.pj.common.j3d
{
	import com.pj.common.IDisposable;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class JShaderManager implements IDisposable
	{
		private var _vMap:Object = null;
		private var _pMap:Object = null;
		
		public function JShaderManager():void
		{
			this._vMap = {};
			this._pMap = {};
		}
		
		public function dispose():void
		{
			this._vMap = null;
			this._pMap = null;
		}
		
		public function loadVertexShader(p_type:int):JVertexShader
		{
			if (this._vMap[p_type])
			{
				return this._vMap[p_type];
			}
			this._vMap[p_type] = new JVertexShader(p_type);
			return this._vMap[p_type];
		}
		
		public function loadPixelShader(p_type:int):JPixelShader
		{
			if (this._pMap[p_type])
			{
				return this._pMap[p_type];
			}
			this._pMap[p_type] = new JPixelShader(p_type);
			return this._pMap[p_type];
		}
	}
}