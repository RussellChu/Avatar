package com.pj.common.j3d
{
	import flash.display3D.Context3D;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.VertexBuffer3D;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class J3DVertexSimple extends J3DVertex
	{
		
		public function J3DVertexSimple()
		{
			super();
			
			this._vSize = 7;
		}
		
		public function addData(p_x:Number, p_y:Number, p_z:Number, p_r:Number, p_g:Number, p_b:Number, p_a:Number = 1):void
		{
			this._data.push(p_x, p_y, p_z, p_r, p_g, p_b, p_a);
			this._vNum++;
		}
		
		override public function setupBuffer(p_context:Context3D):VertexBuffer3D
		{
			var buffer:VertexBuffer3D = super.setupBuffer(p_context);
			p_context.setVertexBufferAt(0, buffer, 0, Context3DVertexBufferFormat.FLOAT_3);
			p_context.setVertexBufferAt(1, buffer, 3, Context3DVertexBufferFormat.FLOAT_4);
			return buffer;
		}
	
	}
}