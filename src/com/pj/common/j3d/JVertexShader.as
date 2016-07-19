package com.pj.common.j3d
{
	import flash.display3D.Context3DProgramType;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class JVertexShader extends JShader
	{
		public static const TYPE_TEST:int = 1;
		
		public function JVertexShader(p_type:int):void
		{
			super();
			var code:String = "";
			switch (p_type)
			{
			case TYPE_TEST: 
			default: 
				code = this.line(["" // nothing
				, "mov v0, va1" // copy va1 (unknown) to v0(=color channel 0)
				, "m44 op, va0, vc0" // transform va0(vertex) by vc0(matrix) to op(vertex output)
				]);
			}
			this._assembler.assemble(Context3DProgramType.VERTEX, code);
		}
	}
}