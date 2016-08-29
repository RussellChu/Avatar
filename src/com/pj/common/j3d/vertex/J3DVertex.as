package com.pj.common.j3d.vertex
{
	import com.pj.common.IDisposable;
	import com.pj.common.j3d.shader.J3DShader;
	import flash.display3D.Context3D;
	import flash.display3D.VertexBuffer3D;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class J3DVertex implements IDisposable
	{
		protected var _data:Vector.<Number> = null;
		protected var _vNum:int = 0;
		protected var _vSize:int = 0;
		protected var _attribute:Array = null;
		
		public function J3DVertex()
		{
			this._data = new Vector.<Number>();
			this._attribute = [];
		}
		
		public function dispose():void
		{
			this._data = null;
			this._attribute = null;
		}
		
		public function setupBuffer(p_context:Context3D, p_shader:J3DShader):VertexBuffer3D
		{
			var buffer:VertexBuffer3D = p_context.createVertexBuffer(this._vNum, this._vSize);
			buffer.uploadFromVector(this._data, 0, this._vNum);
			for (var i:int = 0; i < this._attribute.length; i++) {
				var item:Object = this._attribute[i];
				var name:String = item.name;
				var offset:int = item.offset;
				var format:String = item.format;
				var index:int = p_shader.getAttributeCode(name);
				if (index < 0) {
					continue;
				}
				p_context.setVertexBufferAt(index, buffer, offset, format);
			}
			return buffer;
		}
	
	}
}