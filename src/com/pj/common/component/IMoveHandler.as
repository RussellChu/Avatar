package com.pj.common.component 
{
	import com.pj.common.math.Vector2D;
	
	/**
	 * ...
	 * @author Russell
	 */
	public interface IMoveHandler 
	{
		function checkMove(p_from:Vector2D, p_to:Vector2D):Vector2D;
		function onMoveComplete(p_to:Vector2D):void;
	}
}