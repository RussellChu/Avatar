package com.pj.common.j3d.data
{
	
	/**
	 * ...
	 * @author Russell
	 */
	public class J3DPixelShaderData
	{
		public static const SHADER_SIMPLE:Object = { //
			code: ["" // nothing
			, "mov oc, v0" // copy v0(=color channel 0) to oc(color output)
			]};
		
		public function J3DPixelShaderData()
		{
			;
		}
	
	}

}