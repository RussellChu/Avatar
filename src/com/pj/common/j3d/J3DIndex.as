package com.pj.common.j3d
{
	import com.pj.common.IDisposable;
	import flash.display3D.Context3D;
	import flash.display3D.IndexBuffer3D;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class J3DIndex implements IDisposable
	{
		protected var _data:Vector.<uint> = null;
		
		public function J3DIndex()
		{
			this._data = new Vector.<uint>();
		}
		
		public function dispose():void
		{
			this._data = null;
		}
		
		public function setupBuffer(p_context:Context3D):IndexBuffer3D
		{
			var indexbuffer:IndexBuffer3D = p_context.createIndexBuffer(this._data.length);
			indexbuffer.uploadFromVector(this._data, 0, this._data.length);
			return indexbuffer;
		}
	
	}
}