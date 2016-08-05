package com.pj.common.j3d.shader
{
	import flash.display3D.Context3D;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class J3DShaderCompiler
	{
		//private static const TYPE_MAP:Object = { //
			//"float": true //
			//, "vec2": true //
			//, "vec3": true //
			//, "vec4": true //
		//};
		//private static const VARY_MAP:Object = { //
			//"_": true //
			//, "va0": true //
			//, "va1": true //
			//, "va2": true //
			//, "va3": true //
			//, "va4": true //
			//, "va5": true //
			//, "va6": true //
			//, "va7": true //
			//, "v0": true //
			//, "v1": true //
			//, "v2": true //
			//, "v3": true //
			//, "v4": true //
			//, "v5": true //
			//, "v6": true //
			//, "v7": true //
			//, "oc": true //
			//, "op": true //
		//};
		//private static const CODE_MAP:Object = { //
			//"_": {} //
			//// self
			//, "var": {len: 2} //
			//, "set": {len: 0} // len: 0 -> vary
			//// system
			//, "mov": {len: 3} //
			//, "add": {len: 3} //
			//, "sub": {len: 3} //
			//, "mul": {len: 3} //
			//, "div": {len: 3} //
			//, "rcp": {len: 3} //
			//, "min": {len: 3} //
			//, "max": {len: 3} //
			//, "frc": {len: 3} //
			//, "sqt": {len: 3} //
			//, "rsq": {len: 3} //
			//, "pow": {len: 3} //
			//, "log": {len: 3} //
			//, "exp": {len: 3} //
			//, "nrm": {len: 3} //
			//, "sin": {len: 3} //
			//, "cos": {len: 3} //
			//, "crs": {len: 3} //
			//, "dp3": {len: 3} //
			//, "dp4": {len: 3} //
			//, "abs": {len: 3} //
			//, "neg": {len: 3} //
			//, "sat": {len: 3} //
			//, "m33": {len: 3} //
			//, "m44": {len: 3} //
			//, "m34": {len: 3} //
			//, "kil": {len: 3} //
			//, "tex": {len: 3} //
			//, "sge": {len: 3} //
			//, "slt": {len: 3} //
			//, "seq": {len: 3} //
			//, "sne": {len: 3} //
			//, "ddx": {len: 3} //
			//, "ddy": {len: 3} //
			//, "ife": {len: 3} //
			//, "ine": {len: 3} //
			//, "ifg": {len: 3} //
			//, "ifl": {len: 3} //
			//, "els": {len: 3} //
			//, "eif": {len: 3} //
		//};
		//
		//private var _node:Object = null;
		//private var _code:String = "";
		
		public function J3DShaderCompiler()
		{
		//	this.reset();
		}
		
		//private function reset():void
		//{
			//this._node = {};
			//this._code = "";
		//}
		//
		//private function log(p_tag:String, p_line:int, p_msg:String):void
		//{
			//if (p_line > 0)
			//{
				//trace("log :: ", p_tag, " (", p_line, ") >> ", p_msg);
			//}
			//else
			//{
				//trace("log :: ", p_tag, " >> ", p_msg);
			//}
		//}
		//
		//private function error(p_tag:String, p_line:int, p_msg:String):void
		//{
			//if (p_line > 0)
			//{
				//trace("error :: ", p_tag, " (", p_line, ") >> ", p_msg);
			//}
			//else
			//{
				//trace("error :: ", p_tag, " >> ", p_msg);
			//}
		//}
		/*
		   private function passNameVaryMap(p_name:String):Boolean
		   {
		   if (p_name == "")
		   {
		   this.error("passNameVaryMap", 0, "no data");
		   return false;
		   }
		   if (VARY_MAP[p_name])
		   {
		   this.error("passNameVaryMap", 0, "fail >> " + p_name);
		   return false;
		   }
		   return true;
		   }
		
		   private function passNameCodeMap(p_name:String):Boolean
		   {
		   if (!this.passNameVaryMap(p_name))
		   {
		   return false;
		   }
		   if (CODE_MAP[p_name])
		   {
		   this.error("passNameCodeMap", 0, "fail >> " + p_name);
		   return false;
		   }
		   return true;
		   }
		
		   private function registerVarying():Boolean
		   {
		   this.log("registerVarying", 0, "Start");
		   var src:Object = this._node.varying;
		   if (!src)
		   {
		   this.log("registerVarying", 0, "No src");
		   return true;
		   }
		   for (var key:String in src)
		   {
		   if (!this.passNameCodeMap(key))
		   {
		   return false;
		   }
		   if (!VARY_MAP[key]) {
		   this.error("registerVarying", 0, "not varying key >> " + key);
		   return false;
		   }
		   var data:Object = src[key];
		   if (!data)
		   {
		   this.error("registerVarying", 0, "No data >> " + key);
		   return false;
		   }
		   var name:String = data.name;
		   if (!name)
		   {
		   this.error("registerVarying", 0, "No name >> " + key);
		   return false;
		   }
		   var type:String = data.type;
		   if (!type)
		   {
		   this.error("registerVarying", 0, "No type >> " + key);
		   return false;
		   }
		   if (this._varying[name]) {
		   this.error("registerVarying", 0, "Repeated name >> " + key + " - " + name);
		   return false;
		   }
		
		   }
		   return true;
		   }
		
		   private function registerUniform():Boolean
		   {
		   this.log("registerUniform", 0, "Start");
		   var src:Object = this._node.uniform;
		   if (!src)
		   {
		   this.log("registerUniform", 0, "No data");
		   return true;
		   }
		   return true;
		   }
		
		   private function registerMethod():Boolean
		   {
		   this.log("registerMethod", 0, "Start");
		   var src:Object = this._node.method;
		   if (!src)
		   {
		   this.error("registerMethod", 0, "No data");
		   return false;
		   }
		   return true;
		   }
		
		   private function compileMain():Boolean
		   {
		   this.log("compileMain", 0, "Start");
		   return true;
		   }
		 */
		//
		
		
		//public function compile(p_node:Object):void
		//{
			//this.log("System", 0, "Start");
			//this.reset();
			//this._node = p_node;
			//if (!this._node)
			//{
				//this.error("System", 0, "no node");
				//return;
			//}
		//	this._varibleManager.loadVarying(this._node.varying);
			/*
			   if (!this.registerVarying())
			   {
			   this.error("System", 0, "registerVarying fail");
			   return;
			   }
			   if (!this.registerUniform())
			   {
			   this.error("System", 0, "registerUniform fail");
			   return;
			   }
			   if (!this.registerMethod())
			   {
			   this.error("System", 0, "registerMethod fail");
			   return;
			   }
			   if (!this.compileMain())
			   {
			   this.error("System", 0, "compileMain fail");
			   return;
			   }
			 */
			//this.log("System", 0, "Finish");
		//}
		//
		//private function read(p_src:Array):Boolean {
			//if (!p_src) {
				//return false;
			//}
			//
			//if (p_src.length < 1) {
				//return false;
			//}
			//
			//var code:String = p_src[0];
			//switch(code){
				//case "mov":
					//break;
				//default:
					//return false;
			//}
			//
			//
			//var opCode:String = p_src[0];
			//var opCodeData:OpCodeData = OpCodeManager.find( opCode );
			//if (!opCodeData) {
				//return false;
			//}
			//
			//var size:int = p_src.length - 1;
			//if (size != opCodeData.size) {
				//return false;
			//}
			//
			//switch(opCode) {
				//case "var":
					//break;
				//case "set":
				//default:
					//return false;
			//}
			//
			// testing
		//	var d:Context3D;
		//	d.setProgramConstantsFromMatrix;
		//	d.setProgramConstantsFromVector;
			
			//return true;
		//}
	
	}
}

//class VaribleItem
//{
	//private var _group:int = 0;
	//private var _name:String = "";
	//private var _type:String = "";
	//private var _code:String = "";
	//private var _readable:Boolean = false;
	//private var _writable:Boolean = false;
	//
	//public function VaribleItem(p_group:int, p_name:String, p_type:String, p_code:String = "", p_readable:Boolean = true, p_writable:Boolean = true):void
	//{
		//this._group = p_group;
		//this._name = p_name;
		//this._type = p_type;
		//this._code = p_code;
		//this._readable = p_readable;
		//this._writable = p_writable;
	//}
	//
	//public function get group():int  { return this._group; }
	//
	//public function get name():String  { return this._name; }
	//
	//public function get type():String  { return this._type; }
	//
	//public function get code():String  { return this._code; }
	//
	//public function get readable():Boolean  { return this._readable; }
	//
	//public function get writable():Boolean  { return this._writable; }
//}
//
//class VaribleMap
//{
	//public static const SHADER_VERTEX:int = 0;
	//public static const SHADER_PIXEL:int = 1;
	//
	//public static const GROUP_LOCAL:int = 0;
	//public static const GROUP_ATTRIBUTE:int = 1;
	//public static const GROUP_UNIFORM:int = 2;
	//public static const GROUP_VARYING:int = 3;
	//public static const GROUP_OUTPUT:int = 4;
	//
	///* AGAL version 2
	 //* vs:
	 //* local: vt0-vt25
	 //* attribute: va0-va7
	 //* uniform: vc0-vc249
	 //* varying: v0-v9
	 //* output: op
	 //* ps:
	 //* local: ft0-ft25
	 //* attribute: (null)
	 //* uniform: fc0-fc63
	 //* varying: v0-v9
	 //* sampler: fs0-fs7
	 //* output: oc,fd
	 //*/
	//
	//private var _codeLocal:Object = null;
	//private var _map:Object = null;
	//
	//public function VaribleMap(p_shader:int):void
	//{
		//this._map = {};
		//if (p_shader == SHADER_VERTEX) {
			//this._codeLocal = {};
		//} else {
			//;
		//}
	//}
	//
	//public function find(p_name:String):VaribleItem
	//{
		//return this._map[p_name] as VaribleItem;
	//}
	//
	//private function register(p_group:int, p_name:String, p_type:String, p_code:String = "", p_readable:Boolean = true, p_writable:Boolean = true):Boolean
	//{
		//var item:VaribleItem = this.find(p_name);
		//if (item)
		//{
			//return false;
		//}
		//item = new VaribleItem(p_group, p_name, p_type, p_code, p_readable, p_writable);
		//this._map[p_name] = item;
		//return true;
	//}
	//
	//public function registerLocal(p_parent:String, p_name:String, p_type:String)
	//{
		//var name:String = p_parent + "::" + p_name;
		//var item:VaribleItem = this.find(name);
		//if (item)
		//{
			//return false;
		//}
		//// to do
		//var code:String = "";
		//item = new VaribleItem(VaribleItem.GROUP_LOCAL, name, p_type, code, true, true);
		//return true;
	//}
	//
	//public function registerAttribute(p_name:String, p_type:String, p_code:String = "")
	//{
		//return this.register(VaribleItem.GROUP_ATTRIBUTE, p_name, p_type, p_code, true, false);
	//}
	//
	//public function registerUniform(p_name:String, p_type:String)
	//{
		//return this.register(VaribleItem.GROUP_UNIFORM, p_name, p_type, "", true, false);
	//}
	//
	//public function registerVarying(p_name:String, p_type:String, p_code:String = "")
	//{
		//return this.register(VaribleItem.GROUP_VARYING, p_name, p_type, p_code, true, true);
	//}
	//
	//public function registerOutput(p_name:String, p_type:String, p_code:String = "")
	//{
		//return this.register(VaribleItem.GROUP_OUTPUT, p_name, p_type, p_code, false, true);
	//}
//}
//
//class NameManager
//{
	//public function NameManager():void
	//{
		//;
	//}
//}
//
//class VaribleManager
//{
	//private var _nameManager:NameManager = null;
	//
	//public function VaribleManager():void
	//{
		//this._nameManager = new NameManager();
	//}
	//
	//public function loadVarying(p_data:Object):void
	//{
		//if (!p_data)
		//{
			//return;
		//}
	//
		////	var item:VaribleItem
	//}
//}
//
//class FunctionManager
//{
	//public function FunctionManager():void
	//{
		//;
	//}
//}
//
//class CodeManager
//{
	//public function CodeManager():void
	//{
		//;
	//}
//}

/*
   class J3DShaderVarying {
   private var _code:String = "";
   private var _name:String = "";
   private var _type:String = "";
   public function J3DShaderVarying () {
   ;
   }
   }
 */
