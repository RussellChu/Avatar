package com.pj.common.j3d.shader.pixel
{
	import com.pj.common.j3d.data.J3DPixelShaderData;
	import com.pj.common.j3d.shader.pixel.J3D_PS;
	import flash.display3D.Context3D;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class J3D_PS_Simple extends J3D_PS
	{
		public function J3D_PS_Simple():void
		{
			super(J3DPixelShaderData.SHADER_SIMPLE);
		}
		
		override public function dispose():void
		{
			super.dispose();
		}
		
		override public function update(p_context:Context3D):void
		{
			;
		}
	
	}
}