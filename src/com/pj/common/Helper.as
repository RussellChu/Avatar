package com.pj.common
{
	
	/**
	 * ...
	 * @author Russell
	 */
	public class Helper
	{
		static public function cloneJSON(p_data:Object):Object {
			if (p_data == null) {
				return null;
			}
			
			return JSON.parse(JSON.stringify(p_data));
		}
		
		static public function dispose(p_obj:Object):Boolean
		{
			if (!p_obj)
			{
				return false;
			}
			if (p_obj is IDisposable)
			{
				(p_obj as IDisposable).dispose();
				return true;
			}
			if (p_obj is Vector.<*>)
			{
				for each (var item:Object in p_obj)
				{
					dispose(item);
				}
				return true;
			}
			return false;
		}
		
		static public function loop(p_max:Object, p_func:Function):void
		{
			var counter:Array = [];
			var max:Array = [];
			var keyList:Array = [];
			var isEnd:Boolean = false;
			for (var key:String in p_max)
			{
				var value:int = p_max[key];
				max.push(value);
				keyList.push(key);
				counter.push(0);
				if (value < 0)
				{
					isEnd = true;
				}
			}
			if (counter.length == 0)
			{
				isEnd = true;
			}
			
			var i:int = 0;
			while (!isEnd)
			{
				var count:Object = {};
				for (i = 0; i < counter.length; i++)
				{
					count[keyList[i]] = counter[i];
				}
				if (!p_func(count))
				{
					return;
				}
				if (!isEnd)
				{
					var ptr:int = 0;
					for (i = 0; i < counter.length; i++)
					{
						counter[i]++;
						if (counter[i] < max[i])
						{
							break;
						}
						counter[i] = 0;
						if (i + 1 == counter.length)
						{
							isEnd = true;
						}
					}
				}
			}
		}
		
		static public function hasValue(p_obj:Object, p_key:String):Boolean {
			if (!p_obj) {return false;}
			if (!p_obj.hasOwnProperty(p_key)) {return false;}
			return true;
		}
		
		static public function hasValueBoolean(p_obj:Object, p_key:String):Boolean {
			if (!p_obj) {return false;}
			if (!p_obj.hasOwnProperty(p_key)) {return false;}
			if (p_obj[p_key] is Boolean) {return true;}
			return false;
		}
		
		static public function hasValueInteger(p_obj:Object, p_key:String):Boolean {
			if (!p_obj) {return false;}
			if (!p_obj.hasOwnProperty(p_key)) {return false;}
			if (p_obj[p_key] is int) {return true;}
			return false;
		}
		
		static public function hasValueNumber(p_obj:Object, p_key:String):Boolean {
			if (!p_obj) {return false;}
			if (!p_obj.hasOwnProperty(p_key)) {return false;}
			if (p_obj[p_key] is int) {return true;}
			if (p_obj[p_key] is Number) {return true;}
			return false;
		}
		
		static public function hasValueString(p_obj:Object, p_key:String):Boolean {
			if (!p_obj) {return false;}
			if (!p_obj.hasOwnProperty(p_key)) {return false;}
			if (p_obj[p_key] is String) {return true;}
			return false;
		}
		
		static public function hasValueObject(p_obj:Object, p_key:String):Boolean {
			if (!p_obj) {return false;}
			if (!p_obj.hasOwnProperty(p_key)) {return false;}
			if (p_obj[p_key] is Object) {return true;}
			return false;
		}
		
		static public function hasValueArray(p_obj:Object, p_key:String):Boolean {
			if (!p_obj) {return false;}
			if (!p_obj.hasOwnProperty(p_key)) {return false;}
			if (p_obj[p_key] is Array) {return true;}
			return false;
		}
		
		static public function getValueBoolean(p_obj:Object, p_key:String, p_default:Boolean = false):Boolean {
			if (!p_obj) {return p_default;}
			if (!p_obj.hasOwnProperty(p_key)) {return p_default;}
			if (p_obj[p_key] is Boolean) {return p_obj[p_key];}
			return p_default;
		}
		
		static public function getValueInteger(p_obj:Object, p_key:String, p_default:int = 0):int {
			if (!p_obj) {return p_default;}
			if (!p_obj.hasOwnProperty(p_key)) {return p_default;}
			if (p_obj[p_key] is int) {return p_obj[p_key];}
			return p_default;
		}
		
		static public function getValueNumber(p_obj:Object, p_key:String, p_default:Number = 0):Number {
			if (!p_obj) {return p_default;}
			if (!p_obj.hasOwnProperty(p_key)) {return p_default;}
			if (p_obj[p_key] is int) {return p_obj[p_key];}
			if (p_obj[p_key] is Number) {return p_obj[p_key];}
			return p_default;
		}
		
		static public function selectFrom(p_arr:Array):Object {
			var index:int = int(Math.random() * p_arr.length);
			return p_arr[index];
		}
		
		public function Helper()
		{
			;
		}
	
	}
}