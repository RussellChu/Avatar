package com.pj.macross.asset
{
	import com.pj.common.JSignal;
	import com.pj.common.Creater;
	import com.pj.common.ICreatable;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class CellSkin implements ICreatable
	{
		private var _creater:Creater = null;
		private var _signal:JSignal = null;
		
		public function CellSkin()
		{
			;
		}
		
		/* INTERFACE com.pj.common.ICreatable */
		
		public function get creater():Creater
		{
			return _creater;
		}
		
		public function onCreate():void
		{
			;
		}
		
		public function get signal():JSignal
		{
			return _signal;
		}
	
	}
}