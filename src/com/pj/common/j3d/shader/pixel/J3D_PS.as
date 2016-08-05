package com.pj.common.j3d.shader.pixel
{
	import com.pj.common.j3d.J3DShader;
	import flash.display3D.Context3D;
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
			this._assembler.assemble(Context3DProgramType.FRAGMENT, this._code, 2);
		}
		
		override public function setConst(p_context:Context3D):void
		{
			p_context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, Vector.<Number>([]));
		}
	
	}
}