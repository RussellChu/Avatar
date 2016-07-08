package com.pj.common
{
	
	/**
	 * ...
	 * @author Russell
	 */
	public class Helper
	{
		public static function dispose(p_obj:Object):Boolean
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
		
		public static function loop(p_max:Object, p_func:Function):void
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
		
		public function Helper()
		{
			;
		}
	
	}
}