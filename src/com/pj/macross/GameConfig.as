package com.pj.macross
{
	import com.pj.common.Helper;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class GameConfig
	{
		static private var __capId:String = "";
		static private var __saveVer:int = 20161011;
		
		static private var __cellRadius:int = 32;
		static private var __cellMargin:int = 2;
		static private var __fontSize:int = 12;
		static private var __fontColor:uint = 0xff00ff;
		static private var __fontDisplay:Boolean = false;
		static private var __foldAniSrcLoad:Boolean = true;
		static private var __foldAniSrcWidth:int = 64;
		static private var __mapRadius:int = 10;
		static private var __mapRandom:Boolean = false;
		
		static private var __mapBaseA:Array = [0, 2, 3, 598, 625, 626];
		static private var __mapBaseB:Array = [247, 274, 275, 585, 612, 613];
		static private var __mapBaseC:Array = [234, 261, 262, 611, 638, 639];
		static private var __mapObstacle:Array = [//
		211, 212, 238, 239, 265, 266, 292, 293, 319, 320, 346, 347, 373, 374, 400, 401, 428//
		, 214, 215, 242, 243, 270, 271, 298, 299, 326, 327, 354, 355, 382, 383, 410, 411, 438//
		, 484, 485, 486, 487, 488, 489, 490, 491, 492, 512, 513, 514, 515, 516, 517, 518, 519//
		];
		static private var __mapObstacleOut:Array = [//
		22, 38, 40, 64, 67, 71, 73, 98, 99, 114//
		, 228, 281, 335, 338, 361, 388, 419, 422, 445, 499//
		, 617, 647, 659, 668, 671, 706, 709, 719, 736, 742];
		static private var __mapObstacleClear:Array = [//
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
		static private var __mapHostageCenter:Array = [294, 324, 376, 381, 434, 459];
		static private var __mapHostageClear:Array = [//
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
		static private var __mapHostageA:Array = [35, 108, 131, 168, 192, 199, 376, 381, 448, 468, 502, 526, 563, 567, 607, 622, 642, 669, 698, 701, 711, 754];
		static private var __mapHostageB:Array = [41, 44, 87, 92, 129, 143, 166, 202, 279, 287, 294, 359, 385, 396, 417, 434, 481, 497, 528, 684, 686, 722];
		static private var __mapHostageC:Array = [11, 14, 32, 55, 79, 122, 145, 153, 182, 258, 324, 339, 364, 459, 505, 522, 537, 589, 631, 654, 729, 752];
		
		static private var __cmdStore:int = 10;
		
		static private var __demoSpeed:int = 1000;
		
		static private var __demoCmd:Array = null;
		
		static private var __scoreMax:int = 22;
		
		static public function getCapId():String  { return __capId; }
		
		static public function getSaveVer():int  { return __saveVer; }
		
		static public function getCellRadius():int  { return __cellRadius; }
		
		static public function getCellMargin():int  { return __cellMargin; }
		
		static public function getFontSize():int  { return __fontSize; }
		
		static public function getFontColor():uint  { return __fontColor; }
		
		static public function getFontDisplay():Boolean  { return __fontDisplay; }
		
		static public function getFoldAniSrcLoad():Boolean  { return __foldAniSrcLoad; }
		
		static public function getFoldAniSrcWidth():int  { return __foldAniSrcWidth; }
		
		static public function getMapRadius():int  { return __mapRadius; }
		
		static public function getMapRandom():Boolean  { return __mapRandom; }
		
		static public function getMapBaseA():Array  { return __mapBaseA; }
		
		static public function getMapBaseB():Array  { return __mapBaseB; }
		
		static public function getMapBaseC():Array  { return __mapBaseC; }
		
		static public function getMapObstacle():Array  { return __mapObstacle; }
		
		static public function getMapObstacleOut():Array  { return __mapObstacleOut; }
		
		static public function getMapObstacleClear():Array  { return __mapObstacleClear; }
		
		static public function getMapHostageCenter():Array  { return __mapHostageCenter; }
		
		static public function getMapHostageClear():Array  { return __mapHostageClear; }
		
		static public function getMapHostageA():Array  { return __mapHostageA; }
		
		static public function getMapHostageB():Array  { return __mapHostageB; }
		
		static public function getMapHostageC():Array  { return __mapHostageC; }
		
		static public function getCmdStore():int  { return __cmdStore; }
		
		static public function getDemoSpeed():int  { return __demoSpeed; }
		
		static public function getDemoCmd():Array
		{
			if (__demoCmd)
			{
				if (__demoCmd.length > 0)
				{
					return __demoCmd;
				}
			}
			return [GameData.COMMAND_ROAD, GameData.COMMAND_ROAD, GameData.COMMAND_ROAD, GameData.COMMAND_ROAD_EX, GameData.COMMAND_ATTACK, GameData.COMMAND_ATTACK];
		}
		
		static public function getScoreMax():int  { return __scoreMax; }
		
		static public function update(p_data:Object):void
		{
			__capId = Helper.getValueString(p_data, "capId", __capId);
			__saveVer = Helper.getValueInteger(p_data, "saveVer", __saveVer);
			__cellRadius = Helper.getValueInteger(p_data, "cellRadius", __cellRadius);
			__cellMargin = Helper.getValueInteger(p_data, "cellMargin", __cellMargin);
			__fontSize = Helper.getValueInteger(p_data, "fontSize", __fontSize);
			__fontColor = Helper.getValueUInt(p_data, "fontColor", __fontColor);
			__fontDisplay = Helper.getValueBoolean(p_data, "fontDisplay", __fontDisplay);
			__foldAniSrcLoad = Helper.getValueBoolean(p_data, "foldAniSrcLoad", __foldAniSrcLoad);
			__foldAniSrcWidth = Helper.getValueInteger(p_data, "foldAniSrcWidth", __foldAniSrcWidth);
			__mapRadius = Helper.getValueInteger(p_data, "mapRadius", __mapRadius);
			__mapRandom = Helper.getValueBoolean(p_data, "mapRandom", __mapRandom);
			__mapBaseA = Helper.getValueArray(p_data, "mapBaseA", __mapBaseA);
			__mapBaseB = Helper.getValueArray(p_data, "mapBaseB", __mapBaseB);
			__mapBaseC = Helper.getValueArray(p_data, "mapBaseC", __mapBaseC);
			__mapObstacle = Helper.getValueArray(p_data, "mapObstacle", __mapObstacle);
			__mapObstacleOut = Helper.getValueArray(p_data, "mapObstacleOut", __mapObstacleOut);
			__mapObstacleClear = Helper.getValueArray(p_data, "mapObstacleClear", __mapObstacleClear);
			__mapHostageCenter = Helper.getValueArray(p_data, "mapHostageCenter", __mapHostageCenter);
			__mapHostageClear = Helper.getValueArray(p_data, "mapHostageClear", __mapHostageClear);
			__mapHostageA = Helper.getValueArray(p_data, "mapHostageA", __mapHostageA);
			__mapHostageB = Helper.getValueArray(p_data, "mapHostageB", __mapHostageB);
			__mapHostageC = Helper.getValueArray(p_data, "mapHostageC", __mapHostageC);
			__cmdStore = Helper.getValueInteger(p_data, "cmdStore", __cmdStore);
			__demoSpeed = Helper.getValueInteger(p_data, "demoSpeed", __demoSpeed);
			__demoCmd = Helper.getValueArray(p_data, "demoCmd", __demoCmd);
			__scoreMax = Helper.getValueInteger(p_data, "scoreMax", __scoreMax);
		}
		
		public function GameConfig()
		{
			;
		}
	
	}
}