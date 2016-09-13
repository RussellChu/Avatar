package com.pj
{
	import com.pj.common.Helper;
	import com.pj.common.component.AbstractButton;
	import com.pj.common.component.BasicContainer;
	import com.pj.common.component.SimpleButton;
	import com.pj.common.component.SimpleToggleButton;
	import com.pj.common.component.Slider;
	import com.pj.common.component.ToggleButtonGroup;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class ProjectMacross extends BasicContainer
	{
		private var _map:ButtonHexagonGroup = null;
		private var _model:GameModel = null;
		private var _tgCommand:ToggleButtonGroup = null;
		private var _tgSide:ToggleButtonGroup = null;
		private var _slider:Slider = null;
		
		public function ProjectMacross(p_inst:Sprite = null)
		{
			super(null, p_inst);
		}
		
		override public function dispose():void
		{
			Helper.dispose(this._map);
			Helper.dispose(this._model);
			Helper.dispose(this._tgCommand);
			Helper.dispose(this._tgSide);
			Helper.dispose(this._slider);
			this._map = null;
			this._model = null;
			this._tgCommand = null;
			this._tgSide = null;
			this._slider = null;
			super.dispose();
		}
		
		override protected function init():void
		{
			super.init();
			
			var SIDE_LIST:Array = [ //
			{label: "Red", data: {side: MapData.SIDE_A}} //
			, {label: "Green", data: {side: MapData.SIDE_B}} //
			, {label: "Blue", data: {side: MapData.SIDE_C}} //
			];
			
			var COMMAND_LIST:Array = [ //
			{label: "Road", data: {command: MapData.COMMAND_ROAD}} //
			, {label: "RoadEx", data: {command: MapData.COMMAND_ROAD_EX}} //
			, {label: "Attack", data: {command: MapData.COMMAND_ATTACK}} //
			, {label: "(Test) Hostage", data: {command: MapData.COMMAND_TEST_HOSTAGE}} //
			, {label: "(Test) Obstacle", data: {command: MapData.COMMAND_TEST_OBSTACLE}} //
			];
			
			this._model = new GameModel();
			
			var totalWidth:int = (Config.MAP_RADIUS * 6 - 3) * Config.BTN_RADIUS;
			this._slider = new Slider(this, this.instance.stage.stageWidth - Config.CTRL_BTN_WIDTH, this.instance.stage.stageHeight, totalWidth, totalWidth);
			this._slider.instance.x = Config.CTRL_BTN_WIDTH;
			
			this._map = new ButtonHexagonGroup(this._slider, Config.BTN_RADIUS, Config.BTN_SIDE, Config.FONT_SIZE);
			this._map.createMap(this._model.getCellList());
			this._map.signal.add(this.onMapSignal);
			
			if (Config.TESTING_MODE)
			{
				var btnToggle:SimpleToggleButton = null;
				var item:Object = null;
				var i:int = 0;
				var posY:int = 0;
				
				this._tgSide = new ToggleButtonGroup();
				for (i = 0; i < SIDE_LIST.length; i++)
				{
					item = SIDE_LIST[i];
					btnToggle = new SimpleToggleButton(item.label, Config.CTRL_BTN_WIDTH / 3, Config.CTRL_BTN_HEIGHT, item.data);
					btnToggle.instance.x = Config.CTRL_BTN_WIDTH / 3 * i;
					btnToggle.instance.y = posY;
					this._tgSide.addButton(btnToggle);
					this.addChild(btnToggle);
				}
				posY += Config.CTRL_BTN_HEIGHT;
				
				this._tgCommand = new ToggleButtonGroup();
				for (i = 0; i < COMMAND_LIST.length; i++)
				{
					item = COMMAND_LIST[i];
					btnToggle = new SimpleToggleButton(item.label, Config.CTRL_BTN_WIDTH, Config.CTRL_BTN_HEIGHT, item.data);
					btnToggle.instance.x = 0;
					btnToggle.instance.y = posY;
					this._tgCommand.addButton(btnToggle);
					this.addChild(btnToggle);
					posY += Config.CTRL_BTN_HEIGHT;
				}
				
				var btn:SimpleButton = null;
				btn = new SimpleButton("Undo", Config.CTRL_BTN_WIDTH, Config.CTRL_BTN_HEIGHT);
				btn.instance.x = 0;
				btn.instance.y = posY;
				this.addChild(btn);
				posY += Config.CTRL_BTN_HEIGHT;
				
				btn = new SimpleButton("Capture", Config.CTRL_BTN_WIDTH, Config.CTRL_BTN_HEIGHT);
				btn.instance.x = 0;
				btn.instance.y = posY;
				btn.signal.add(function(p_result:Object):void
				{
					var action:String = p_result.action;
					if (action == AbstractButton.ACTION_CLICK)
					{
						_slider.saveCapture(Config.DEFAULT_PNG);
					}
				});
				this.addChild(btn);
				posY += Config.CTRL_BTN_HEIGHT;
			}
		}
		
		override public function reset():void
		{
			super.reset();
		}
		
		override public function resize(p_width:int, p_height:int):void
		{
			this._slider.resize(p_width - Config.CTRL_BTN_WIDTH, p_height);
		}
		
		private function onMapSignal(p_result:Object):void
		{
			var dataCell:MapCell = p_result as MapCell;
			
			if (Config.TESTING_MODE)
			{
				var dataCommand:Object = this._tgCommand.data;
				var dataSide:Object = this._tgSide.data;
				if (!dataCommand)
				{
					return;
				}
				var command:int = dataCommand.command;
				var side:int = 0;
				
				switch (command)
				{
				case MapData.COMMAND_TEST_HOSTAGE: 
				case MapData.COMMAND_TEST_OBSTACLE: 
					break;
				default: 
					if (!dataSide)
					{
						return;
					}
					side = dataSide.side;
				}
				
				var dataState:Object = this._model.command(dataCell.id, side, command);
				if (dataState)
				{
					this._map.setState(dataState.id, dataState.side, dataState.state);
				}
				
					//var x:int = dataCell.keyY;
					//var y:int = dataCell.keyZ;
					//var z:int = dataCell.keyX;
					//dataCell = this._model.getCellByKey(x, y, z);
					//dataState = this._model.command(dataCell.id, side, command);
					//if (dataState)
					//{
					//this._map.setState(dataState.id, dataState.side, dataState.state);
					//}
					//
					//x = dataCell.keyY;
					//y = dataCell.keyZ;
					//z = dataCell.keyX;
					//dataCell = this._model.getCellByKey(x, y, z);
					//dataState = this._model.command(dataCell.id, side, command);
					//if (dataState)
					//{
					//this._map.setState(dataState.id, dataState.side, dataState.state);
					//}
			}
			else
			{
				;
			}
		}
	
	}
}

import com.pj.common.JColor;
import com.pj.common.component.AbstractButton;
import com.pj.common.component.AbstractButtonFace;
import com.pj.common.component.BasicButton;
import com.pj.common.component.BasicContainer;
import com.pj.common.component.IContainer;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.TimerEvent;
import flash.text.TextFormat;
import flash.utils.Timer;

class Config
{
	public static const TESTING_MODE:Boolean = true;
	
	public static const BTN_RADIUS:int = 15; // real: 135, test: 15
	public static const BTN_SIDE:int = 1; // real: 6, test: 1
	public static const FONT_SIZE:int = 8; // real: 72, test: 8
	public static const CTRL_BTN_WIDTH:int = 120;
	public static const CTRL_BTN_HEIGHT:int = 25;
	public static const DEFAULT_PNG:String = "a.png";
	
	public static const CELL_BASE_A:Array = [0, 2, 3, 598, 625, 626];
	public static const CELL_BASE_B:Array = [247, 274, 275, 585, 612, 613];
	public static const CELL_BASE_C:Array = [234, 261, 262, 611, 638, 639];
	public static const CELL_OBSTACLE:Array = [//
	211, 212, 238, 239, 265, 266, 292, 293, 319, 320, 346, 347, 373, 374, 400, 401, 428//
	, 214, 215, 242, 243, 270, 271, 298, 299, 326, 327, 354, 355, 382, 383, 410, 411, 438//
	, 484, 485, 486, 487, 488, 489, 490, 491, 492, 512, 513, 514, 515, 516, 517, 518, 519//
	];
	
	// No.2
	public static const CELL_OBSTACLE_OUT:Array = [//
	11, 13, 24, 47, 77, 91, 92, 126, 143, 145//
	, 194, 199, 227, 231, 387, 421, 443, 473, 501, 502//
	, 619, 621, 666, 667, 683, 686, 697, 751, 752, 754//
	];
	// No.7
	//public static const CELL_OBSTACLE_OUT:Array = [//
	//23, 114, 119, 132, 142, 143, 145, 147, 152, 169//
	//, 173, 174, 182, 197, 198, 228, 332, 385, 446, 453//
	//, 549, 567, 649, 688, 739, 740, 742, 747, 749, 754//
	//];
	
	public static const CELL_HOSTAGE:Array = [//
	40, 66, 81, 96, 117, 127, 139, 144, 146, 148//
	, 170, 224, 257, 294, 307, 324, 366, 376, 378, 381//
	, 414, 434, 459, 499, 507, 551, 593, 617, 702, 710//
	, 716, 727, 748, 756//
	];
	
	public static const MAP_RADIUS:int = 10;
}

class MapData
{
	public static const SIDE_A:int = 1;
	public static const SIDE_B:int = 2;
	public static const SIDE_C:int = 3;
	
	public static const STATE_NONE:int = 0;
	public static const STATE_BASE:int = 1;
	public static const STATE_ROAD:int = 2;
	public static const STATE_ROAD_EX:int = 3;
	public static const STATE_OBSTACLE:int = 4;
	public static const STATE_HOSTAGE:int = 5;
	
	public static const COMMAND_NONE:int = 0;
	public static const COMMAND_ROAD:int = 1;
	public static const COMMAND_ROAD_EX:int = 2;
	public static const COMMAND_ATTACK:int = 3; // Replace enemy's cell
	public static const COMMAND_TEST_HOSTAGE:int = 4;
	public static const COMMAND_TEST_OBSTACLE:int = 5;
}

class MapCell
{
	public var id:int = 0;
	public var keyX:int = 0;
	public var keyY:int = 0;
	public var keyZ:int = 0;
	public var posX:int = 0;
	public var posY:int = 0;
	
	public var state:int = 0;
	public var side:int = 0;
	
	public function MapCell(p_id:int, p_keyX:int, p_keyY:int, p_keyZ:int, p_posX:int, p_posY:int):void
	{
		this.id = p_id;
		this.keyX = p_keyX;
		this.keyY = p_keyY;
		this.keyZ = p_keyZ;
		this.posX = p_posX;
		this.posY = p_posY;
	}
}

class MapCellCroup
{
	private var _list:Array = null;
	private var _map:Object = null;
	private var _mapId:Object = null;
	
	public function MapCellCroup()
	{
		this._list = [];
		this._map = {};
		this._mapId = {};
	}
	
	private function getKey(p_keyX:int, p_keyY:int, p_keyZ:int):String
	{
		return '' + p_keyX + ':' + p_keyY + ':' + p_keyZ;
	}
	
	public function addCell(p_id:int, p_keyX:int, p_keyY:int, p_keyZ:int, p_posX:int, p_posY:int):void
	{
		var key:String = this.getKey(p_keyX, p_keyY, p_keyZ);
		var cell:MapCell = new MapCell(p_id, p_keyX, p_keyY, p_keyZ, p_posX, p_posY);
		if (!this._map[key])
		{
			this._list.push(cell);
		}
		this._map[key] = cell;
		this._mapId[p_id] = cell;
	}
	
	public function getCellById(p_id:int):MapCell
	{
		if (!this._mapId[p_id])
		{
			return null;
		}
		return this._mapId[p_id] as MapCell;
	}
	
	public function getCellByKey(p_keyX:int, p_keyY:int, p_keyZ:int):MapCell
	{
		var key:String = this.getKey(p_keyX, p_keyY, p_keyZ);
		if (!this._map[key])
		{
			return null;
		}
		return this._map[key] as MapCell;
	}
	
	public function getList():Array
	{
		return this._list;
	}

}

class GameModel
{
	private var _map:MapCellCroup = null;
	
	public function GameModel():void
	{
		this._map = new MapCellCroup();
		var outStoneMax:int = 10;
		var outStoneIdList:Array = [];
		var outStoneIdMap:Object = {};
		
		var i:int = 0;
		var j:int = 0;
		var k:int = 0;
		
		var id:int = 0;
		for (j = -(Config.MAP_RADIUS - 1) * 2; j <= (Config.MAP_RADIUS - 1) * 2; j++)
		{
			for (i = -(Config.MAP_RADIUS - 1) * 2; i <= (Config.MAP_RADIUS - 1) * 2; i++)
			{
				k = i + j;
				if (k < -(Config.MAP_RADIUS - 1) * 2 || k > (Config.MAP_RADIUS - 1) * 2)
				{
					continue;
				}
				var max:int = 0;
				var mid:int = 0;
				var min:int = 0;
				if (i >= j && j >= k)
				{
					max = i;
					mid = j;
					min = k;
				}
				if (j >= k && k >= i)
				{
					max = j;
					mid = k;
					min = i;
				}
				if (k >= i && i >= j)
				{
					max = k;
					mid = i;
					min = j;
				}
				if (j >= i && i >= k)
				{
					max = j;
					mid = i;
					min = k;
				}
				if (i >= k && k >= j)
				{
					max = i;
					mid = k;
					min = j;
				}
				if (k >= j && j >= i)
				{
					max = k;
					mid = j;
					min = i;
				}
				if (max - min > (Config.MAP_RADIUS - 1) * 3)
				{
					continue;
				}
				if (max + mid > (Config.MAP_RADIUS - 1) * 3)
				{
					continue;
				}
				if (mid + min < -(Config.MAP_RADIUS - 1) * 3)
				{
					continue;
				}
				var x:int = i;
				var y:int = j;
				var z:int = -k;
				var startX:int = (Config.MAP_RADIUS - 1) * 2 + j;
				var startY:int = (Config.MAP_RADIUS - 1) * 3 + i * 2 + j;
				this._map.addCell(id, x, y, z, startX, startY);
				var key:String = "" + x + ":" + y + ":" + z;
				if (Config.CELL_BASE_A.indexOf(id) >= 0)
				{
					key = "";
					this.addBase(MapData.SIDE_A, x, y, z);
				}
				if (Config.CELL_BASE_B.indexOf(id) >= 0)
				{
					key = "";
					this.addBase(MapData.SIDE_B, x, y, z);
				}
				if (Config.CELL_BASE_C.indexOf(id) >= 0)
				{
					key = "";
					this.addBase(MapData.SIDE_C, x, y, z);
				}
				if (Config.CELL_OBSTACLE.indexOf(id) >= 0 || Config.CELL_OBSTACLE_OUT.indexOf(id) >= 0)
				{
					key = "";
					this.addObstacle(x, y, z);
				}
				if (Config.CELL_HOSTAGE.indexOf(id) >= 0)
				{
					key = "";
					this.addHostage(x, y, z);
				}
				if (Config.TESTING_MODE)
				{
					if (key != "")
					{
						if (outStoneMax > 0 && Math.random() * 21 < 1 && !outStoneIdMap[key])
						{
							outStoneMax--;
							outStoneIdMap["" + x + ":" + y + ":" + z] = true;
							outStoneIdMap["" + y + ":" + z + ":" + x] = true;
							outStoneIdMap["" + z + ":" + x + ":" + y] = true;
							outStoneIdList.push({x: x, y: y, z: z});
							outStoneIdList.push({x: y, y: z, z: x});
							outStoneIdList.push({x: z, y: x, z: y});
						}
					}
				}
				id++;
			}
		}
		if (Config.TESTING_MODE)
		{
			for (i = 0; i < outStoneIdList.length; i++)
			{
				//	this.addObstacle(outStoneIdList[i].x, outStoneIdList[i].y, outStoneIdList[i].z);
			}
		}
	}
	
	private function addBase(p_side:int, p_keyX:int, p_keyY:int, p_keyZ:int):Boolean
	{
		var cell:MapCell = this._map.getCellByKey(p_keyX, p_keyY, p_keyZ);
		if (!cell)
		{
			return false;
		}
		
		cell.side = p_side;
		cell.state = MapData.STATE_BASE;
		trace("addBase >> " + cell.side + ": " + cell.id + " (" + p_keyX + ", " + p_keyY + ", " + p_keyZ + ")");
		return true;
	}
	
	private function addObstacle(p_keyX:int, p_keyY:int, p_keyZ:int):Boolean
	{
		var cell:MapCell = this._map.getCellByKey(p_keyX, p_keyY, p_keyZ);
		if (!cell)
		{
			return false;
		}
		
		cell.side = 0;
		cell.state = MapData.STATE_OBSTACLE;
		trace("addObstacle >> " + cell.side + ": " + cell.id + " (" + p_keyX + ", " + p_keyY + ", " + p_keyZ + ")");
		return true;
	}
	
	private function addHostage(p_keyX:int, p_keyY:int, p_keyZ:int):Boolean
	{
		var cell:MapCell = this._map.getCellByKey(p_keyX, p_keyY, p_keyZ);
		if (!cell)
		{
			return false;
		}
		cell.side = 0;
		cell.state = MapData.STATE_HOSTAGE;
		trace("addHostage >> " + cell.side + ": " + cell.id + " (" + p_keyX + ", " + p_keyY + ", " + p_keyZ + ")");
		return true;
	}
	
	private function addRoad(p_side:int, p_keyX:int, p_keyY:int, p_keyZ:int):Boolean
	{
		var cell:MapCell = this._map.getCellByKey(p_keyX, p_keyY, p_keyZ);
		if (!cell)
		{
			return false;
		}
		cell.side = p_side;
		cell.state = MapData.STATE_ROAD;
		trace("addRoad >> " + cell.side + ": " + cell.id + " (" + p_keyX + ", " + p_keyY + ", " + p_keyZ + ")");
		return true;
	}
	
	private function addRoadEx(p_side:int, p_keyX:int, p_keyY:int, p_keyZ:int):Boolean
	{
		var cell:MapCell = this._map.getCellByKey(p_keyX, p_keyY, p_keyZ);
		if (!cell)
		{
			return false;
		}
		cell.side = p_side;
		cell.state = MapData.STATE_ROAD_EX;
		trace("addRoadEx >> " + cell.side + ": " + cell.id + " (" + p_keyX + ", " + p_keyY + ", " + p_keyZ + ")");
		return true;
	}
	
	private function clearCell(p_keyX:int, p_keyY:int, p_keyZ:int):Boolean
	{
		var cell:MapCell = this._map.getCellByKey(p_keyX, p_keyY, p_keyZ);
		if (!cell)
		{
			return false;
		}
		cell.side = 0;
		cell.state = MapData.STATE_NONE;
		trace("clearCell >> " + cell.side + ": " + cell.id + " (" + p_keyX + ", " + p_keyY + ", " + p_keyZ + ")");
		return true;
	}
	
	private function checkBase(p_id:int, p_side:int, p_isEx:Boolean):Boolean
	{
		var checkMap:Object = {};
		var checkList:Array = [];
		checkMap[p_id] = true;
		checkList.push({id: p_id, ex: p_isEx});
		
		var next1:Array = [//
		{x: -1, y: 0, z: 1}//
		, {x: -1, y: 1, z: 0}//
		, {x: 0, y: 1, z: -1}//
		, {x: 1, y: 0, z: -1}//
		, {x: 1, y: -1, z: 0}//
		, {x: 0, y: -1, z: 1}//
		];
		var next2:Array = [//
		{x: -2, y: 0, z: 2}//
		, {x: -2, y: 1, z: 1}//
		, {x: -2, y: 2, z: 0}//
		, {x: -1, y: 2, z: -1}//
		, {x: 0, y: 2, z: -2}//
		, {x: 1, y: 1, z: -2}//
		, {x: 2, y: 0, z: -2}//
		, {x: 2, y: -1, z: -1}//
		, {x: 2, y: -2, z: 0}//
		, {x: 1, y: -2, z: 1}//
		, {x: 0, y: -2, z: 2}//
		, {x: -1, y: -1, z: 2}//
		];
		
		while (checkList.length > 0)
		{
			var item:Object = checkList.pop();
			var currId:int = item.id;
			var currEx:Boolean = item.ex;
			var cell:MapCell = this._map.getCellById(currId);
			var nextCell:MapCell = null;
			var currX:int = cell.keyX;
			var currY:int = cell.keyY;
			var currZ:int = cell.keyZ;
			var nextX:int = 0;
			var nextY:int = 0;
			var nextZ:int = 0;
			var i:int = 0;
			for (i = 0; i < next1.length; i++)
			{
				nextX = currX + next1[i].x;
				nextY = currY + next1[i].y;
				nextZ = currZ + next1[i].z;
				nextCell = this._map.getCellByKey(nextX, nextY, nextZ);
				if (!nextCell)
				{
					continue;
				}
				if (nextCell.side != p_side)
				{
					continue;
				}
				if (checkMap[nextCell.id])
				{
					continue;
				}
				if (nextCell.state == MapData.STATE_BASE)
				{
					return true;
				}
				if (nextCell.state == MapData.STATE_ROAD || nextCell.state == MapData.STATE_ROAD_EX)
				{
					checkMap[nextCell.id] = true;
					checkList.push({id: nextCell.id, ex: (nextCell.state == MapData.STATE_ROAD_EX)});
				}
			}
			if (!currEx)
			{
				continue;
			}
			for (i = 0; i < next2.length; i++)
			{
				nextX = currX + next2[i].x;
				nextY = currY + next2[i].y;
				nextZ = currZ + next2[i].z;
				nextCell = this._map.getCellByKey(nextX, nextY, nextZ);
				if (!nextCell)
				{
					continue;
				}
				if (nextCell.side != p_side)
				{
					continue;
				}
				if (checkMap[nextCell.id])
				{
					continue;
				}
				if (nextCell.state == MapData.STATE_ROAD || nextCell.state == MapData.STATE_ROAD_EX)
				{
					checkMap[nextCell.id] = true;
					checkList.push({id: nextCell.id, ex: (nextCell.state == MapData.STATE_ROAD_EX)});
				}
			}
		}
		
		return false;
	}
	
	public function command(p_id:int, p_side:int, p_command:int):Object
	{
		var cell:MapCell = this._map.getCellById(p_id);
		if (!cell)
		{
			return null;
		}
		
		switch (p_command)
		{
		case MapData.COMMAND_ATTACK: 
		case MapData.COMMAND_ROAD: 
		case MapData.COMMAND_ROAD_EX: 
			if (p_side == 0)
			{
				return null;
			}
			if (!this.checkBase(p_id, p_side, p_command == MapData.COMMAND_ROAD_EX))
			{
				return null;
			}
			
			switch (p_command)
			{
			case MapData.COMMAND_ATTACK: 
				if (cell.side == 0 || cell.side == p_side)
				{
					return null;
				}
				if (cell.state != MapData.STATE_ROAD && cell.state != MapData.STATE_ROAD_EX)
				{
					return null;
				}
				this.addRoad(p_side, cell.keyX, cell.keyY, cell.keyZ);
				return {id: p_id, side: p_side, state: MapData.STATE_ROAD};
			case MapData.COMMAND_ROAD: 
				if (cell.state != MapData.STATE_NONE)
				{
					return null;
				}
				this.addRoad(p_side, cell.keyX, cell.keyY, cell.keyZ);
				return {id: p_id, side: p_side, state: MapData.STATE_ROAD};
			case MapData.COMMAND_ROAD_EX: 
				if (cell.state != MapData.STATE_NONE && cell.state != MapData.STATE_ROAD)
				{
					return null;
				}
				this.addRoadEx(p_side, cell.keyX, cell.keyY, cell.keyZ);
				return {id: p_id, side: p_side, state: MapData.STATE_ROAD_EX};
			default: 
				return null;
				;
			}
		case MapData.COMMAND_TEST_HOSTAGE: 
			if (Config.TESTING_MODE)
			{
				return null;
			}
			this.addHostage(cell.keyX, cell.keyY, cell.keyZ);
			return {id: p_id, side: p_side, state: MapData.STATE_HOSTAGE};
		case MapData.COMMAND_TEST_OBSTACLE: 
			if (Config.TESTING_MODE)
			{
				return null;
			}
			this.addObstacle(cell.keyX, cell.keyY, cell.keyZ);
			return {id: p_id, side: p_side, state: MapData.STATE_OBSTACLE};
		default: 
			return null;
			;
		}
	}
	
	public function getCellByKey(p_keyX:int, p_keyY:int, p_keyZ:int):MapCell
	{
		return this._map.getCellByKey(p_keyX, p_keyY, p_keyZ);
	}
	
	public function getCellList():Array
	{
		return this._map.getList();
	}

}

class ButtonHexagonFace extends AbstractButtonFace
{
	public static const FACE_BLANK:int = 0;
	public static const FACE_BASE_0:int = 1;
	public static const FACE_BASE_1:int = 2;
	public static const FACE_BASE_2:int = 3;
	public static const FACE_ROAD_0:int = 4;
	public static const FACE_ROAD_1:int = 5;
	public static const FACE_ROAD_2:int = 6;
	public static const FACE_ROAD_EX_0:int = 7;
	public static const FACE_ROAD_EX_1:int = 8;
	public static const FACE_ROAD_EX_2:int = 9;
	public static const FACE_HOSTAGE:int = 10;
	public static const FACE_OBSTACLE:int = 11;
	
	private var _imgBase0:Bitmap = null;
	private var _imgBase1:Bitmap = null;
	private var _imgBase2:Bitmap = null;
	private var _imgBlank:Bitmap = null;
	private var _imgRoad0:Bitmap = null;
	private var _imgRoad1:Bitmap = null;
	private var _imgRoad2:Bitmap = null;
	private var _imgHostage:Bitmap = null;
	private var _imgObstacle:Bitmap = null;
	
	private var _isFlash:Boolean = false;
	private var _timer:Timer = null;
	private var _timeVal:Number = 0;
	
	public function ButtonHexagonFace( //
	p_bmpBlank:BitmapData //
	, p_bmpBase0:BitmapData = null //
	, p_bmpBase1:BitmapData = null //
	, p_bmpBase2:BitmapData = null //
	, p_bmpRoad0:BitmapData = null //
	, p_bmpRoad1:BitmapData = null //
	, p_bmpRoad2:BitmapData = null //
	, p_bmpHostage:BitmapData = null //
	, p_bmpObstacle:BitmapData = null //
	):void
	{
		this._imgBase0 = new Bitmap(p_bmpBase0);
		this._imgBase1 = new Bitmap(p_bmpBase1);
		this._imgBase2 = new Bitmap(p_bmpBase2);
		this._imgBlank = new Bitmap(p_bmpBlank);
		this._imgRoad0 = new Bitmap(p_bmpRoad0);
		this._imgRoad1 = new Bitmap(p_bmpRoad1);
		this._imgRoad2 = new Bitmap(p_bmpRoad2);
		this._imgHostage = new Bitmap(p_bmpHostage);
		this._imgObstacle = new Bitmap(p_bmpObstacle);
		super();
	}
	
	override public function dispose():void
	{
		this._imgBase0 = null;
		this._imgBase1 = null;
		this._imgBase2 = null;
		this._imgBlank = null;
		this._imgRoad0 = null;
		this._imgRoad1 = null;
		this._imgRoad2 = null;
		this._imgHostage = null;
		this._imgObstacle = null;
		super.dispose();
	}
	
	override protected function init():void
	{
		super.init();
		this.container.addChild(this._imgBlank);
		if (this._imgBase0)
		{
			this.container.addChild(this._imgBase0);
		}
		if (this._imgBase1)
		{
			this.container.addChild(this._imgBase1);
		}
		if (this._imgBase2)
		{
			this.container.addChild(this._imgBase2);
		}
		if (this._imgRoad0)
		{
			this.container.addChild(this._imgRoad0);
		}
		if (this._imgRoad1)
		{
			this.container.addChild(this._imgRoad1);
		}
		if (this._imgRoad2)
		{
			this.container.addChild(this._imgRoad2);
		}
		if (this._imgHostage)
		{
			this.container.addChild(this._imgHostage);
		}
		if (this._imgObstacle)
		{
			this.container.addChild(this._imgObstacle);
		}
		
		this._timer = new Timer(20);
		this._timer.addEventListener(TimerEvent.TIMER, this.onTime);
	}
	
	override public function reset():void
	{
		super.reset();
		this._isFlash = false;
		this._timer.stop();
		this._timeVal = 0;
		this.setFace(FACE_BLANK);
	}
	
	private function onTime(p_evt:TimerEvent):void
	{
		if (this._isFlash)
		{
			this._timeVal += 0.02;
			if (this._timeVal > 1)
			{
				this._timeVal -= 1;
			}
			this.container.alpha = (Math.sin(Math.PI * 2 * this._timeVal) + 1) * 0.5;
		}
	}
	
	public function setFace(p_id:int):void
	{
		if (this._imgBase0)
		{
			this._imgBase0.visible = false;
		}
		if (this._imgBase1)
		{
			this._imgBase1.visible = false;
		}
		if (this._imgBase2)
		{
			this._imgBase2.visible = false;
		}
		if (this._imgRoad0)
		{
			this._imgRoad0.visible = false;
		}
		if (this._imgRoad1)
		{
			this._imgRoad1.visible = false;
		}
		if (this._imgRoad2)
		{
			this._imgRoad2.visible = false;
		}
		if (this._imgHostage)
		{
			this._imgHostage.visible = false;
		}
		if (this._imgObstacle)
		{
			this._imgObstacle.visible = false;
		}
		var isKeepFlash:Boolean = this._isFlash;
		this._isFlash = false;
		var isSet:Boolean = false;
		switch (p_id)
		{
		case FACE_BASE_0: 
			if (this._imgBase0)
			{
				this._imgBase0.visible = true;
				isSet = true;
			}
			break;
		case FACE_BASE_1: 
			if (this._imgBase1)
			{
				this._imgBase1.visible = true;
				isSet = true;
			}
			break;
		case FACE_BASE_2: 
			if (this._imgBase2)
			{
				this._imgBase2.visible = true;
				isSet = true;
			}
			break;
		case FACE_ROAD_0: 
			if (this._imgRoad0)
			{
				this._imgRoad0.visible = true;
				isSet = true;
			}
			break;
		case FACE_ROAD_1: 
			if (this._imgRoad1)
			{
				this._imgRoad1.visible = true;
				isSet = true;
			}
			break;
		case FACE_ROAD_2: 
			if (this._imgRoad2)
			{
				this._imgRoad2.visible = true;
				isSet = true;
			}
			break;
		case FACE_ROAD_EX_0: 
			if (this._imgRoad0)
			{
				this._imgRoad0.visible = true;
				isSet = true;
				this._isFlash = true;
			}
			break;
		case FACE_ROAD_EX_1: 
			if (this._imgRoad1)
			{
				this._imgRoad1.visible = true;
				isSet = true;
				this._isFlash = true;
			}
			break;
		case FACE_ROAD_EX_2: 
			if (this._imgRoad0)
			{
				this._imgRoad0.visible = true;
				isSet = true;
				this._isFlash = true;
			}
			break;
		case FACE_HOSTAGE: 
			if (this._imgHostage)
			{
				this._imgHostage.visible = true;
				isSet = true;
			}
			break;
		case FACE_OBSTACLE: 
			if (this._imgObstacle)
			{
				this._imgObstacle.visible = true;
				isSet = true;
			}
			break;
		case FACE_BLANK: 
		default: 
		}
		this._imgBlank.visible = !isSet;
		if (this._isFlash)
		{
			if (!isKeepFlash)
			{
				this._timeVal = 0;
				this._timer.start();
			}
		}
		else
		{
			this._timer.stop();
			this.container.alpha = 1;
		}
	}

}

class ButtonHexagon extends BasicButton
{
	private var _fontSize:int = 0;
	
	public function ButtonHexagon( //
	p_title:String //
	, p_width:int //
	, p_height:int //
	, p_fontSize:int //
	, p_faceDown:ButtonHexagonFace //
	, p_faceIdle:ButtonHexagonFace //
	, p_faceOver:ButtonHexagonFace //
	, p_data:Object = null //
	):void
	{
		this._fontSize = p_fontSize;
		super(p_title, p_width, p_height, p_faceDown, p_faceIdle, p_faceOver, p_data, ALIGN_BOTTON);
	}
	
	override protected function init():void
	{
		super.init();
		
		var format:TextFormat = new TextFormat();
		format.size = this._fontSize;
		this._txtTitle.defaultTextFormat = format;
	}
	
	public function setState(p_side:int, p_state:int):void
	{
		var face:ButtonHexagonFace = this.faceIdle as ButtonHexagonFace;
		switch (p_state)
		{
		case MapData.STATE_BASE: 
			switch (p_side)
			{
			case MapData.SIDE_A: 
				face.setFace(ButtonHexagonFace.FACE_BASE_0);
				break;
			case MapData.SIDE_B: 
				face.setFace(ButtonHexagonFace.FACE_BASE_1);
				break;
			case MapData.SIDE_C: 
				face.setFace(ButtonHexagonFace.FACE_BASE_2);
				break;
			default: 
				face.setFace(ButtonHexagonFace.FACE_BLANK);
			}
			break;
		case MapData.STATE_HOSTAGE: 
			face.setFace(ButtonHexagonFace.FACE_HOSTAGE);
			break;
		case MapData.STATE_OBSTACLE: 
			face.setFace(ButtonHexagonFace.FACE_OBSTACLE);
			break;
		case MapData.STATE_ROAD: 
			switch (p_side)
			{
			case MapData.SIDE_A: 
				face.setFace(ButtonHexagonFace.FACE_ROAD_0);
				break;
			case MapData.SIDE_B: 
				face.setFace(ButtonHexagonFace.FACE_ROAD_1);
				break;
			case MapData.SIDE_C: 
				face.setFace(ButtonHexagonFace.FACE_ROAD_2);
				break;
			default: 
				face.setFace(ButtonHexagonFace.FACE_BLANK);
			}
			break;
		case MapData.STATE_ROAD_EX: 
			switch (p_side)
			{
			case MapData.SIDE_A: 
				face.setFace(ButtonHexagonFace.FACE_ROAD_EX_0);
				break;
			case MapData.SIDE_B: 
				face.setFace(ButtonHexagonFace.FACE_ROAD_EX_1);
				break;
			case MapData.SIDE_C: 
				face.setFace(ButtonHexagonFace.FACE_ROAD_EX_2);
				break;
			default: 
				face.setFace(ButtonHexagonFace.FACE_BLANK);
			}
			break;
		default: 
			face.setFace(ButtonHexagonFace.FACE_BLANK);
		}
	}

}

class ButtonHexagonGroup extends BasicContainer
{
	private var _mapColor:Object = null;
	
	private var _valBtnW:int = 0;
	private var _valBtnH:int = 0;
	private var _valFontSize:int = 0;
	private var _valSide:Number = 0;
	
	private var _bmpDown:BitmapData = null;
	private var _bmpIdle:BitmapData = null;
	private var _bmpOver:BitmapData = null;
	private var _bmpIdleBase0:BitmapData = null;
	private var _bmpIdleBase1:BitmapData = null;
	private var _bmpIdleBase2:BitmapData = null;
	private var _bmpIdleRoad0:BitmapData = null;
	private var _bmpIdleRoad1:BitmapData = null;
	private var _bmpIdleRoad2:BitmapData = null;
	private var _bmpIdleHostage:BitmapData = null;
	private var _bmpIdleObstacle:BitmapData = null;
	
	private var _mapBtn:Object = null;
	
	public function ButtonHexagonGroup(p_parent:IContainer, p_valBtnRadius:Number, p_valSide:Number, p_valFontSize:int):void
	{
		this._valBtnW = p_valBtnRadius * 2 + 0.5;
		this._valBtnH = p_valBtnRadius * 1.732 + 0.5;
		this._valFontSize = p_valFontSize;
		this._valSide = p_valSide;
		super(p_parent);
	}
	
	public override function dispose():void
	{
		if (this._bmpDown)
		{
			this._bmpDown.dispose();
			this._bmpDown = null;
		}
		if (this._bmpIdle)
		{
			this._bmpIdle.dispose();
			this._bmpIdle = null;
		}
		if (this._bmpOver)
		{
			this._bmpOver.dispose();
			this._bmpOver = null;
		}
		super.dispose();
	}
	
	protected override function init():void
	{
		super.init();
		
		var colorDown:uint = new JColor(0, 1, 1, 1).value;
		var colorIdle:uint = new JColor(0, 0, 0, 0).value;
		var colorOver:uint = new JColor(1, 1, 0, 1).value;
		var colorBase0:uint = new JColor(1, 0.411, 0.411, 0.5).value;
		var colorBase1:uint = new JColor(0, 1, 0, 0.5).value;
		var colorBase2:uint = new JColor(0.534, 0.534, 1, 0.5).value;
		var colorRoad0:uint = new JColor(1, 0, 0, 1).value;
		var colorRoad1:uint = new JColor(0, 0.509, 0, 1).value;
		var colorRoad2:uint = new JColor(0.209, 0.209, 1, 1).value;
		var colorHostage:uint = new JColor(0.767, 0.473, 0.7055, 0.5).value;
		var colorObstacle:uint = new JColor(0.286, 0.0485, 0, 0.5).value;
		
		this._bmpDown = new BitmapData(this._valBtnW, this._valBtnH, true, 0);
		this._bmpIdle = new BitmapData(this._valBtnW, this._valBtnH, true, 0);
		this._bmpOver = new BitmapData(this._valBtnW, this._valBtnH, true, 0);
		this._bmpIdleBase0 = new BitmapData(this._valBtnW, this._valBtnH, true, 0);
		this._bmpIdleBase1 = new BitmapData(this._valBtnW, this._valBtnH, true, 0);
		this._bmpIdleBase2 = new BitmapData(this._valBtnW, this._valBtnH, true, 0);
		this._bmpIdleRoad0 = new BitmapData(this._valBtnW, this._valBtnH, true, 0);
		this._bmpIdleRoad1 = new BitmapData(this._valBtnW, this._valBtnH, true, 0);
		this._bmpIdleRoad2 = new BitmapData(this._valBtnW, this._valBtnH, true, 0);
		this._bmpIdleHostage = new BitmapData(this._valBtnW, this._valBtnH, true, 0);
		this._bmpIdleObstacle = new BitmapData(this._valBtnW, this._valBtnH, true, 0);
		this._bmpDown.lock();
		this._bmpIdle.lock();
		this._bmpOver.lock();
		this._bmpIdleBase0.lock();
		this._bmpIdleBase1.lock();
		this._bmpIdleBase2.lock();
		this._bmpIdleRoad0.lock();
		this._bmpIdleRoad1.lock();
		this._bmpIdleRoad2.lock();
		this._bmpIdleHostage.lock();
		this._bmpIdleObstacle.lock();
		
		for (var i:int = 0; i < this._valBtnW; i++)
		{
			for (var j:int = 0; j < this._valBtnH; j++)
			{
				var a:Number = this._valBtnW * this._valSide * 4;
				var b0:Boolean = (4 * this._valBtnH * i + 2 * this._valBtnW * j - this._valBtnW * this._valBtnH > a);
				var b1:Boolean = (-4 * this._valBtnH * i + 2 * this._valBtnW * j - this._valBtnW * this._valBtnH < -a);
				var b2:Boolean = (4 * this._valBtnH * i + 2 * this._valBtnW * j - 5 * this._valBtnW * this._valBtnH < -a);
				var b3:Boolean = (-4 * this._valBtnH * i + 2 * this._valBtnW * j + 3 * this._valBtnW * this._valBtnH > a);
				var b4:Boolean = j >= this._valSide && j < this._valBtnH - this._valSide;
				var b5:Boolean = (4 * this._valBtnH * i + 2 * this._valBtnW * j - this._valBtnW * this._valBtnH >= 0);
				var b6:Boolean = (-4 * this._valBtnH * i + 2 * this._valBtnW * j - this._valBtnW * this._valBtnH <= 0);
				var b7:Boolean = (4 * this._valBtnH * i + 2 * this._valBtnW * j - 5 * this._valBtnW * this._valBtnH <= 0);
				var b8:Boolean = (-4 * this._valBtnH * i + 2 * this._valBtnW * j + 3 * this._valBtnW * this._valBtnH >= 0);
				var b9:Boolean = (Math.abs(i * 2 - this._valBtnW) * 4 < this._valBtnW) && Math.abs(j * 2 - this._valBtnH) * 4 < this._valBtnW;
				
				a = this._valBtnW * 0.08;
				var s0:int = (Math.cos(Math.PI * (0.4 * 0 - 0.5)) * (i - this._valBtnW * 0.5) + Math.sin(Math.PI * (0.4 * 0 - 0.5)) * (j - this._valBtnH * 0.5) < a) ? 1 : 0;
				var s1:int = (Math.cos(Math.PI * (0.4 * 1 - 0.5)) * (i - this._valBtnW * 0.5) + Math.sin(Math.PI * (0.4 * 1 - 0.5)) * (j - this._valBtnH * 0.5) < a) ? 1 : 0;
				var s2:int = (Math.cos(Math.PI * (0.4 * 2 - 0.5)) * (i - this._valBtnW * 0.5) + Math.sin(Math.PI * (0.4 * 2 - 0.5)) * (j - this._valBtnH * 0.5) < a) ? 1 : 0;
				var s3:int = (Math.cos(Math.PI * (0.4 * 3 - 0.5)) * (i - this._valBtnW * 0.5) + Math.sin(Math.PI * (0.4 * 3 - 0.5)) * (j - this._valBtnH * 0.5) < a) ? 1 : 0;
				var s4:int = (Math.cos(Math.PI * (0.4 * 4 - 0.5)) * (i - this._valBtnW * 0.5) + Math.sin(Math.PI * (0.4 * 4 - 0.5)) * (j - this._valBtnH * 0.5) < a) ? 1 : 0;
				
				if (b0 && b1 && b2 && b3 && b4)
				{
					this._bmpDown.setPixel32(i, j, colorDown);
					this._bmpIdle.setPixel32(i, j, colorIdle);
					this._bmpOver.setPixel32(i, j, colorOver);
					this._bmpIdleBase0.setPixel32(i, j, colorBase0);
					this._bmpIdleBase1.setPixel32(i, j, colorBase1);
					this._bmpIdleBase2.setPixel32(i, j, colorBase2);
					this._bmpIdleRoad0.setPixel32(i, j, colorRoad0);
					this._bmpIdleRoad1.setPixel32(i, j, colorRoad1);
					this._bmpIdleRoad2.setPixel32(i, j, colorRoad2);
					if (s0 + s1 + s2 + s3 + s4 >= 4)
					{
						this._bmpIdleHostage.setPixel32(i, j, colorHostage);
					}
					this._bmpIdleObstacle.setPixel32(i, j, colorObstacle);
				}
				else if (b5 && b6 && b7 && b8)
				{
					this._bmpDown.setPixel32(i, j, 0xff000000);
					this._bmpIdle.setPixel32(i, j, 0xff000000);
					this._bmpOver.setPixel32(i, j, 0xff000000);
					this._bmpIdleBase0.setPixel32(i, j, 0xff000000);
					this._bmpIdleBase1.setPixel32(i, j, 0xff000000);
					this._bmpIdleBase2.setPixel32(i, j, 0xff000000);
					this._bmpIdleRoad0.setPixel32(i, j, 0xff000000);
					this._bmpIdleRoad1.setPixel32(i, j, 0xff000000);
					this._bmpIdleRoad2.setPixel32(i, j, 0xff000000);
					this._bmpIdleHostage.setPixel32(i, j, 0xff000000);
					this._bmpIdleObstacle.setPixel32(i, j, 0xff000000);
				}
			}
		}
		this._bmpDown.unlock();
		this._bmpIdle.unlock();
		this._bmpOver.unlock();
		this._bmpIdleBase0.unlock();
		this._bmpIdleBase1.unlock();
		this._bmpIdleBase2.unlock();
		this._bmpIdleRoad0.unlock();
		this._bmpIdleRoad1.unlock();
		this._bmpIdleRoad2.unlock();
		this._bmpIdleHostage.unlock();
		this._bmpIdleObstacle.unlock();
	}
	
	public override function reset():void
	{
		super.reset();
	}
	
	public function createMap(p_list:Array):void
	{
		this._mapBtn = {};
		
		for (var i:int = 0; i < p_list.length; i++)
		{
			var data:MapCell = p_list[i] as MapCell;
			var faceDown:ButtonHexagonFace = new ButtonHexagonFace(this._bmpDown);
			var faceIdle:ButtonHexagonFace = new ButtonHexagonFace( //
			this._bmpIdle, this._bmpIdleBase0, this._bmpIdleBase1, this._bmpIdleBase2, this._bmpIdleRoad0, this._bmpIdleRoad1, this._bmpIdleRoad2, this._bmpIdleHostage, this._bmpIdleObstacle);
			var faceOver:ButtonHexagonFace = new ButtonHexagonFace(this._bmpOver);
			var btn:ButtonHexagon = new ButtonHexagon( //
			"" + data.id //
			// "" + data.keyX + ":" + data.keyY + ":" + data.keyZ //
			, this._valBtnW //
			, this._valBtnH //
			, this._valFontSize //
			, faceDown //
			, faceIdle //
			, faceOver //
			, data //
			);
			this._mapBtn[data.id] = btn;
			btn.instance.x = data.posX * int(this._valBtnW * 0.75);
			btn.instance.y = data.posY * int(this._valBtnH * 0.5);
			btn.signal.add(this.onSignal);
			btn.setState(data.side, data.state);
			this.addChild(btn);
		}
	}
	
	public function setState(p_id:int, p_side:int, p_state:int):void
	{
		var btn:ButtonHexagon = this._mapBtn[p_id] as ButtonHexagon;
		if (!btn)
		{
			return;
		}
		btn.setState(p_side, p_state);
	}
	
	private function onSignal(p_result:Object):void
	{
		var action:String = p_result.action;
		if (action == AbstractButton.ACTION_CLICK)
		{
			this.signal.dispatch(p_result.data);
		}
	}

}