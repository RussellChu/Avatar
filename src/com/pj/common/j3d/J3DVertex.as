package com.pj.common.j3d
{
	import com.pj.common.IDisposable;
	import flash.display3D.Context3D;
	import flash.display3D.VertexBuffer3D;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class J3DVertex implements IDisposable
	{
		protected var _data:Vector.<Number> = null;
		protected var _format:Object = null;
		protected var _vNum:int = 0;
		protected var _vSize:int = 0;
		
		public function J3DVertex()
		{
			this._data = new Vector.<Number>();
		}
		
		public function dispose():void
		{
			this._data = null;
			this._format = null;
		}
		
		public function setupBuffer(p_context:Context3D):VertexBuffer3D
		{
			var buffer:VertexBuffer3D = p_context.createVertexBuffer(this._vNum, this._vSize);
			buffer.uploadFromVector(this._data, 0, this._vNum);
			return buffer;
		}
		
		public function get format():Object
		{
			return this._format;
		}
	
	}
}