package com.pj.macross
{
	
	/**
	 * ...
	 * @author Russell
	 */
	public class GameConfig
	{
		static public const CAP_ID:String = "";
		static public const SAVE_VERSION:int = 1;
		
		static public const CELL_RADIUS_MAP:int = 16;
		static public const CELL_SIDE_MAP:int = 1;
		static public const FONT_SIZE_MAP:int = 12;
		
		//static public const CELL_RADIUS_MAP:int = 32;
		//static public const CELL_SIDE_MAP:int = 2;
		//static public const FONT_SIZE_MAP:int = 12;
		
		//static public const CELL_RADIUS_MAP:int = 113;
		//static public const CELL_SIDE_MAP:int = 5;
		//static public const FONT_SIZE_MAP:int = 36;
		
		static public const FONT_COLOR_MAP:uint = 0xff00ff;
		//	static public const FONT_COLOR_MAP:uint = 0x000000;
		
		static public const CELL_BASE_A:Array = [0, 2, 3, 598, 625, 626];
		static public const CELL_BASE_B:Array = [247, 274, 275, 585, 612, 613];
		static public const CELL_BASE_C:Array = [234, 261, 262, 611, 638, 639];
		static public const CELL_OBSTACLE:Array = [//
		211, 212, 238, 239, 265, 266, 292, 293, 319, 320, 346, 347, 373, 374, 400, 401, 428//
		, 214, 215, 242, 243, 270, 271, 298, 299, 326, 327, 354, 355, 382, 383, 410, 411, 438//
		, 484, 485, 486, 487, 488, 489, 490, 491, 492, 512, 513, 514, 515, 516, 517, 518, 519//
		];
		static public const CELL_NO_OBSTACLE:Array = [//
		1, 4, 7, 8, 9, 183, 184, 185, 186, 187//
		, 188, 206, 207, 210, 213, 216, 219, 220, 233, 235//
		, 237, 240, 241, 244, 246, 248, 260, 263, 264, 267//
		, 268, 269, 272, 273, 276, 288, 289, 290, 291, 294//
		, 295, 296, 297, 300, 301, 302, 303, 318, 321, 322//
		, 323, 324, 325, 328, 345, 348, 349, 350, 351, 352//
		, 353, 356, 372, 375, 376, 377, 378, 379, 380, 381//
		, 384, 399, 402, 403, 404, 405, 406, 407, 408, 409//
		, 412, 427, 429, 430, 431, 432, 433, 434, 435, 436//
		, 437, 439, 455, 456, 457, 458, 459, 460, 461, 462//
		, 463, 464, 465, 466, 483, 493, 511, 520, 539, 540//
		, 541, 542, 543, 544, 545, 546, 547, 557, 558, 570//
		, 571, 583, 584, 586, 597, 599, 610, 614, 624, 627//
		, 637, 640, 651, 652, 653, 664//
		];
		
		static public const CELL_HOSTAGE:Array = [294, 324, 376, 381, 434, 459];
		static public const CELL_NO_HOSTAGE:Array = [//
		1, 4, 7, 8, 9, 157, 158, 159, 184, 185//
		, 186, 187, 206, 207, 213, 219, 220, 233, 235, 240//
		, 241, 246, 248, 260, 263, 267, 268, 269, 273, 276//
		, 288, 289, 290, 294, 295, 296, 297, 301, 302, 303//
		, 321, 322, 323, 324, 325, 348, 349, 350, 351, 352//
		, 353, 375, 376, 377, 378, 379, 380, 381, 402, 403//
		, 404, 405, 406, 407, 408, 409, 427, 429, 430, 431//
		, 432, 433, 434, 435, 436, 437, 439, 454, 455, 456//
		, 457, 458, 459, 460, 461, 462, 463, 464, 465, 466//
		, 467, 482, 483, 493, 494, 510, 511, 520, 521, 557//
		, 558, 570, 571, 583, 584, 586, 597, 599, 610, 614//
		, 624, 627, 637, 640, 651, 652, 653, 664//
		];
		
		static public const MAP_RADIUS:int = 10;
		
		public function GameConfig()
		{
			;
		}
	
	}
}