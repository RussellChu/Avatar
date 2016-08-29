package com.pj.common.j3d.shader
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
	public class J3DShaderData
	{
		public static const ATTRIBUTE_DIFFUSE:String = "diffuse";
		public static const ATTRIBUTE_POS:String = "pos";
		public static const ATTRIBUTE_UV:String = "uv";
		
		public static const SHADER_VERTEX_SIMPLE:Object = { //
			type: "vertex"
			, attribute: { // va0, va1
				pos: {code: 0, type: "vec3"} //
				, diffuse: {code: 1, type: "vec3"} //
			} //
			, uniform: { // vc0, vc1 ...
				camMx: {code: 0, type: "matrix", value: [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1]} //
				, one: {code: 4, type: "float", value: 1, subcode: "x", write: false} //
				, zone: {code: 4, type: "float", value: 0, subcode: "y", write: false} //
				, half: {code: 4, type: "float", value: 0.5, subcode: "z", write: false} //
				, times: {code: 4, type: "float", value: 0.3, subcode: "w", write: false} //
			} //
			, code: ["" // nothing
			, "mov v0, va1" // copy va1 (myDiffuse) to v0(=color channel 0)
			, "m44 vt0, va0, vc0" // transform va0(myPos) by vc0(camMx) to vt0(loc0)
			// , "div vt0, vt0, vt0.wwww"
			 //, "mov vt1, vt0" // 
			 //, "div vt1, vt1, vt1.wwww"
			//, "sub vt1.z, vc4.x, vt1.z" // vc4.x (1) - vt1.z = vt1.z
			//, "min vt1.z, vt1.z, vc4.x"
			//, "max vt1.z, vt1.z, vc4.y"
			 //, "mov vt1, vt1.zzzw" // 
			 //, "mul vt1, vt1, va1" // 
			//, "mov vt1.w, vc4.x" // 
			//, "mov vt2 vt1.zzzw"
			//, "sub vt2.x, vc4.x, vt2.x" // vc4.x (1) - vt1.z = vt1.z
			//, "add vt2.x, vc4.x, vt2.x" // vc4.x (1) - vt1.z = vt1.z
			//, "mul vt2.x, vc4.z, vt2.x" // vt1.z - vc4.z (0.5) = vt1.z
			//, "min vt2.x, vt2.x, vc4.x"
			//, "max vt2.x, vt2.x, vc4.y"
			//, "mov vt1 vt2.xxxw"
			//, "mov vt1.w vc4.w"
			// , "mov v0, vt1" // copy vt0(loc0) to v0(=color channel 0)
			, "mov op, vt0" // copy vt0(loc0) to op(vertex output)
			]};
		
		public static const SHADER_VERTEX_TEXTURE:Object = { //
			type: "vertex"
			, attribute: { // va0, va1
				pos: {code: 0, type: "vec3"} //
				, uv: {code: 1, type: "vec2"} //
			} //
			, code: ["" // nothing
			, "mov v0, va1" // copy va1 (myUV) to v0(=color channel 0)
			, "m44 op, va0, vc0" // transform va0(myPos) by vc0(matrix) to op(vertex output)
			]};
			
		public static const SHADER_PIXEL_SIMPLE:Object = { //
			type: "fragment"
			, code: ["" // nothing
			, "mov ft0, v0" // copy v0(=color channel 0) to oc(color output)
		//	, "mov ft0.y, ft0.w" // copy v0(=color channel 0) to oc(color output)
			, "mov oc, ft0" // copy v0(=color channel 0) to oc(color output)
			]};
			
		public static const SHADER_PIXEL_TEXTURE:Object = { //
			type: "fragment"
			, code: ["" // nothing
			, "tex ft0, v0, fs0 <2d,clamp,linear>"
			, "mov oc, ft0" // copy v0(=color channel 0) to oc(color output)
			]};
		
		public function J3DShaderData()
		{
			;
		}
	
	}

}