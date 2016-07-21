package com.pj.common.j3d.shader.vertex
{
	import com.pj.common.j3d.J3DShader;
	import flash.display3D.Context3DProgramType;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class J3D_VS extends J3DShader
	{
		
		public function J3D_VS(p_data:Object)
		{
			super(p_data);
			this._assembler.assemble(Context3DProgramType.VERTEX, this._code);
		}
	
	}
}