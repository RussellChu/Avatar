package com.pj.macross
{
	
	/**
	 * ...
	 * @author Russell
	 */
	public class GameData
	{
		static public const SIDE_A:int = 1;
		static public const SIDE_B:int = 2;
		static public const SIDE_C:int = 3;
		
		static public const STATE_NONE:int = 0;
		static public const STATE_BASE:int = 1;
		static public const STATE_ROAD:int = 2;
		static public const STATE_ROAD_EX:int = 3;
		static public const STATE_OBSTACLE:int = 4;
		static public const STATE_HOSTAGE:int = 5;
		
		static public const COMMAND_NONE:int = 0;
		static public const COMMAND_ROAD:int = 1;
		static public const COMMAND_ROAD_EX:int = 2;
		static public const COMMAND_ATTACK:int = 3; // Replace enemy's cell
		
		public function GameData()
		{
			;
		}
	
	}
}