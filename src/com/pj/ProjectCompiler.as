package com.pj 
{
	import com.pj.common.component.BasicContainer;
	import com.pj.common.component.IContainer;
	import com.pj.common.j3d.shader.J3DShaderCompiler;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class ProjectCompiler extends BasicContainer 
	{
		
		public function ProjectCompiler(p_inst:Sprite):void
		{
			super(null, p_inst);
			
			var complier:J3DShaderCompiler = new J3DShaderCompiler();
			var src:Object = { //
				attribute: [ //
					  { code: "va0", name: "pos", type: "vec3" } //
					, { code: "va1", name: "diffuse", type: "vec3" } //
				] //
				, uniform: [ //
					  { name: "bgColor", type: "vec3" } //
					, { name: "time", type: "float" } //
				] //
				, varying: [ //
					  { code: "v0", name: "pxDiffuse", type: "vec3" } //
					, { code: "v1", name: "pxSpecular", type: "vec3" } //
				] //
				, output: [ //
					  { code: "op", name: "op", type: "vec4" } //
					, { code: "oc", name: "oc", type: "vec4" } //
				] //
				, method: { //
					main: { //
						param: [ //
						] //
						, code: [ //
							  ["var", "loc0", "float"] //
							, ["mul", "loc0", "pos.x", "aspect"] //
							, ["var", "screenPos", "vec2"], //
							, ["set", "screenPos", "loc0", "pos.y"] //
							, ["cross", ""] //
						] //
					} //
					, cross: { //
						param: [ //
							  { name: "v0", type: "vec3" } //
							, { name: "v1", type: "vec3" } //
						] //
						, code: [ //
							  ["var", "rslt", "vec3"] //
							, ["var", "loc0", "float"] //
							, ["mul", "loc0", "v0.x", "v1.y"] //
							, ["add", "rslt.z", "loc0"] //
							, ["mul", "loc0", "v0.y", "v1.x"] //
							, ["sub", "rslt.z", "loc0"] //
							, ["return", "rslt"] //
						] //
					}
				}
			};
			complier.compile(src);
			
		}
		
	}

}