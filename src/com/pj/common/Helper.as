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
		
		public function Helper()
		{
			;
		}
	
	}
}