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
		static public const STATE_HOSTAGE_BG:int = 6;
		static public const STATE_ATTACK:int = 7;
		
		static public const COMMAND_NONE:int = 0;
		static public const COMMAND_ROAD:int = 1;
		static public const COMMAND_ROAD_EX:int = 2;
		static public const COMMAND_ATTACK:int = 3; // Replace enemy's cell
		// other commands
		static public const COMMAND_UNDO:int = 4;
		static public const COMMAND_CLEAR:int = 5;
		static public const COMMAND_SAVE:int = 6;
		static public const COMMAND_LANG:int = 7;
		static public const COMMAND_TIPS:int = 8;
		static public const COMMAND_OPEN:int = 9;
		static public const COMMAND_AUTO:int = 10;
		static public const COMMAND_PRINT:int = 11;
		
		public function GameData()
		{
			;
		}
	
	}
}