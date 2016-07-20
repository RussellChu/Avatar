package com.pj.common.j3d.shader.pixel
{
	import com.pj.common.j3d.data.J3DPixelShaderData;
	import flash.display3D.Context3D;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class J3D_PS_Test extends J3DPixelShader
	{
		public function J3D_PS_Test():void
		{
			super(J3DPixelShaderData.SHADER_TEST);
		}
		
		override public function dispose():void
		{
			super.dispose();
		}
		
		override public function update(p_context:Context3D):void{
			;
		}
	
	}
}