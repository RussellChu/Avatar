package com.pj.common.component
{
	
	/**
	 * ...
	 * @author Russell
	 */
	public interface IContainer
	{
		function addChild(p_child:BasicObject):BasicObject
		function resize(p_width:int, p_height:int):void
	}
}