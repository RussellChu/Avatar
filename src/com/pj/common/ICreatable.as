package com.pj.common 
{
	
	/**
	 * ...
	 * @author Russell
	 */
	public interface ICreatable extends IHasSignal
	{
		function get creater():Creater
		function onCreate():void
	}
}