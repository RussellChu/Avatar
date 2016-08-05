package com.pj.common.j3d.data
{
	
	/**
	 * ...
	 * @author Russell
	 */
	/*
	   // varible
	   v0 : color channel 0 (move data from vs to ps)
	   va0 : vertex src data 0
	   va1 : vertex src data 1
	   vc0 : matrix 0
	   vt0 : vs local varible
	   // operator
	   mov a, b : copy b to a
	   m44 a, b, c : transform b by c, store result to a
	 */
	public class J3DVertexShaderData
	{
		/* new
		public static const SHADER_SIMPLE:Object = { //
			attribute: { // va0, va1
				pos: 0 //
				, diffuse: 1 //
			} //
			, uniform: { // vc0, vc1 ...
				camMx: {code: 0, type: "matrix", value: [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1]} //
			} //
			, code: ["" // nothing
			, "mov v0, va1" // copy va1 (myDiffuse) to v0(=color channel 0)
			, "m44 vt0, va0, vc0" // transform va0(myPos) by vc0(camMx) to vt0(loc0)
			, "mov v0, vt0" // copy vt0(loc0) to v0(=color channel 0)
			, "mov op, vt0" // copy vt0(loc0) to op(vertex output)
			]};
		
		public static const SHADER_TEXTURE:Object = { //
			attribute: { // va0, va1
				pos: 0 //
				, uv: 1 //
			} //
			, code: ["" // nothing
			, "mov v0, va1" // copy va1 (myUV) to v0(=color channel 0)
			, "m44 op, va0, vc0" // transform va0(myPos) by vc0(matrix) to op(vertex output)
			]};
		*/
		public static const POS_0TO2_XYZ:int = 1;
		
		public static const DIFFUSE_3TO5_RGB:int = 1;
		
		public static const TEXTURE_3TO4_UV:int = 1;
		
		public static const SHADER_SIMPLE:Object = { //
			format: {name: "Test"//
				, pos: POS_0TO2_XYZ //
				, diffuse: DIFFUSE_3TO5_RGB //
			} //, value:[1]
			, code: ["" // nothing
			, "mov v0, va1" // copy va1 (myDiffuse) to v0(=color channel 0)
			, "m44 vt0, va0, vc0" // transform va0(myPos) by vc0(matrix) to vt0(loc0)
			, "mov v0, vt0" // copy vt0(loc0) to v0(=color channel 0)
			, "mov op, vt0" // copy vt0(loc0) to op(vertex output)
			]};
		
		public static const SHADER_TEXTURE:Object = { //
			format: {name: "Test"//
				, pos: POS_0TO2_XYZ //
				, uv: TEXTURE_3TO4_UV //
			}, code: ["" // nothing
			, "mov v0, va1" // copy va1 (myUV) to v0(=color channel 0)
			, "m44 op, va0, vc0" // transform va0(myPos) by vc0(matrix) to op(vertex output)
			]};
		
		public static function checkFormat(p_data:Object):Boolean
		{
			if (!p_data)
			{
				return false;
			}
			for (var key:String in p_data)
			{
				switch (key)
				{
				case "diffuse": 
				case "pos": 
				case "uv": 
					break;
				default: 
					return false;
				}
			}
			return true;
		}
		
		public function J3DVertexShaderData()
		{
			;
		}
	
	}

}