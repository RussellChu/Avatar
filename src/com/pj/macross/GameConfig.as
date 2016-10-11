package com.pj.macross
{
	
	/**
	 * ...
	 * @author Russell
	 */
	public class GameConfig
	{
		static public const SAVE_VERSION:int = 1;
		
		//static public const CELL_RADIUS_MAP:int = 16;
		//static public const CELL_SIDE_MAP:int = 1;
		//static public const FONT_SIZE_MAP:int = 8;
		
		//static public const CELL_RADIUS_MAP:int = 32;
		//static public const CELL_SIDE_MAP:int = 2;
		//static public const FONT_SIZE_MAP:int = 12;
		
		//static public const CELL_RADIUS_MAP:int = 135;
		//static public const CELL_SIDE_MAP:int = 6;
		//static public const FONT_SIZE_MAP:int = 72;
		
		static public const CELL_RADIUS_MAP:int = 113;
		static public const CELL_SIDE_MAP:int = 5;
		static public const FONT_SIZE_MAP:int = 36;
		
	//	static public const FONT_COLOR_MAP:uint = 0xff00ff;
		static public const FONT_COLOR_MAP:uint = 0x000000;
		
		static public const CELL_BASE_A:Array = [0, 2, 3, 598, 625, 626];
		static public const CELL_BASE_B:Array = [247, 274, 275, 585, 612, 613];
		static public const CELL_BASE_C:Array = [234, 261, 262, 611, 638, 639];
		static public const CELL_OBSTACLE:Array = [//
		211, 212, 238, 239, 265, 266, 292, 293, 319, 320, 346, 347, 373, 374, 400, 401, 428//
		, 214, 215, 242, 243, 270, 271, 298, 299, 326, 327, 354, 355, 382, 383, 410, 411, 438//
		, 484, 485, 486, 487, 488, 489, 490, 491, 492, 512, 513, 514, 515, 516, 517, 518, 519//
		];
		
		// No.2
		static public const CELL_OBSTACLE_OUT:Array = [//
		11, 13, 24, 47, 77, 91, 92, 126, 143, 145//
		, 194, 199, 227, 231, 387, 421, 443, 473, 501, 502//
		, 619, 621, 666, 667, 683, 686, 697, 751, 752, 754//
		];
		// No.7
		//static public const CELL_OBSTACLE_OUT:Array = [//
		//23, 114, 119, 132, 142, 143, 145, 147, 152, 169//
		//, 173, 174, 182, 197, 198, 228, 332, 385, 446, 453//
		//, 549, 567, 649, 688, 739, 740, 742, 747, 749, 754//
		//];
		
		static public const CELL_HOSTAGE:Array = [//
		40, 66, 81, 96, 117, 127, 139, 144, 146, 148//
		, 170, 224, 257, 294, 307, 324, 366, 376, 381//
		, 414, 434, 459, 499, 507, 551, 593, 617, 702, 710//
		, 716, 727, 748, 756//
		];
		
		static public const MAP_RADIUS:int = 10;
		
		public function GameConfig()
		{
			;
		}
	
	}
}