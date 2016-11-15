package com.pj.macross
{
	import com.pj.common.Helper;
	import com.pj.common.JTimer;
	import com.pj.macross.GameConfig;
	import com.pj.macross.GameData;
	import com.pj.macross.structure.MapCell;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class GameModel
	{
		static public const EVENT_CELL_UPDATE:String = "GameModel.EVENT_CELL_UPDATE";
		static public const EVENT_CMD_UPDATE:String = "GameModel.EVENT_CMD_UPDATE";
		static public const EVENT_CREATE_RESULT:String = "GameModel.EVENT_CREATE_RESULT";
		static public const EVENT_LOAD_COMPLETE:String = "GameModel.EVENT_LOAD_COMPLETE";
		static public const EVENT_PLAY_STATE:String = "GameModel.EVENT_PLAY_STATE";
		static public const EVENT_SCORE_UPDATE:String = "GameModel.EVENT_SCORE_UPDATE";
		
		static private const CHECK_BASE_LIST:Array = [//
		{x: -1, y: 0, z: 1}//
		, {x: -1, y: 1, z: 0}//
		, {x: 0, y: 1, z: -1}//
		, {x: 1, y: 0, z: -1}//
		, {x: 1, y: -1, z: 0}//
		, {x: 0, y: -1, z: 1}//
		];
		
		static private const CHECK_BASE_EX_LIST:Array = [//
		{x: -1, y: 0, z: 1}//
		, {x: -1, y: 1, z: 0}//
		, {x: 0, y: 1, z: -1}//
		, {x: 1, y: 0, z: -1}//
		, {x: 1, y: -1, z: 0}//
		, {x: 0, y: -1, z: 1}//
		, {x: -2, y: 0, z: 2}//
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
		
		private var _aiCheckList:Array = null;
		
		private var _map:MapCellCroup = null;
		private var _record:Array = null;
		private var _save:Object = null;
		private var _so:SharedObject = null;
		private var _score:Object = null;
		
		private var _createResult:Object = null;
		
		private var _aiA:SideAI = null;
		private var _aiB:SideAI = null;
		private var _aiC:SideAI = null;
		
		private var _timer:JTimer = null;
		private var _autoDelta:Number = 0;
		private var _autoState:int = 0;
		private var _playMode:int = 0;
		private var _waitPlayer:Boolean = false;
		
		public function GameModel()
		{
			this._map = new MapCellCroup();
			this._aiA = new SideAI(GameData.SIDE_A, this);
			this._aiB = new SideAI(GameData.SIDE_B, this);
			this._aiC = new SideAI(GameData.SIDE_C, this);
			
			var id:int = 0;
			var x:int = 0;
			var y:int = 0;
			var z:int = 0;
			for (var j:int = -(GameConfig.getMapRadius() - 1) * 2; j <= (GameConfig.getMapRadius() - 1) * 2; j++)
			{
				for (var i:int = -(GameConfig.getMapRadius() - 1) * 2; i <= (GameConfig.getMapRadius() - 1) * 2; i++)
				{
					var k:int = i + j;
					if (k < -(GameConfig.getMapRadius() - 1) * 2 || k > (GameConfig.getMapRadius() - 1) * 2)
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
					if (max - min > (GameConfig.getMapRadius() - 1) * 3)
					{
						continue;
					}
					if (max + mid > (GameConfig.getMapRadius() - 1) * 3)
					{
						continue;
					}
					if (mid + min < -(GameConfig.getMapRadius() - 1) * 3)
					{
						continue;
					}
					x = i;
					y = j;
					z = -k;
					var startX:int = (GameConfig.getMapRadius() - 1) * 2 + j;
					var startY:int = (GameConfig.getMapRadius() - 1) * 3 + i * 2 + j;
					this._map.addCell(id, x, y, z, startX, startY);
					
					id++;
				}
			}
			
			this.loadSave();
			
			if (this._record.length > 0)
			{
				for (var m:int = 0; m < this._record.length; m++)
				{
					var item:Array = this._record[m];
					var state:int = item[0];
					var side:int = item[1];
					x = item[2];
					y = item[3];
					z = item[4];
					var score:int = item[7];
					this.setScore(side, score);
					switch (state)
					{
					case GameData.STATE_BASE: 
						this.addBase(side, x, y, z);
						break;
					case GameData.STATE_ROAD: 
						this.addRoad(side, x, y, z);
						break;
					case GameData.STATE_ROAD_EX: 
						this.addRoadEx(side, x, y, z);
						break;
					case GameData.STATE_OBSTACLE: 
						this.addObstacle(x, y, z);
						break;
					case GameData.STATE_HOSTAGE: 
						this.addHostage(side, x, y, z);
						break;
					}
				}
			}
			else
			{
				this.buildMap();
			}
		}
		
		private function buildMap():void
		{
			this._record = [];
			this._save.list = this._record;
			this._map.clear();
			
			this.setScore(GameData.SIDE_A, 0);
			this.setScore(GameData.SIDE_B, 0);
			this.setScore(GameData.SIDE_C, 0);
			
			this._createResult = {obstage: [], hostageA: [], hostageB: [], hostageC: [], isReady: false};
			var mapInfo:Object = {};
			var getMapInfo:Function = function(p_x:int, p_y:int, p_z:int):Object
			{
				var cellInfo:Object = mapInfo["" + p_x + ":" + p_y + ":" + p_z];
				if (!cellInfo)
				{
					cellInfo = {isObstacle: 0, hostageSide: 0};
					mapInfo["" + p_x + ":" + p_y + ":" + p_z] = cellInfo;
				}
				return cellInfo;
			};
			var setMapInfoHostage:Function = function(p_x:int, p_y:int, p_z:int, p_side:int):void
			{
				var cellInfo:Object = getMapInfo(p_x, p_y, p_z);
				cellInfo.hostageSide = p_side;
			};
			var setMapInfoObstacle:Function = function(p_x:int, p_y:int, p_z:int, p_value:int):void
			{
				var cellInfo:Object = getMapInfo(p_x, p_y, p_z);
				cellInfo.isObstacle = p_value;
			};
			
			var obstacleRemain:int = 10;
			var hostageRemain:int = 20;
			var list:Array = this._map.getList();
			for (var i:int = 0; i < list.length; i++)
			{
				var cell:MapCell = list[i] as MapCell;
				var x:int = cell.keyX;
				var y:int = cell.keyY;
				var z:int = cell.keyZ;
				var id:int = cell.id;
				var key:String = "" + x + ":" + y + ":" + z;
				if (GameConfig.getMapBaseA().indexOf(id) >= 0)
				{
					key = "";
					this.addBase(GameData.SIDE_A, x, y, z);
					this.addRecord(GameData.STATE_BASE, GameData.SIDE_A, x, y, z, 0, 0, 0, 0);
				}
				else if (GameConfig.getMapBaseB().indexOf(id) >= 0)
				{
					key = "";
					this.addBase(GameData.SIDE_B, x, y, z);
					this.addRecord(GameData.STATE_BASE, GameData.SIDE_B, x, y, z, 0, 0, 0, 0);
				}
				else if (GameConfig.getMapBaseC().indexOf(id) >= 0)
				{
					key = "";
					this.addBase(GameData.SIDE_C, x, y, z);
					this.addRecord(GameData.STATE_BASE, GameData.SIDE_C, x, y, z, 0, 0, 0, 0);
				}
				else if (GameConfig.getMapObstacle().indexOf(id) >= 0)
				{
					key = "";
					this.addObstacle(x, y, z);
					this.addRecord(GameData.STATE_OBSTACLE, 0, x, y, z, 0, 0, 0, 0);
				}
				else
				{
					if (!GameConfig.getMapRandom())
					{
						if (GameConfig.getMapHostageA().indexOf(id) >= 0)
						{
							this.addHostage(GameData.SIDE_A, x, y, z);
							this.addRecord(GameData.STATE_HOSTAGE, GameData.SIDE_A, x, y, z, 0, 0, 0, 0);
						}
						else if (GameConfig.getMapHostageB().indexOf(id) >= 0)
						{
							this.addHostage(GameData.SIDE_B, x, y, z);
							this.addRecord(GameData.STATE_HOSTAGE, GameData.SIDE_B, x, y, z, 0, 0, 0, 0);
						}
						else if (GameConfig.getMapHostageC().indexOf(id) >= 0)
						{
							this.addHostage(GameData.SIDE_C, x, y, z);
							this.addRecord(GameData.STATE_HOSTAGE, GameData.SIDE_C, x, y, z, 0, 0, 0, 0);
						}
						else if (GameConfig.getMapObstacleOut().indexOf(id) >= 0)
						{
							this.addObstacle(x, y, z);
							this.addRecord(GameData.STATE_OBSTACLE, 0, x, y, z, 0, 0, 0, 0);
						}
					}
					else
					{
						// build rand map
						var cellInfo:Object = getMapInfo(x, y, z);
						var isObstacle:int = cellInfo.isObstacle;
						var hostageSide:int = cellInfo.hostageSide;
						if (isObstacle == 0 && hostageSide == 0)
						{
							if (Math.random() <= 10 / 100 && obstacleRemain > 0 && GameConfig.getMapObstacleClear().indexOf(id) < 0)
							{
								obstacleRemain--;
								setMapInfoObstacle(x, y, z, 1);
								setMapInfoObstacle(y, z, x, 1);
								setMapInfoObstacle(z, x, y, 1);
							}
							else if ((Math.random() <= 20 / 100 && hostageRemain > 0 && GameConfig.getMapHostageClear().indexOf(id) < 0) || GameConfig.getMapHostageCenter().indexOf(id) >= 0)
							{
								hostageRemain--;
								var select:Array = Helper.selectFrom([//
								[GameData.SIDE_A, GameData.SIDE_B, GameData.SIDE_C]//
								, [GameData.SIDE_B, GameData.SIDE_C, GameData.SIDE_A]//
								, [GameData.SIDE_C, GameData.SIDE_A, GameData.SIDE_B]//
								]) as Array;
								setMapInfoHostage(x, y, z, select[0]);
								setMapInfoHostage(y, z, x, select[1]);
								setMapInfoHostage(z, x, y, select[2]);
								
								for (var m:int = 0; m < CHECK_BASE_LIST.length; m++)
								{
									var move:Object = CHECK_BASE_LIST[m];
									var nextX:int = x + move.x;
									var nextY:int = y + move.y;
									var nextZ:int = z + move.z;
									setMapInfoHostage(nextX, nextY, nextZ, -1);
									nextX = y + move.x;
									nextY = z + move.y;
									nextZ = x + move.z;
									setMapInfoHostage(nextX, nextY, nextZ, -1);
									nextX = z + move.x;
									nextY = x + move.y;
									nextZ = y + move.z;
									setMapInfoHostage(nextX, nextY, nextZ, -1);
								}
							}
							else
							{
								setMapInfoHostage(x, y, z, -1);
								setMapInfoHostage(y, z, x, -1);
								setMapInfoHostage(z, x, y, -1);
								setMapInfoObstacle(x, y, z, -1);
								setMapInfoObstacle(y, z, x, -1);
								setMapInfoObstacle(z, x, y, -1);
							}
						}
						
						cellInfo = getMapInfo(x, y, z);
						isObstacle = cellInfo.isObstacle;
						hostageSide = cellInfo.hostageSide;
						if (isObstacle > 0)
						{
							this._createResult.obstage.push(id);
							this.addObstacle(x, y, z);
							this.addRecord(GameData.STATE_OBSTACLE, 0, x, y, z, 0, 0, 0, 0);
						}
						else if (hostageSide > 0)
						{
							if (hostageSide == GameData.SIDE_A)
							{
								this._createResult.hostageA.push(id);
							}
							if (hostageSide == GameData.SIDE_B)
							{
								this._createResult.hostageB.push(id);
							}
							if (hostageSide == GameData.SIDE_C)
							{
								this._createResult.hostageC.push(id);
							}
							this.addHostage(hostageSide, x, y, z);
							this.addRecord(GameData.STATE_HOSTAGE, hostageSide, x, y, z, 0, 0, 0, 0);
						}
						else
						{
							this.clearCell(x, y, z);
						}
					}
				}
			}
		}
		
		private function getScore(p_side:int):int
		{
			if (!this._score)
			{
				this._score = {};
			}
			if (!this._score[p_side])
			{
				this._score[p_side] = 0;
			}
			return this._score[p_side];
		}
		
		private function setScore(p_side:int, p_score:int):void
		{
			this.getScore(p_side);
			this._score[p_side] = p_score;
		}
		
		private function loadSave():void
		{
			this._so = SharedObject.getLocal("macross");
			this._so.addEventListener(NetStatusEvent.NET_STATUS, this.onFlushStatus);
			if (!this._so.data.init)
			{
				this._so.data.init = true;
				this._so.data.data = {version: 0, list: []};
			}
			this._save = this._so.data.data;
			var version:int = this._save.version;
			if (version != GameConfig.getSaveVer())
			{
				this._save.version = GameConfig.getSaveVer();
				this._save.list = [];
			}
			this._record = this._save.list;
		}
		
		private function addRecord(p_state:int, p_side:int, p_x:int, p_y:int, p_z:int, p_preState:int, p_preSide:int, p_score:int, p_preScore:int):void
		{
			if (this._record.length >= 10000)
			{
				this._record.shift();
			}
			var item:Array = [];
			item.push(p_state);
			item.push(p_side);
			item.push(p_x);
			item.push(p_y);
			item.push(p_z);
			item.push(p_preState);
			item.push(p_preSide);
			item.push(p_score);
			item.push(p_preScore);
			this._record.push(item);
		}
		
		public function save():void
		{
			var flushStatus:String = null;
			try
			{
				flushStatus = this._so.flush(16384);
			}
			catch (error:Error)
			{
				trace("Error...Could not write SharedObject to disk");
			}
			if (flushStatus != null)
			{
				switch (flushStatus)
				{
				case SharedObjectFlushStatus.PENDING: 
					trace("Requesting permission to save object...");
					break;
				case SharedObjectFlushStatus.FLUSHED: 
					trace("Value flushed to disk.");
					break;
				}
			}
		}
		
		private function onFlushStatus(p_evt:Event):void
		{
			trace("onFlushStatus >> " + p_evt.toString());
		}
		
		private function addBase(p_side:int, p_keyX:int, p_keyY:int, p_keyZ:int):Boolean
		{
			var cell:MapCell = this._map.getCellByKey(p_keyX, p_keyY, p_keyZ);
			if (!cell)
			{
				return false;
			}
			
			cell.side = p_side;
			cell.state = GameData.STATE_BASE;
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
			cell.state = GameData.STATE_OBSTACLE;
			return true;
		}
		
		private function addHostage(p_side:int, p_keyX:int, p_keyY:int, p_keyZ:int):Boolean
		{
			var cell:MapCell = this._map.getCellByKey(p_keyX, p_keyY, p_keyZ);
			if (!cell)
			{
				return false;
			}
			cell.side = p_side;
			cell.state = GameData.STATE_HOSTAGE;
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
			cell.state = GameData.STATE_ROAD;
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
			cell.state = GameData.STATE_ROAD_EX;
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
			cell.state = GameData.STATE_NONE;
			return true;
		}
		
		private function checkBase(p_id:int, p_side:int, p_isEx:Boolean):Boolean
		{
			var checkMap:Object = {};
			var checkList:Array = [];
			checkMap[p_id] = true;
			checkList.push({id: p_id, ex: p_isEx});
			
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
				
				var checkNearList:Array = CHECK_BASE_LIST;
				if (currEx)
				{
					checkNearList = CHECK_BASE_EX_LIST;
				}
				
				for (var i:int = 0; i < checkNearList.length; i++)
				{
					nextX = currX + checkNearList[i].x;
					nextY = currY + checkNearList[i].y;
					nextZ = currZ + checkNearList[i].z;
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
					if (nextCell.state == GameData.STATE_BASE)
					{
						return true;
					}
					if (nextCell.state == GameData.STATE_ROAD || nextCell.state == GameData.STATE_ROAD_EX)
					{
						checkMap[nextCell.id] = true;
						checkList.push({id: nextCell.id, ex: (nextCell.state == GameData.STATE_ROAD_EX)});
					}
				}
			}
			
			return false;
		}
		
		public function command(p_id:int, p_side:int, p_command:int):Boolean
		{
			if (this._playMode == 1)
			{
				if (p_side == GameData.SIDE_A)
				{
					if (!this._waitPlayer)
					{
						return false;
					}
					
					var cmdMap:Object = this._aiA.cmd;
					switch (p_command)
					{
					case GameData.COMMAND_ATTACK: 
						if (cmdMap.atk <= 0)
						{
							return false;
						}
						break;
					case GameData.COMMAND_ROAD: 
						if (cmdMap.mov <= 0)
						{
							return false;
						}
						break;
					case GameData.COMMAND_ROAD_EX: 
						if (cmdMap.jmp <= 0)
						{
							return false;
						}
						break;
					default: 
						;
					}
				}
			}
			
			var cell:MapCell = this._map.getCellById(p_id);
			if (!cell)
			{
				return false;
			}
			if (p_side == 0)
			{
				return false;
			}
			if (!this.checkBase(p_id, p_side, p_command == GameData.COMMAND_ROAD_EX))
			{
				return false;
			}
			
			var preState:int = cell.state;
			var preSide:int = cell.side;
			var score:int = this.getScore(p_side);
			var preScore:int = this.getScore(p_side);
			
			switch (p_command)
			{
			case GameData.COMMAND_ATTACK: 
				if (cell.side == 0 || cell.side == p_side)
				{
					return false;
				}
				if (cell.state != GameData.STATE_ROAD && cell.state != GameData.STATE_ROAD_EX)
				{
					return false;
				}
				this.addRoad(p_side, cell.keyX, cell.keyY, cell.keyZ);
				break;
			case GameData.COMMAND_ROAD: 
				if (cell.state != GameData.STATE_NONE && cell.state != GameData.STATE_HOSTAGE)
				{
					return false;
				}
				if (cell.state == GameData.STATE_HOSTAGE && cell.side != p_side)
				{
					return false;
				}
				if (cell.state == GameData.STATE_HOSTAGE)
				{
					score++;
					this.setScore(p_side, score);
				}
				this.addRoad(p_side, cell.keyX, cell.keyY, cell.keyZ);
				break;
			case GameData.COMMAND_ROAD_EX: 
				if (cell.state != GameData.STATE_NONE && cell.state != GameData.STATE_HOSTAGE)
				{
					return false;
				}
				if (cell.state == GameData.STATE_HOSTAGE && cell.side != p_side)
				{
					return false;
				}
				if (cell.state == GameData.STATE_HOSTAGE)
				{
					score++;
					this.setScore(p_side, score);
				}
				this.addRoadEx(p_side, cell.keyX, cell.keyY, cell.keyZ);
				break;
			default: 
				return false;
			}
			
			this.addRecord(cell.state, cell.side, cell.keyX, cell.keyY, cell.keyZ, preState, preSide, score, preScore);
			GameController.i.signal.dispatch({id: cell.id, side: cell.side, state: cell.state}, EVENT_CELL_UPDATE);
			GameController.i.signal.dispatch({side: cell.side, score: score}, EVENT_SCORE_UPDATE);
			if (this._playMode == 1 && p_side == GameData.SIDE_A)
			{
				this._aiA.useAct(p_command);
				GameController.i.signal.dispatch({side: p_side, cmd: this._aiA.cmd}, EVENT_CMD_UPDATE);
			}
			return true;
		}
		
		public function start():void
		{
			GameController.i.signal.dispatch({list: this._map.getList()}, EVENT_LOAD_COMPLETE);
			//	GameController.i.signal.dispatch(this._createResult, EVENT_CREATE_RESULT);
			GameController.i.signal.dispatch({side: GameData.SIDE_A, score: this.getScore(GameData.SIDE_A)}, EVENT_SCORE_UPDATE);
			GameController.i.signal.dispatch({side: GameData.SIDE_B, score: this.getScore(GameData.SIDE_B)}, EVENT_SCORE_UPDATE);
			GameController.i.signal.dispatch({side: GameData.SIDE_C, score: this.getScore(GameData.SIDE_C)}, EVENT_SCORE_UPDATE);
		}
		
		public function clear():void
		{
			this.buildMap();
			this.start();
		}
		
		public function getCellByKey(p_keyX:int, p_keyY:int, p_keyZ:int):MapCell
		{
			return this._map.getCellByKey(p_keyX, p_keyY, p_keyZ);
		}
		
		public function getMovableList(p_command:int, p_side:int):Array
		{
			var result:Array = [];
			if (p_side == 0)
			{
				return result;
			}
			
			var list:Array = this._map.getList();
			var cell:MapCell = null;
			var i:int = 0;
			switch (p_command)
			{
			case GameData.COMMAND_ATTACK: 
				for (i = 0; i < list.length; i++)
				{
					cell = list[i] as MapCell;
					if (cell.state != GameData.STATE_ROAD && cell.state != GameData.STATE_ROAD_EX)
					{
						continue;
					}
					if (cell.side == p_side)
					{
						continue;
					}
					if (this.checkBase(cell.id, p_side, false))
					{
						result.push(cell.id);
					}
				}
				break;
			case GameData.COMMAND_ROAD: 
				for (i = 0; i < list.length; i++)
				{
					cell = list[i] as MapCell;
					if (cell.state != GameData.STATE_NONE && cell.state != GameData.STATE_HOSTAGE)
					{
						continue;
					}
					if (cell.state == GameData.STATE_HOSTAGE)
					{
						if (cell.side != p_side)
						{
							continue;
						}
					}
					if (this.checkBase(cell.id, p_side, false))
					{
						result.push(cell.id);
					}
				}
				break;
			case GameData.COMMAND_ROAD_EX: 
				for (i = 0; i < list.length; i++)
				{
					cell = list[i] as MapCell;
					if (cell.state != GameData.STATE_NONE && cell.state != GameData.STATE_HOSTAGE)
					{
						continue;
					}
					if (cell.state == GameData.STATE_HOSTAGE)
					{
						if (cell.side != p_side)
						{
							continue;
						}
					}
					if (this.checkBase(cell.id, p_side, true))
					{
						result.push(cell.id);
					}
				}
				break;
			default: 
				;
			}
			return result;
		}
		
		public function undo():Boolean
		{
			if (this._record.length == 0)
			{
				return false;
			}
			var item:Array = this._record.pop();
			var state:int = item[0];
			if (state == GameData.STATE_HOSTAGE || state == GameData.STATE_OBSTACLE || state == GameData.STATE_BASE)
			{
				this._record.push(item);
				return false;
			}
			var preState:int = item[5];
			var preSide:int = item[6];
			var x:int = item[2];
			var y:int = item[3];
			var z:int = item[4];
			var side:int = item[1];
			var preScore:int = item[8];
			switch (preState)
			{
			case GameData.STATE_BASE: 
				this.addBase(preSide, x, y, z);
				break;
			case GameData.STATE_ROAD: 
				this.addRoad(preSide, x, y, z);
				break;
			case GameData.STATE_ROAD_EX: 
				this.addRoadEx(preSide, x, y, z);
				break;
			case GameData.STATE_OBSTACLE: 
				this.addObstacle(x, y, z);
				break;
			case GameData.STATE_HOSTAGE: 
				this.addHostage(preSide, x, y, z);
				break;
			default: 
				this.clearCell(x, y, z);
			}
			var cell:MapCell = this._map.getCellByKey(x, y, z);
			GameController.i.signal.dispatch({id: cell.id, side: cell.side, state: cell.state}, EVENT_CELL_UPDATE);
			GameController.i.signal.dispatch({side: side, score: preScore}, EVENT_SCORE_UPDATE);
			return true;
		}
		
		private function onAutoPlayTime(p_delta:Number):void
		{
			this._autoDelta += p_delta;
			if (this._autoDelta < GameConfig.getDemoSpeed())
			{
				return;
			}
			this._autoDelta -= GameConfig.getDemoSpeed();
			if (this._autoDelta > GameConfig.getDemoSpeed())
			{
				this._autoDelta = 0;
			}
			
			if (this._waitPlayer)
			{
				return;
			}
			
			if (this._autoState == 0)
			{
				this._aiA.addCmd();
				this._aiB.addCmd();
				this._aiC.addCmd();
			}
			this._autoState = (this._autoState + 1) % 3;
			
			var isDoAct:Boolean = false;
			var side:int = Helper.selectFrom([GameData.SIDE_A, GameData.SIDE_B, GameData.SIDE_C]) as int;
			switch (side)
			{
			case GameData.SIDE_A: 
				if (this._playMode == 1)
				{
					var cmdMap:Object = this._aiA.cmd;
					var cmdNum:int = cmdMap.atk + cmdMap.jmp + cmdMap.mov;
					if (cmdNum == 0)
					{
						break;
					}
					this._waitPlayer = true;
					GameController.i.signal.dispatch({side: side, cmd: this._aiA.cmd}, EVENT_CMD_UPDATE);
					return;
				}
				isDoAct = this._aiA.doAct();
				break;
			case GameData.SIDE_B: 
				isDoAct = this._aiB.doAct();
				break;
			case GameData.SIDE_C: 
				isDoAct = this._aiC.doAct();
				break;
			}
			if (!isDoAct)
			{
				this._autoDelta += GameConfig.getDemoSpeed();
			}
		}
		
		public function autoPlay():void
		{
			this._playMode = 0;
			if (!this._timer)
			{
				this._timer = new JTimer(this.onAutoPlayTime);
			}
			if (this._timer.state())
			{
				this._timer.stop();
			}
			else
			{
				this._timer.start();
			}
		}
		
		public function playGame(p_value:Boolean):void
		{
			this._playMode = 1;
			if (!this._timer)
			{
				this._timer = new JTimer(this.onAutoPlayTime);
			}
			if (this._timer.state())
			{
				if (!p_value)
				{
					this._timer.stop();
					GameController.i.signal.dispatch({state: 0}, EVENT_PLAY_STATE);
				}
			}
			else
			{
				if (p_value)
				{
					this._timer.start();
					GameController.i.signal.dispatch({state: 1}, EVENT_PLAY_STATE);
				}
			}
		}
		
		public function playPass():void
		{
			this._waitPlayer = false;
			GameController.i.signal.dispatch({side: GameData.SIDE_A, cmd: {atk: 0, jmp: 0, mov: 0}}, EVENT_CMD_UPDATE);
		}
		
		private function get aiCheckList():Array
		{
			if (!this._aiCheckList)
			{
				var maxDist:int = 6;
				var i:int = 0;
				var j:int = 0;
				var distList:Array = [];
				for (i = 0; i <= maxDist; i++)
				{
					distList.push([]);
				}
				for (i = -maxDist; i <= maxDist; i++)
				{
					var x:int = i;
					var yStart:int = -maxDist;
					if (x < 0)
					{
						yStart = -maxDist - x;
					}
					var yEnd:int = maxDist;
					if (x > 0)
					{
						yEnd = maxDist - x;
					}
					for (j = yStart; j <= yEnd; j++)
					{
						var dist:int = Math.abs(x);
						var y:int = j;
						if (Math.abs(y) > dist)
						{
							dist = Math.abs(y);
						}
						var z:int = -(x + y);
						if (Math.abs(z) > dist)
						{
							dist = Math.abs(z);
						}
						distList[dist].push({x: x, y: y, z: z});
					}
				}
				var list:Array = [];
				for (i = 1; i < distList.length; i++)
				{
					for (j = 0; j < distList[i].length; j++)
					{
						list.push(distList[i][j]);
					}
				}
				this._aiCheckList = list;
			}
			return this._aiCheckList;
		}
		
		public function getBestSide():int
		{
			var scoreA:int = this.getScore(GameData.SIDE_A);
			var scoreB:int = this.getScore(GameData.SIDE_B);
			var scoreC:int = this.getScore(GameData.SIDE_C);
			if (scoreA < GameConfig.getScoreMax() && (scoreA > scoreB || scoreB >= GameConfig.getScoreMax()) && (scoreA > scoreC || scoreC >= GameConfig.getScoreMax()))
			{
				return GameData.SIDE_A;
			}
			if (scoreB < GameConfig.getScoreMax() && (scoreB > scoreC || scoreC >= GameConfig.getScoreMax()) && (scoreB > scoreA || scoreA >= GameConfig.getScoreMax()))
			{
				return GameData.SIDE_B;
			}
			if (scoreC < GameConfig.getScoreMax() && (scoreC > scoreA || scoreA >= GameConfig.getScoreMax()) && (scoreC > scoreB || scoreB >= GameConfig.getScoreMax()))
			{
				return GameData.SIDE_C;
			}
			return 0;
		}
		
		public function getAIList(p_command:int, p_side:int, p_atkSide:int):Array
		{
			var result:Array = [];
			if (p_side == 0)
			{
				return result;
			}
			
			var targetList:Array = [];
			var cellList:Array = this._map.getList();
			var cell:MapCell = null;
			var i:int = 0;
			for (i = 0; i < cellList.length; i++)
			{
				cell = cellList[i] as MapCell;
				if (cell.state == GameData.STATE_HOSTAGE && cell.side == p_atkSide)
				{
					targetList.push({x: cell.keyX, y: cell.keyY, z: cell.keyZ});
				}
			}
			
			if (targetList.length == 0)
			{
				return result;
			}
			
			var list:Array = this._map.getList();
			switch (p_command)
			{
			case GameData.COMMAND_ATTACK: 
				for (i = 0; i < list.length; i++)
				{
					cell = list[i] as MapCell;
					if (cell.state != GameData.STATE_ROAD && cell.state != GameData.STATE_ROAD_EX)
					{
						continue;
					}
					if (cell.side == p_side)
					{
						continue;
					}
					if (this.checkBase(cell.id, p_side, false) && (p_side == p_atkSide || cell.side == p_atkSide))
					{
						result.push({id: cell.id, x: cell.keyX, y: cell.keyY, z: cell.keyZ, side: cell.side, score: -1});
					}
				}
				break;
			case GameData.COMMAND_ROAD: 
				for (i = 0; i < list.length; i++)
				{
					cell = list[i] as MapCell;
					if (cell.state != GameData.STATE_NONE && cell.state != GameData.STATE_HOSTAGE)
					{
						continue;
					}
					if (cell.state == GameData.STATE_HOSTAGE)
					{
						if (cell.side != p_side)
						{
							continue;
						}
					}
					if (this.checkBase(cell.id, p_side, false))
					{
						result.push({id: cell.id, x: cell.keyX, y: cell.keyY, z: cell.keyZ, side: cell.side, score: -1});
					}
				}
				break;
			case GameData.COMMAND_ROAD_EX: 
				for (i = 0; i < list.length; i++)
				{
					cell = list[i] as MapCell;
					if (cell.state != GameData.STATE_NONE && cell.state != GameData.STATE_HOSTAGE)
					{
						continue;
					}
					if (cell.state == GameData.STATE_HOSTAGE)
					{
						if (cell.side != p_side)
						{
							continue;
						}
					}
					if (this.checkBase(cell.id, p_side, true))
					{
						result.push({id: cell.id, x: cell.keyX, y: cell.keyY, z: cell.keyZ, side: cell.side, score: -1});
					}
				}
				break;
			default: 
				;
			}
			
			var item:Object = null;
			for (i = 0; i < result.length; i++)
			{
				item = result[i];
				for (var j:int = 0; j < targetList.length; j++)
				{
					var score:int = Math.abs(item.x - targetList[j].x) + Math.abs(item.y - targetList[j].y) + Math.abs(item.z - targetList[j].z);
					if (item.score == -1 || (item.score > score))
					{
						item.score = score;
					}
				}
			}
			var filterList:Array = result;
			result = [];
			filterList.sort(function(p_obj0:Object, p_obj1:Object):int
			{
				if (p_obj0.score > p_obj1.score)
				{
					return 1;
				}
				if (p_obj0.score < p_obj1.score)
				{
					return -1;
				}
				return 0;
			});
			for (i = 0; i < filterList.length; i++)
			{
				item = filterList[i];
				if (item.score > filterList[0].score)
				{
					break;
				}
				result.push(item);
			}
			return result;
		}
	
	}
}

import com.pj.common.Helper;
import com.pj.macross.GameConfig;
import com.pj.macross.GameData;
import com.pj.macross.GameModel;
import com.pj.macross.structure.MapCell;

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
	
	public function clear():void
	{
		for (var i:int = 0; i < this._list.length; i++)
		{
			var cell:MapCell = this._list[i] as MapCell;
			cell.side = 0;
			cell.state = 0;
		}
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

class SideAI
{
	private var _model:GameModel = null;
	private var _side:int = 0;
	private var _cmdList:Array = null;
	private var _cmdListAtk:Array = null;
	private var _cmdListJmp:Array = null;
	private var _cmdListMov:Array = null;
	
	public function SideAI(p_side:int, p_model:GameModel)
	{
		this._model = p_model;
		this._side = p_side;
		this._cmdList = [];
		this._cmdListAtk = [];
		this._cmdListJmp = [];
		this._cmdListMov = [];
	}
	
	public function get cmd():Object
	{
		return {//
			atk: this._cmdListAtk.length//
			, jmp: this._cmdListJmp.length//
			, mov: this._cmdListMov.length//
		};
	}
	
	public function addCmd():void
	{
		var command:int = Helper.selectFrom(GameConfig.getDemoCmd()) as int;
		if (command == GameData.COMMAND_ATTACK && this._cmdListAtk.length < GameConfig.getCmdStore())
		{
			this._cmdListAtk.push(command);
		}
		else if (command == GameData.COMMAND_ROAD_EX && this._cmdListJmp.length < GameConfig.getCmdStore())
		{
			this._cmdListJmp.push(command);
		}
		else if (command == GameData.COMMAND_ROAD && this._cmdListMov.length < GameConfig.getCmdStore())
		{
			this._cmdListMov.push(command);
		}
	}
	
	public function useAct(p_cmd:int):void
	{
		switch (p_cmd)
		{
		case GameData.COMMAND_ATTACK: 
			this._cmdListAtk.pop();
			break;
		case GameData.COMMAND_ROAD_EX: 
			this._cmdListJmp.pop();
			break;
		case GameData.COMMAND_ROAD: 
			this._cmdListMov.pop();
			break;
		default: 
			;
		}
	}
	
	public function doAct():Boolean
	{
		var finalCmd:int = 0;
		var finalId:int = 0;
		var finalScore:int = 0;
		var atkId:int = -1;
		var atkScore:int = -1;
		var jmpId:int = -1;
		var jmpScore:int = -1;
		var movId:int = -1;
		var movScore:int = -1;
		var bestSide:int = this._model.getBestSide();
		if (bestSide == 0 || Math.random() < 0)
		{
			bestSide = this._side;
		}
		var list:Array = null;
		var targetList:Array = [];
		if (this._cmdListAtk.length > 0)
		{
			list = this._model.getAIList(GameData.COMMAND_ATTACK, this._side, bestSide);
			if (list.length > 0)
			{
				atkId = (Helper.selectFrom(list) as Object).id as int;
				atkScore = list[0].score;
			}
			else if (bestSide != this._side)
			{
				list = this._model.getAIList(GameData.COMMAND_ATTACK, this._side, this._side);
				if (list.length > 0)
				{
					atkId = (Helper.selectFrom(list) as Object).id as int;
					atkScore = list[0].score;
				}
				else
				{
					var remainSide:int = GameData.SIDE_A;
					if (this._side == GameData.SIDE_A || bestSide == GameData.SIDE_A)
					{
						remainSide = GameData.SIDE_B;
						if (this._side == GameData.SIDE_B || bestSide == GameData.SIDE_B)
						{
							remainSide = GameData.SIDE_C;
						}
					}
					list = this._model.getAIList(GameData.COMMAND_ATTACK, this._side, remainSide);
					if (list.length > 0)
					{
						atkId = (Helper.selectFrom(list) as Object).id as int;
						atkScore = list[0].score;
					}
				}
			}
		}
		if (this._cmdListJmp.length > 0)
		{
			list = this._model.getAIList(GameData.COMMAND_ROAD_EX, this._side, bestSide);
			if (list.length > 0)
			{
				jmpId = (Helper.selectFrom(list) as Object).id as int;
				jmpScore = list[0].score;
			}
		}
		if (this._cmdListMov.length > 0)
		{
			list = this._model.getAIList(GameData.COMMAND_ROAD, this._side, bestSide);
			if (list.length > 0)
			{
				movId = (Helper.selectFrom(list) as Object).id as int;
				movScore = list[0].score;
			}
		}
		if (movId != -1 && (finalCmd == 0 || movScore < finalScore))
		{
			finalCmd = GameData.COMMAND_ROAD;
			finalId = movId;
			finalScore = movScore;
		}
		if (jmpId != -1 && (finalCmd == 0 || (jmpScore != -1 && jmpScore < finalScore)))
		{
			finalCmd = GameData.COMMAND_ROAD_EX;
			finalId = jmpId;
			finalScore = jmpScore;
		}
		if (atkId != -1 && (finalCmd == 0 || (atkScore != -1 && atkScore < finalScore)))
		{
			finalCmd = GameData.COMMAND_ATTACK;
			finalId = atkId;
			finalScore = atkScore;
		}
		
		if (finalCmd == GameData.COMMAND_ATTACK)
		{
			this._cmdListAtk.pop();
		}
		else if (finalCmd == GameData.COMMAND_ROAD)
		{
			this._cmdListMov.pop();
		}
		else if (finalCmd == GameData.COMMAND_ROAD_EX)
		{
			this._cmdListJmp.pop();
		}
		else
		{
			return false;
		}
		
		this._model.command(finalId, this._side, finalCmd);
		return true;
	}

}