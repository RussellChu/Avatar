package com.pj.common.j3d
{
	import flash.display3D.Context3DProgramType;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class JPixelShader extends JShader
	{
		public static const TYPE_TEST:int = 1;
		
		public function JPixelShader(p_type:int):void
		{
			super();
			var code:String = "";
			switch (p_type)
			{
			case TYPE_TEST: 
			default: 
				code = this.line(["" // nothing
				, "mov oc, v0"]); // copy v0(=color channel 0) to oc(color output)
			}
			this._assembler.assemble(Context3DProgramType.FRAGMENT, code);
		}
	}
}