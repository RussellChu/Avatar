package com.pj.common.j3d 
{
	import flash.display.BitmapData;
	import flash.display3D.Context3D;
	import flash.display3D.textures.Texture;
	/**
	 * ...
	 * @author Russell
	 */
	public class J3DTextureManager 
	{
		private var _context:Context3D = null;
		private var _textureMap:Object = null;
		
		public function J3DTextureManager(p_context:Context3D) 
		{
			if (!p_context) {
				// Error
			}
			this._context = p_context;
			this._textureMap = {};
		}
		
		public function loadBitmapData(p_key:String, p_data:BitmapData):void{
			// this._textureMap
			if (p_key == "") {
				return;
			}
			if (!p_data) {
				return;
			}
			var tex:Texture = this._context.createTexture(p_data.width, p_data.height, "bgra", false);
			tex.uploadFromBitmapData(p_data);
			this._textureMap[p_key] = tex;
		}
		
		public function getTexture(p_key:String):Texture {
			if (p_key == "") {
				return null;
			}
			
			return this._textureMap[p_key];
		}
		
	}

}