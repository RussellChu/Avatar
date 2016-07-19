package com.pj.common.j3d
{
	import com.adobe.utils.AGALMiniAssembler;
	import com.pj.common.IDisposable;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class JShader implements IDisposable
	{
		protected var _assembler:AGALMiniAssembler = null;
		
		public function JShader():void
		{
			this._assembler = new AGALMiniAssembler();
		}
		
		public function dispose():void
		{
			this._assembler = null;
		}
		
		protected function line(p_arr:Array):String
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
	}
}