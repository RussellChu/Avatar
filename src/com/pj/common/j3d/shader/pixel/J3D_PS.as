package com.pj.common.j3d.shader.pixel
{
	import com.pj.common.j3d.J3DShader;
	import flash.display3D.Context3DProgramType;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class J3D_PS extends J3DShader
	{
		
		public function J3D_PS(p_data:Object)
		{
			super(p_data);
			this._assembler.assemble(Context3DProgramType.FRAGMENT, this._code);
		}
	
	}
}