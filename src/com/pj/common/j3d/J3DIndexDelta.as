package com.pj.common.j3d
{
	
	/**
	 * ...
	 * @author Russell
	 */
	public class J3DIndexDelta extends J3DIndex
	{
		public function J3DIndexDelta()
		{
			super();
		}
		
		public function addData(p_v0:uint, p_v1:uint, p_v2:uint):void
		{
			this._data.push(p_v0, p_v1, p_v2);
		}
	
	}
}