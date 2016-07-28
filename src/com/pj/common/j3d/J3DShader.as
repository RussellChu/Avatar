package com.pj.common.j3d
{
	import com.adobe.utils.AGALMiniAssembler;
	import com.pj.common.IDisposable;
	import com.pj.common.j3d.J3DShader;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class J3DShader implements IDisposable
	{
		protected var _assembler:AGALMiniAssembler = null;
		protected var _code:String = "";
		private var _data:Object = null;
		
		public function J3DShader(p_data:Object):void
		{
			this._assembler = new AGALMiniAssembler();
			this._data = p_data;
			var code:Array = this._data.code;
			var format:Object = this._data.format;

			if (format)
			{
				if (!this.checkFormat(format))
				{
					throw new Error("J3DShader Format Error");
				}
			}
			
			this._code = this.line(code);
		}
		
		public function dispose():void
		{
			this._assembler = null;
		}
		
		private function checkFormat(p_data:Object):Boolean
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
				case "name": 
				case "pos": 
					break;
				default: 
					throw new Error("J3DShader Format Error >> unknown key >> " + key);
					return false;
				}
			}
			return true;
		}
		
		private function line(p_arr:Array):String
		{
			if (!p_arr)
			{
				return "";
			}
			
			var result:String = "";
			for (var i:int = 0; i < p_arr.length; i++)
			{
				var str:String = p_arr[i] as String;
				if (!str)
				{
					continue;
				}
				if (str == "")
				{
					continue;
				}
				result += str + "\n";
			}
			return result;
		}
		
		public function getAgalCode():ByteArray
		{
			return this._assembler.agalcode;
		}
		
		public function setConst(p_context:Context3D):void {
			// override
		}
		
		public function update(p_context:Context3D):void{
			// override
		}
		
		public function updateObj(p_context:Context3D, p_obj:J3DObject):void{
			// override
		}
		
	}
}