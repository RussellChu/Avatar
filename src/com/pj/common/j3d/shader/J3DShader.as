package com.pj.common.j3d.shader
{
	import com.adobe.utils.AGALMiniAssembler;
	import com.pj.common.Helper;
	import com.pj.common.IDisposable;
	import com.pj.common.j3d.J3DObject;
	import com.pj.common.j3d.shader.J3DShader;
	import com.pj.common.math.Matrix4D;
	import com.pj.common.math.Vector2D;
	import com.pj.common.math.Vector3D;
	import com.pj.common.math.Vector4D;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class J3DShader implements IDisposable
	{
		public static const CONST_TYPE_INT:String = "int";
		public static const CONST_TYPE_FLOAT:String = "float";
		public static const CONST_TYPE_VEC2:String = "vec2";
		public static const CONST_TYPE_VEC3:String = "vec3";
		public static const CONST_TYPE_VEC4:String = "vec4";
		public static const CONST_TYPE_MATRIX:String = "matrix";
		
		private static const VERSION:int = 2;
		
		private var _assembler:AGALMiniAssembler = null;
		private var _attribute:Object = null;
		private var _type:String = "";
		private var _uniform:Object = null;
		private var _vecMap:Object = null;
		
		public function J3DShader(p_data:Object = null):void
		{
			this._assembler = null;
			this._attribute = {};
			this._type = "";
			this._uniform = {};
			this._vecMap = {};
			
			if (!p_data)
			{
				return;
			}
			
			if (!p_data.type)
			{
				return;
			}
			
			var type:String = p_data.type;
			if (type != Context3DProgramType.VERTEX && type != Context3DProgramType.FRAGMENT)
			{
				return;
			}
			
			this._type = type;
			var attribute:Object = p_data.attribute;
			var uniform:Object = p_data.uniform;
			var code:Array = p_data.code;
			if (attribute)
			{
				this._attribute = attribute;
			}
			if (uniform)
			{
				this._uniform = uniform;
			}
			if (code)
			{
				var src:String = this.getSource(code);
				this._assembler = new AGALMiniAssembler();
				this._assembler.assemble(this._type, src, VERSION);
			}
		}
		
		public function dispose():void
		{
			this._assembler = null;
			this._attribute = null;
			this._uniform = null;
			this._vecMap = null;
		}
		
		private function getSource(p_arr:Array):String
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
			if (!this._assembler)
			{
				return new ByteArray();
			}
			return this._assembler.agalcode;
		}
		
		public function getAttributeCode(p_name:String):int
		{
			var item:Object = this._attribute[p_name];
			if (!item)
			{
				return -1;
			}
			// to do
			return 0;
		}
		
		public function setConst(p_name:String, p_value:Object):void
		{
			var item:Object = this._uniform[p_name];
			if (!item)
			{
				return;
			}
			if (!Helper.hasValueString(item, "type"))
			{
				return;
			}
			var type:String = item.type as String;
			switch (type)
			{
			case CONST_TYPE_INT: 
				if (!(p_value is int))
				{
					return;
				}
				item.value = p_value;
				break;
			case CONST_TYPE_FLOAT: 
				if (!(p_value is Number))
				{
					return;
				}
				item.value = p_value;
				break;
			case CONST_TYPE_VEC2: 
				if (!(p_value is Vector2D))
				{
					return;
				}
				var valueVec2:Vector2D = p_value as Vector2D;
				item.value = [valueVec2.x, valueVec2.y];
				break;
			case CONST_TYPE_VEC3: 
				if (!(p_value is Vector3D))
				{
					return;
				}
				var valueVec3:Vector3D = p_value as Vector3D;
				item.value = [valueVec3.x, valueVec3.y, valueVec3.z];
				break;
			case CONST_TYPE_VEC4: 
				if (!(p_value is Vector4D))
				{
					return;
				}
				var valueVec4:Vector4D = p_value as Vector4D;
				item.value = [valueVec4.x, valueVec4.y, valueVec4.z, valueVec4.w];
				break;
			case CONST_TYPE_MATRIX: 
				if (!(p_value is Matrix4D))
				{
					return;
				}
				var valueMatrix:Matrix4D = p_value as Matrix4D;
				item.value = valueMatrix.toArray();
				break;
			default: 
				return;
			}
		}
		
		public function update(p_context:Context3D):void
		{
			for each (var item:Object in this._uniform)
			{
				if (!Helper.hasValueInteger(item, "code"))
				{
					continue;
				}
				var code:int = item.code as int;
				if (!Helper.hasValueString(item, "type"))
				{
					continue;
				}
				var type:String = item.type as String;
				switch (type)
				{
				case CONST_TYPE_INT: 
				case CONST_TYPE_FLOAT: 
					var valueFloat:Number = 0;
					if (type == CONST_TYPE_INT)
					{
						if (!Helper.hasValueInteger(item, "value"))
						{
							continue;
						}
						var valueInt:int = item.value;
						valueFloat = valueInt;
					}
					else
					{
						if (!Helper.hasValueNumber(item, "value"))
						{
							continue;
						}
						valueFloat = item.value;
					}
					if (!Helper.hasValueString(item, "subcode"))
					{
						continue;
					}
					var subcode:String = item.subcode;
					var vecGroup:Array = this._vecMap[code] as Array;
					if (!vecGroup)
					{
						vecGroup = [0, 0, 0, 0];
						this._vecMap[code] = vecGroup;
					}
					switch (subcode)
					{
					case "x": 
						vecGroup[0] = valueFloat;
						break;
					case "y": 
						vecGroup[1] = valueFloat;
						break;
					case "z": 
						vecGroup[2] = valueFloat;
						break;
					case "w": 
						vecGroup[3] = valueFloat;
						break;
					default: 
						continue;
					}
					p_context.setProgramConstantsFromVector(this._type, code, Vector.<Number>(vecGroup));
					break;
				case CONST_TYPE_VEC2: 
					if (!Helper.hasValueArray(item, "value"))
					{
						continue;
					}
					var valueVec2:Array = item.value;
					if (valueVec2.length != 2)
					{
						continue;
					}
					p_context.setProgramConstantsFromVector(this._type, code, Vector.<Number>(valueVec2));
					break;
				case CONST_TYPE_VEC3: 
					if (!Helper.hasValueArray(item, "value"))
					{
						continue;
					}
					var valueVec3:Array = item.value;
					if (valueVec3.length != 3)
					{
						continue;
					}
					p_context.setProgramConstantsFromVector(this._type, code, Vector.<Number>(valueVec3));
					break;
				case CONST_TYPE_VEC4: 
					if (!Helper.hasValueArray(item, "value"))
					{
						continue;
					}
					var valueVec4:Array = item.value;
					if (valueVec4.length != 4)
					{
						continue;
					}
					p_context.setProgramConstantsFromVector(this._type, code, Vector.<Number>(valueVec4));
					break;
				case CONST_TYPE_MATRIX: 
					if (!Helper.hasValueArray(item, "value"))
					{
						continue;
					}
					var valueMatrix:Array = item.value;
					if (valueMatrix.length != 16)
					{
						continue;
					}
					p_context.setProgramConstantsFromVector(this._type, code, Vector.<Number>(valueMatrix));
					break;
				default: 
					continue;
				}
			}
		}
		
		public function updateObj(p_context:Context3D, p_obj:J3DObject):void
		{
			;
		}
	
	}
}