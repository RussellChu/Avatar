package com.pj
{
	import com.pj.common.Helper;
	import com.pj.common.JColor;
	import com.pj.common.JSignal;
	import com.pj.common.component.BasicContainer;
	import com.pj.common.component.JBackground;
	import com.pj.common.component.Slider;
	import com.pj.macross.GameAsset;
	import com.pj.macross.GameConfig;
	import com.pj.macross.GameData;
	import com.pj.macross.GameModel;
	import com.pj.macross.asset.CellSkin;
	import com.pj.macross.structure.MapCell;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class ProjectMacross extends BasicContainer
	{
		private var _bg:JBackground = null;
		private var _command:CommandGroup = null;
		private var _map:ButtonHexagonGroup = null;
		private var _msg:TextField = null;
		private var _model:GameModel = null;
		private var _slider:Slider = null;
		
		public function ProjectMacross(p_inst:Sprite = null)
		{
			super(null, p_inst);
		}
		
		override public function dispose():void
		{
			Helper.dispose(this._bg);
			Helper.dispose(this._map);
			Helper.dispose(this._model);
			Helper.dispose(this._slider);
			this._bg = null;
			this._map = null;
			this._model = null;
			this._slider = null;
			super.dispose();
		}
		
		override protected function init():void
		{
			super.init();
			GameAsset.loader.signal.add(this.onAssetLoaded);
			GameAsset.loader.load();
			
			JTimerCtrl.setStage(this.instance.stage);
		}
		
		override public function reset():void
		{
			super.reset();
		}
		
		override public function resize(p_width:int, p_height:int):void
		{
			this._bg.resize(p_width, p_height);
			this._slider.resize(p_width, p_height);
			var totalWidth:int = (GameConfig.MAP_RADIUS * 6 - 3) * GameConfig.CELL_RADIUS_MAP;
			var posX:int = (p_width - totalWidth) * 0.5;
			var posY:int = (p_height - totalWidth) * 0.5;
			if (posX < 0)
			{
				posX = 0;
			}
			if (posY < 0)
			{
				posY = 0;
			}
			this._map.instance.x = posX;
			this._map.instance.y = posY;
		}
		
		private function onAssetLoaded(p_result:Object):void
		{
			this._model = new GameModel();
			
			this._bg = new JBackground((GameAsset.loader.getAsset("galaxy") as Bitmap).bitmapData);
			this._bg.resize(this.instance.stage.stageWidth, this.instance.stage.stageHeight);
			this.addChild(this._bg);
			
			var totalWidth:int = (GameConfig.MAP_RADIUS * 6 - 3) * GameConfig.CELL_RADIUS_MAP;
			this._slider = new Slider(this, this.instance.stage.stageWidth, this.instance.stage.stageHeight, totalWidth, totalWidth);
			
			this._map = new ButtonHexagonGroup(this._slider);
			this._map.createMap(this._model.getCellList());
			this._map.signal.add(this.onMapSignal);
			
			this._command = new CommandGroup(this);
			this._command.setScore(GameData.SIDE_A, this._model.getScore(GameData.SIDE_A));
			this._command.setScore(GameData.SIDE_B, this._model.getScore(GameData.SIDE_B));
			this._command.setScore(GameData.SIDE_C, this._model.getScore(GameData.SIDE_C));
			this._command.signal.add(this.onCommand);
			
			var cellSkin:CellSkin = GameAsset.loader.getAsset(GameConfig.ASSET_KEY_CMD_CELL) as CellSkin;
			this._msg = new TextField();
			this._msg.x = cellSkin.width * 3;
			this._msg.mouseEnabled = false;
			this._msg.alpha = 0.5;
			this._msg.background = true;
			this._msg.backgroundColor = new JColor(1, 1, 1, 1).value;
			this._msg.autoSize = TextFieldAutoSize.LEFT;
			this.container.addChild(this._msg);
			this.setMsg("");
		}
		
		private function onCommand(p_result:Object):void
		{
			if (!p_result)
			{
				this._map.flashClear();
				return;
			}
			
			var command:int = p_result.command;
			var side:int = p_result.side;
			var dataState:Object = null;
			switch (command)
			{
			case GameData.COMMAND_UNDO: 
				this._map.flashClear();
				dataState = _model.undo();
				if (!dataState)
				{
					return;
				}
				this._map.setState(dataState.id, dataState.side, dataState.state);
				this._command.setScore(dataState.scoreSide, dataState.score);
				break;
			case GameData.COMMAND_CLEAR: 
				this._map.flashClear();
				dataState = {};
				while (dataState)
				{
					dataState = _model.undo();
					if (!dataState)
					{
						return;
					}
					this._map.setState(dataState.id, dataState.side, dataState.state);
					this._command.setScore(dataState.scoreSide, dataState.score);
				}
				break;
			case GameData.COMMAND_SAVE: 
				this._map.flashClear();
				this._model.save();
				break;
			case GameData.COMMAND_NONE: 
				break;
			default: 
				this.updateMovable(command, side);
			}
		}
		
		private function updateMovable(p_command:int, p_side:int):void
		{
			var list:Array = this._model.getMovableList(p_command, p_side);
			var state:int = 0;
			if (p_command == GameData.COMMAND_ROAD_EX)
			{
				state = GameData.STATE_ROAD_EX;
			}
			else
			{
				state = GameData.STATE_ROAD;
			}
			this._map.flash(p_side, state, list);
		
			//var otherSide0:int = GameData.SIDE_B;
			//var otherSide1:int = GameData.SIDE_C;
			//if (p_side == GameData.SIDE_B) {
			//otherSide0 = GameData.SIDE_A;
			//}
			//if (p_side == GameData.SIDE_C) {
			//otherSide1 = GameData.SIDE_A;
			//}
			//var moveId:int = this._model.findMoveId(p_side);
			//var runId0:int = this._model.findRunId(p_side, otherSide0);
			//var runId1:int = this._model.findRunId(p_side, otherSide1);
			//this.setMsg("" + moveId + " - " + runId0 + " - " + runId1);
		}
		
		private function setMsg(p_str:String):void
		{
			this._msg.text = p_str;
			this._msg.height = this._msg.textHeight;
		}
		
		private function onMapSignal(p_result:Object):void
		{
			var dataCell:MapCell = p_result as MapCell;
			
			var command:int = this._command.command;
			var side:int = this._command.side;
			switch (command)
			{
			case GameData.COMMAND_UNDO: 
			case GameData.COMMAND_CLEAR: 
			case GameData.COMMAND_SAVE: 
			case GameData.COMMAND_NONE: 
				return;
			default: 
				;
			}
			var dataState:Object = this._model.command(dataCell.id, side, command);
			if (dataState)
			{
				this._map.setState(dataState.id, dataState.side, dataState.state);
				this._command.setScore(dataState.scoreSide, dataState.score);
				this.updateMovable(command, side);
			}
		}
	
	}
}

import com.pj.common.Helper;
import com.pj.common.JColor;
import com.pj.common.component.AbstractButton;
import com.pj.common.component.BasicButton;
import com.pj.common.component.BasicContainer;
import com.pj.common.component.BasicSkin;
import com.pj.common.component.IContainer;
import com.pj.common.component.Quad;
import com.pj.common.component.ToggleButtonGroup;
import com.pj.macross.GameAsset;
import com.pj.macross.GameConfig;
import com.pj.macross.GameData;
import com.pj.macross.asset.CellSkin;
import com.pj.macross.structure.MapCell;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.text.TextFormat;
import flash.utils.Timer;
import flash.utils.setTimeout;

class JTimerCtrl
{
	static private var __inst:JTimerCtrl = null;
	private var _list:Vector.<JTimer> = null;
	private var _timer:Timer = null;
	private var _count:int = 0;
	
	static public function add(p_timer:JTimer):int
	{
		if (!__inst)
		{
			__inst = new JTimerCtrl();
		}
		__inst._list.push(p_timer);
		return __inst._list.length;
	}
	
	static public function setStage(p_stage:Stage):void {
		if (!__inst)
		{
			__inst = new JTimerCtrl();
		}
		//	p_stage.addEventListener(Event.ENTER_FRAME, __inst.onTime);
	}
	
	public function JTimerCtrl()
	{
		this._list = new Vector.<JTimer>();
		this._timer = new Timer(20);
		this._timer.addEventListener(TimerEvent.TIMER, this.onTime);
	//	this.loop();
		this._timer.start();
	}
	
	private function onTime(p_evt:Event):void
	{
		if (this._list.length == 0)
		{
			return;
		}
		
		var a:Number = new Date().time;
		var count:int = 0;
		var id:int = -1;
		var timer:JTimer = null;
		while (a == new Date().time)
		{
			timer = this._list.shift();
			if (timer.isDisposed())
			{
				if (this._list.length == 0)
				{
					return;
				}
				timer = null;
				continue;
			}
			if (id == -1)
			{
				id = timer.id;
			}
			else
			{
				if (id == timer.id)
				{
					this._list.push(timer);
					break;
				}
			}
			if (!timer.state())
			{
				this._list.push(timer);
				timer = null;
				continue;
			}
			timer.run();
			this._list.push(timer);
			count++;
		}
		trace(count);
	}
}

class JTimer
{
	private var _dispose:Boolean = false;
	private var _func:Function;
	private var _id:int = 0;
	private var _run:Boolean = false;
	private var _time:Number = 0;
	
	public function JTimer(p_func:Function)
	{
		this._func = p_func;
		this._id = JTimerCtrl.add(this);
	}
	
	public function get id():int
	{
		return this._id;
	}
	
	public function dispose():void
	{
		this._dispose = true;
	}
	
	public function isDisposed():Boolean
	{
		return this._dispose;
	}
	
	public function run():void
	{
		var currTime:Number = new Date().time;
		this._func(currTime - this._time);
		this._time = currTime;
	}
	
	public function start():void
	{
		this._time = new Date().time;
		this._run = true;
	}
	
	public function state():Boolean
	{
		return this._run;
	}
	
	public function stop():void
	{
		this._run = false;
	}
}

class ButtonHexagonFace extends BasicSkin
{
	static public const FACE_BLANK:int = 0;
	static public const FACE_BASE_0:int = 1;
	static public const FACE_BASE_1:int = 2;
	static public const FACE_BASE_2:int = 3;
	static public const FACE_ROAD_0:int = 4;
	static public const FACE_ROAD_1:int = 5;
	static public const FACE_ROAD_2:int = 6;
	static public const FACE_ROAD_EX_0:int = 7;
	static public const FACE_ROAD_EX_1:int = 8;
	static public const FACE_ROAD_EX_2:int = 9;
	static public const FACE_ATTACK:int = 10;
	static public const FACE_HOSTAGE_0:int = 11;
	static public const FACE_HOSTAGE_1:int = 12;
	static public const FACE_HOSTAGE_2:int = 13;
	static public const FACE_OBSTACLE:int = 14;
	static public const FACE_HOSTAGE_BG_0:int = 15;
	static public const FACE_HOSTAGE_BG_1:int = 16;
	static public const FACE_HOSTAGE_BG_2:int = 17;
	
	private var _imgBlank:Bitmap = null;
	private var _imgDown:Bitmap = null;
	private var _imgOver:Bitmap = null;
	private var _imgBase0:Bitmap = null;
	private var _imgBase1:Bitmap = null;
	private var _imgBase2:Bitmap = null;
	private var _imgRoad0:Bitmap = null;
	private var _imgRoad1:Bitmap = null;
	private var _imgRoad2:Bitmap = null;
	private var _imgFold:Sprite = null;
	private var _imgAttack:Bitmap = null;
	private var _imgHostage:Bitmap = null;
	private var _imgHostage2:Bitmap = null;
	private var _imgHostageBg0:Sprite = null;
	private var _imgHostageBg1:Sprite = null;
	private var _imgHostageBg2:Sprite = null;
	private var _imgObstacle:Bitmap = null;
	
	private var _isFlash:Boolean = false;
	private var _isRotate:Boolean = false;
	private var _timer:JTimer = null;
	private var _timeFlash:Number = 0;
	private var _timeRotate:Number = 0;
	
	private var _mapImage:Object = null;
	private var _rotTarget:DisplayObject = null;
	private var _spFlash:Sprite = null;
	
	public function ButtonHexagonFace( //
	p_bmpBlank:BitmapData//
	, p_bmpDown:BitmapData//
	, p_bmpOver:BitmapData//
	, p_bmpBase0:BitmapData//
	, p_bmpBase1:BitmapData//
	, p_bmpBase2:BitmapData//
	, p_bmpRoad0:BitmapData//
	, p_bmpRoad1:BitmapData//
	, p_bmpRoad2:BitmapData//
	, p_bmpFold:BitmapData//
	, p_bmpAttack:BitmapData//
	, p_bmpHostage:BitmapData//
	, p_bmpHostageBg0:BitmapData//
	, p_bmpHostageBg1:BitmapData//
	, p_bmpHostageBg2:BitmapData//
	, p_bmpObstacle:BitmapData//
	)
	{
		this._imgBlank = new Bitmap(p_bmpBlank);
		this._imgDown = new Bitmap(p_bmpDown);
		this._imgOver = new Bitmap(p_bmpOver);
		this._imgBase0 = new Bitmap(p_bmpBase0);
		this._imgBase1 = new Bitmap(p_bmpBase1);
		this._imgBase2 = new Bitmap(p_bmpBase2);
		this._imgRoad0 = new Bitmap(p_bmpRoad0);
		this._imgRoad1 = new Bitmap(p_bmpRoad1);
		this._imgRoad2 = new Bitmap(p_bmpRoad2);
		var img:Bitmap = new Bitmap(p_bmpFold);
		this._imgFold = new Sprite();
		this._imgFold.addChild(img);
		img.x = -img.width * 0.5;
		img.y = -img.height * 0.5;
		this._imgFold.x = -img.x;
		this._imgFold.y = -img.y;
		this._imgAttack = new Bitmap(p_bmpAttack);
		
		img = new Bitmap(p_bmpHostageBg0);
		this._imgHostageBg0 = new Sprite();
		this._imgHostageBg0.addChild(img);
		img.x = -img.width * 0.5;
		img.y = -img.height * 0.5;
		this._imgHostageBg0.x = -img.x;
		this._imgHostageBg0.y = -img.y * 1.4;
		
		img = new Bitmap(p_bmpHostageBg1);
		this._imgHostageBg1 = new Sprite();
		this._imgHostageBg1.addChild(img);
		img.x = -img.width * 0.5;
		img.y = -img.height * 0.5;
		this._imgHostageBg1.x = -img.x;
		this._imgHostageBg1.y = -img.y * 1.4;
		
		img = new Bitmap(p_bmpHostageBg2);
		this._imgHostageBg2 = new Sprite();
		this._imgHostageBg2.addChild(img);
		img.x = -img.width * 0.5;
		img.y = -img.height * 0.5;
		this._imgHostageBg2.x = -img.x;
		this._imgHostageBg2.y = -img.y * 1.4;
		
		this._imgHostage = new Bitmap(p_bmpHostage);
		this._imgHostage2 = new Bitmap(p_bmpHostage);
		
		this._imgObstacle = new Bitmap(p_bmpObstacle);
		super();
	}
	
	override public function dispose():void
	{
		Helper.dispose(this._timer);
		this._imgBlank = null;
		this._imgDown = null;
		this._imgOver = null;
		this._imgBase0 = null;
		this._imgBase1 = null;
		this._imgBase2 = null;
		this._imgRoad0 = null;
		this._imgRoad1 = null;
		this._imgRoad2 = null;
		this._imgFold = null;
		this._imgAttack = null;
		this._imgHostage = null;
		this._imgHostage2 = null;
		this._imgHostageBg0 = null;
		this._imgHostageBg1 = null;
		this._imgHostageBg2 = null;
		this._imgObstacle = null;
		this._mapImage = null;
		this._timer = null;
		super.dispose();
	}
	
	override protected function init():void
	{
		super.init();
		this.container.addChild(this._imgBlank);
		this._spFlash = new Sprite();
		this.container.addChild(this._spFlash);
		this._spFlash.addChild(this._imgBase0);
		this._spFlash.addChild(this._imgBase1);
		this._spFlash.addChild(this._imgBase2);
		this._spFlash.addChild(this._imgRoad0);
		this._spFlash.addChild(this._imgRoad1);
		this._spFlash.addChild(this._imgRoad2);
		this._spFlash.addChild(this._imgFold);
		this._spFlash.addChild(this._imgAttack);
		this._spFlash.addChild(this._imgHostage2);
		
		var mask:Quad = new Quad(this._imgHostage.width, this._imgHostage.height * 0.3);
		mask.instance.y = this._imgHostage.height * 0.7;
		this._spFlash.addChild(mask.instance);
		this._imgHostage2.mask = mask.instance;
		
		this._spFlash.addChild(this._imgHostageBg0);
		this._spFlash.addChild(this._imgHostageBg1);
		this._spFlash.addChild(this._imgHostageBg2);
		this._spFlash.addChild(this._imgHostage);
		
		mask = new Quad(this._imgHostage.width, this._imgHostage.height * 0.7);
		this._spFlash.addChild(mask.instance);
		this._imgHostage.mask = mask.instance;
		
		this._spFlash.addChild(this._imgObstacle);
		this.container.addChild(this._imgDown);
		this.container.addChild(this._imgOver);
		
		this._mapImage = {};
		this._mapImage[FACE_BASE_0] = this._imgBase0;
		this._mapImage[FACE_BASE_1] = this._imgBase1;
		this._mapImage[FACE_BASE_2] = this._imgBase2;
		this._mapImage[FACE_ROAD_0] = this._imgRoad0;
		this._mapImage[FACE_ROAD_1] = this._imgRoad1;
		this._mapImage[FACE_ROAD_2] = this._imgRoad2;
		this._mapImage[FACE_ATTACK] = this._imgAttack;
		//	this._mapImage[FACE_HOSTAGE] = this._imgHostage;
		this._mapImage[FACE_HOSTAGE_0] = this._imgHostageBg0;
		this._mapImage[FACE_HOSTAGE_1] = this._imgHostageBg1;
		this._mapImage[FACE_HOSTAGE_2] = this._imgHostageBg2;
		this._mapImage[FACE_OBSTACLE] = this._imgObstacle;
		
		this._timer = new JTimer(this.onTime);
	}
	
	override public function reset():void
	{
		super.reset();
		this._isFlash = false;
		this._isRotate = false;
		this._timer.stop();
		this._timeFlash = 0;
		this._timeRotate = 0;
		this.setFace(FACE_BLANK);
	}
	
	private function onTime(p_delta:Number):void
	{
		if (this._isRotate)
		{
			this._timeRotate += 0.0001 * p_delta;
			if (this._timeRotate > 1)
			{
				this._timeRotate -= 1;
			}
			if (this._rotTarget)
			{
				if (this._rotTarget.visible)
				{
					this._rotTarget.rotation = 360 * this._timeRotate;
				}
			}
		}
		if (this._isFlash)
		{
			this._timeFlash += 0.0005 * p_delta;
			if (this._timeFlash > 2)
			{
				this._timeFlash -= 2;
			}
			if (this._timeFlash < 1)
			{
				this._spFlash.alpha = this._timeFlash;
			}
			else
			{
				this._spFlash.alpha = 2 - this._timeFlash;
			}
		}
	}
	
	override public function show(p_id:int):void
	{
		switch (p_id)
		{
		case BasicButton.SKIN_IDLE: 
			this._imgBlank.visible = true;
			this._imgDown.visible = false;
			this._imgOver.visible = false;
			break;
		case BasicButton.SKIN_DOWN: 
			this._imgDown.visible = true;
			this._imgOver.visible = false;
			break;
		case BasicButton.SKIN_OVER: 
			this._imgDown.visible = false;
			this._imgOver.visible = true;
			break;
		default: 
			;
		}
	}
	
	public function setFace(p_id:int):void
	{
		var isFold:Boolean = false;
		var isHostage:Boolean = false;
		var isHostageBg:Boolean = false;
		
		var realId:int = p_id;
		if (p_id == FACE_ROAD_EX_0)
		{
			realId = FACE_ROAD_0;
			isFold = true;
		}
		if (p_id == FACE_ROAD_EX_1)
		{
			realId = FACE_ROAD_1;
			isFold = true;
		}
		if (p_id == FACE_ROAD_EX_2)
		{
			realId = FACE_ROAD_2;
			isFold = true;
		}
		
		if (p_id == FACE_HOSTAGE_0)
		{
			isHostage = true;
			this._rotTarget = this._imgHostageBg0;
		}
		if (p_id == FACE_HOSTAGE_1)
		{
			isHostage = true;
			this._rotTarget = this._imgHostageBg1;
		}
		if (p_id == FACE_HOSTAGE_2)
		{
			isHostage = true;
			this._rotTarget = this._imgHostageBg2;
		}
		
		if (p_id == FACE_HOSTAGE_BG_0)
		{
			realId = FACE_HOSTAGE_0;
			isHostageBg = true;
			this._rotTarget = this._imgHostageBg0;
		}
		if (p_id == FACE_HOSTAGE_BG_1)
		{
			realId = FACE_HOSTAGE_1;
			isHostageBg = true;
			this._rotTarget = this._imgHostageBg1;
		}
		if (p_id == FACE_HOSTAGE_BG_2)
		{
			realId = FACE_HOSTAGE_2;
			isHostageBg = true;
			this._rotTarget = this._imgHostageBg2;
		}
		
		for (var key:String in this._mapImage)
		{
			var img:DisplayObject = this._mapImage[key] as DisplayObject;
			img.visible = (key == String(realId));
		}
		if (isFold)
		{
			this._rotTarget = this._imgFold;
		}
		this._imgFold.visible = isFold;
		this.rotate(isFold || isHostage || isHostageBg);
		
		this._imgHostage.visible = isHostage;
		this._imgHostage2.visible = isHostage;
	}
	
	private function rotate(p_value:Boolean):void
	{
		if (p_value)
		{
			if (!this._isFlash && !this._isRotate)
			{
				this._timer.start();
			}
			this._isRotate = true;
		}
		else
		{
			this._isRotate = false;
			this._timeRotate = 0;
			if (!this._isFlash && !this._isRotate)
			{
				this._timer.stop();
			}
		}
	}
	
	public function flash(p_value:Boolean):void
	{
		if (p_value)
		{
			if (!this._isFlash && !this._isRotate)
			{
				this._timer.start();
			}
			if (this._spFlash)
			{
				this._spFlash.alpha = 0;
			}
			this._isFlash = true;
		}
		else
		{
			if (this._spFlash)
			{
				this._spFlash.alpha = 1;
			}
			this._isFlash = false;
			this._timeFlash = 0;
			if (!this._isFlash && !this._isRotate)
			{
				this._timer.stop();
			}
		}
	}

}

class ButtonHexagon extends BasicButton
{
	private var _side:int = 0;
	private var _state:int = 0;
	private var _fontSize:int = 0;
	
	public function ButtonHexagon(p_title:String, p_fontSize:int, p_assetKey:String, p_data:Object = null)
	{
		this._fontSize = p_fontSize;
		
		var cellSkin:CellSkin = GameAsset.loader.getAsset(p_assetKey) as CellSkin;
		var skin:ButtonHexagonFace = new ButtonHexagonFace( //
		cellSkin.getBitmap(CellSkin.IMG_BLANK)//
		, cellSkin.getBitmap(CellSkin.IMG_DOWN)//
		, cellSkin.getBitmap(CellSkin.IMG_OVER)//
		, cellSkin.getBitmap(CellSkin.IMG_BASE_0)//
		, cellSkin.getBitmap(CellSkin.IMG_BASE_1)//
		, cellSkin.getBitmap(CellSkin.IMG_BASE_2)//
		, cellSkin.getBitmap(CellSkin.IMG_ROAD_0)//
		, cellSkin.getBitmap(CellSkin.IMG_ROAD_1)//
		, cellSkin.getBitmap(CellSkin.IMG_ROAD_2)//
		, cellSkin.getBitmap(CellSkin.IMG_FOLD)//
		, cellSkin.getBitmap(CellSkin.IMG_ATTACK)//
		, cellSkin.getBitmap(CellSkin.IMG_HOSTAGE)//
		, cellSkin.getBitmap(CellSkin.IMG_HOSTAGE_BG_0)//
		, cellSkin.getBitmap(CellSkin.IMG_HOSTAGE_BG_1)//
		, cellSkin.getBitmap(CellSkin.IMG_HOSTAGE_BG_2)//
		, cellSkin.getBitmap(CellSkin.IMG_OBSTACLE)//
		);
		
		super(p_title//
		, cellSkin.width//
		, cellSkin.height//
		, skin//
		, p_data//
		, ALIGN_BOTTON//
		);
	}
	
	override protected function init():void
	{
		super.init();
		
		var format:TextFormat = new TextFormat();
		format.size = this._fontSize;
		this._txtTitle.defaultTextFormat = format;
		this._txtTitle.textColor = new JColor(0.75, 0.5, 1, 1).value;
		this._txtTitle.visible = true;
	}
	
	public function flash(p_value:Boolean, p_side:int, p_state:int):void
	{
		var face:ButtonHexagonFace = this.skin as ButtonHexagonFace;
		face.flash(p_value);
		if (!p_value)
		{
			this.setStateFinal(this._side, this._state);
			return;
		}
		
		this.setStateFinal(p_side, p_state);
	}
	
	private function setStateFinal(p_side:int, p_state:int):void
	{
		var face:ButtonHexagonFace = this.skin as ButtonHexagonFace;
		switch (p_state)
		{
		case GameData.STATE_BASE: 
			switch (p_side)
			{
			case GameData.SIDE_A: 
				face.setFace(ButtonHexagonFace.FACE_BASE_0);
				break;
			case GameData.SIDE_B: 
				face.setFace(ButtonHexagonFace.FACE_BASE_1);
				break;
			case GameData.SIDE_C: 
				face.setFace(ButtonHexagonFace.FACE_BASE_2);
				break;
			default: 
				face.setFace(ButtonHexagonFace.FACE_BLANK);
			}
			break;
		case GameData.STATE_ATTACK: 
			face.setFace(ButtonHexagonFace.FACE_ATTACK);
			break;
		case GameData.STATE_HOSTAGE: 
			switch (p_side)
			{
			case GameData.SIDE_A: 
				face.setFace(ButtonHexagonFace.FACE_HOSTAGE_0);
				break;
			case GameData.SIDE_B: 
				face.setFace(ButtonHexagonFace.FACE_HOSTAGE_1);
				break;
			case GameData.SIDE_C: 
				face.setFace(ButtonHexagonFace.FACE_HOSTAGE_2);
				break;
			default: 
				face.setFace(ButtonHexagonFace.FACE_BLANK);
			}
			break;
		case GameData.STATE_OBSTACLE: 
			face.setFace(ButtonHexagonFace.FACE_OBSTACLE);
			break;
		case GameData.STATE_ROAD: 
			switch (p_side)
			{
			case GameData.SIDE_A: 
				face.setFace(ButtonHexagonFace.FACE_ROAD_0);
				break;
			case GameData.SIDE_B: 
				face.setFace(ButtonHexagonFace.FACE_ROAD_1);
				break;
			case GameData.SIDE_C: 
				face.setFace(ButtonHexagonFace.FACE_ROAD_2);
				break;
			default: 
				face.setFace(ButtonHexagonFace.FACE_BLANK);
			}
			break;
		case GameData.STATE_ROAD_EX: 
			switch (p_side)
			{
			case GameData.SIDE_A: 
				face.setFace(ButtonHexagonFace.FACE_ROAD_EX_0);
				break;
			case GameData.SIDE_B: 
				face.setFace(ButtonHexagonFace.FACE_ROAD_EX_1);
				break;
			case GameData.SIDE_C: 
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
	
	public function setState(p_side:int, p_state:int):void
	{
		this._side = p_side;
		this._state = p_state;
		this.setStateFinal(this._side, this._state);
	}

}

class CommandHexagonToggle extends BasicButton
{
	private var _fontSize:int = 0;
	
	public function CommandHexagonToggle(p_title:String, p_fontSize:int, p_assetKey:String, p_data:Object = null)
	{
		this._fontSize = p_fontSize;
		
		var cellSkin:CellSkin = GameAsset.loader.getAsset(p_assetKey) as CellSkin;
		var skin:ButtonHexagonFace = new ButtonHexagonFace( //
		cellSkin.getBitmap(CellSkin.IMG_BLANK)//
		, cellSkin.getBitmap(CellSkin.IMG_DOWN)//
		, cellSkin.getBitmap(CellSkin.IMG_OVER)//
		, cellSkin.getBitmap(CellSkin.IMG_BASE_0)//
		, cellSkin.getBitmap(CellSkin.IMG_BASE_1)//
		, cellSkin.getBitmap(CellSkin.IMG_BASE_2)//
		, cellSkin.getBitmap(CellSkin.IMG_ROAD_0)//
		, cellSkin.getBitmap(CellSkin.IMG_ROAD_1)//
		, cellSkin.getBitmap(CellSkin.IMG_ROAD_2)//
		, cellSkin.getBitmap(CellSkin.IMG_FOLD)//
		, cellSkin.getBitmap(CellSkin.IMG_ATTACK)//
		, cellSkin.getBitmap(CellSkin.IMG_HOSTAGE)//
		, cellSkin.getBitmap(CellSkin.IMG_HOSTAGE_BG_0)//
		, cellSkin.getBitmap(CellSkin.IMG_HOSTAGE_BG_1)//
		, cellSkin.getBitmap(CellSkin.IMG_HOSTAGE_BG_2)//
		, cellSkin.getBitmap(CellSkin.IMG_OBSTACLE)//
		);
		
		super(p_title//
		, cellSkin.width//
		, cellSkin.height//
		, skin//
		, p_data//
		, ALIGN_CENTER//
		, 0//
		, true);
	}
	
	override protected function init():void
	{
		super.init();
		
		var format:TextFormat = new TextFormat();
		format.size = this._fontSize;
		this._txtTitle.defaultTextFormat = format;
		this._txtTitle.textColor = new JColor(1, 1, 0, 1).value;
		this._txtTitle.visible = true;
	}
	
	public function setState(p_side:int, p_state:int):void
	{
		var face:ButtonHexagonFace = this.skin as ButtonHexagonFace;
		switch (p_state)
		{
		case GameData.STATE_BASE: 
			switch (p_side)
			{
			case GameData.SIDE_A: 
				face.setFace(ButtonHexagonFace.FACE_BASE_0);
				break;
			case GameData.SIDE_B: 
				face.setFace(ButtonHexagonFace.FACE_BASE_1);
				break;
			case GameData.SIDE_C: 
				face.setFace(ButtonHexagonFace.FACE_BASE_2);
				break;
			default: 
				face.setFace(ButtonHexagonFace.FACE_BLANK);
			}
			break;
		case GameData.STATE_ATTACK: 
			face.setFace(ButtonHexagonFace.FACE_ATTACK);
			break;
		case GameData.STATE_HOSTAGE: 
			switch (p_side)
			{
			case GameData.SIDE_A: 
				face.setFace(ButtonHexagonFace.FACE_HOSTAGE_0);
				break;
			case GameData.SIDE_B: 
				face.setFace(ButtonHexagonFace.FACE_HOSTAGE_1);
				break;
			case GameData.SIDE_C: 
				face.setFace(ButtonHexagonFace.FACE_HOSTAGE_2);
				break;
			default: 
				face.setFace(ButtonHexagonFace.FACE_BLANK);
			}
			break;
		case GameData.STATE_HOSTAGE_BG: 
			switch (p_side)
			{
			case GameData.SIDE_A: 
				face.setFace(ButtonHexagonFace.FACE_HOSTAGE_BG_0);
				break;
			case GameData.SIDE_B: 
				face.setFace(ButtonHexagonFace.FACE_HOSTAGE_BG_1);
				break;
			case GameData.SIDE_C: 
				face.setFace(ButtonHexagonFace.FACE_HOSTAGE_BG_2);
				break;
			default: 
				face.setFace(ButtonHexagonFace.FACE_BLANK);
			}
			break;
		case GameData.STATE_OBSTACLE: 
			face.setFace(ButtonHexagonFace.FACE_OBSTACLE);
			break;
		case GameData.STATE_ROAD: 
			switch (p_side)
			{
			case GameData.SIDE_A: 
				face.setFace(ButtonHexagonFace.FACE_ROAD_0);
				break;
			case GameData.SIDE_B: 
				face.setFace(ButtonHexagonFace.FACE_ROAD_1);
				break;
			case GameData.SIDE_C: 
				face.setFace(ButtonHexagonFace.FACE_ROAD_2);
				break;
			default: 
				face.setFace(ButtonHexagonFace.FACE_BLANK);
			}
			break;
		case GameData.STATE_ROAD_EX: 
			switch (p_side)
			{
			case GameData.SIDE_A: 
				face.setFace(ButtonHexagonFace.FACE_ROAD_EX_0);
				break;
			case GameData.SIDE_B: 
				face.setFace(ButtonHexagonFace.FACE_ROAD_EX_1);
				break;
			case GameData.SIDE_C: 
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

class CommandGroup extends BasicContainer
{
	private var _btnScoreA:CommandHexagonToggle = null;
	private var _btnScoreB:CommandHexagonToggle = null;
	private var _btnScoreC:CommandHexagonToggle = null;
	private var _btnGroup:ToggleButtonGroup = null;
	
	public function CommandGroup(p_parent:IContainer)
	{
		super(p_parent);
	}
	
	public override function dispose():void
	{
		Helper.dispose(this._btnGroup);
		this._btnGroup = null;
		super.dispose();
	}
	
	protected override function init():void
	{
		super.init();
		
		var cellSkin:CellSkin = GameAsset.loader.getAsset(GameConfig.ASSET_KEY_CMD_CELL) as CellSkin;
		var list:Array = [];
		list.push({title: "Move", x: 0, y: 0, command: GameData.COMMAND_ROAD, side: GameData.SIDE_A, state: GameData.STATE_ROAD});
		list.push({title: "Move", x: 1, y: 0, command: GameData.COMMAND_ROAD, side: GameData.SIDE_B, state: GameData.STATE_ROAD});
		list.push({title: "Move", x: 2, y: 0, command: GameData.COMMAND_ROAD, side: GameData.SIDE_C, state: GameData.STATE_ROAD});
		list.push({title: "Jump", x: 0, y: 1, command: GameData.COMMAND_ROAD_EX, side: GameData.SIDE_A, state: GameData.STATE_ROAD_EX});
		list.push({title: "Jump", x: 1, y: 1, command: GameData.COMMAND_ROAD_EX, side: GameData.SIDE_B, state: GameData.STATE_ROAD_EX});
		list.push({title: "Jump", x: 2, y: 1, command: GameData.COMMAND_ROAD_EX, side: GameData.SIDE_C, state: GameData.STATE_ROAD_EX});
		list.push({title: "Atk", x: 0, y: 2, command: GameData.COMMAND_ATTACK, side: GameData.SIDE_A, state: GameData.STATE_ATTACK});
		list.push({title: "Atk", x: 1, y: 2, command: GameData.COMMAND_ATTACK, side: GameData.SIDE_B, state: GameData.STATE_ATTACK});
		list.push({title: "Atk", x: 2, y: 2, command: GameData.COMMAND_ATTACK, side: GameData.SIDE_C, state: GameData.STATE_ATTACK});
		list.push({title: "Undo", x: 0, y: 3, command: GameData.COMMAND_UNDO, side: 0, state: GameData.STATE_NONE});
		list.push({title: "Clear", x: 1, y: 3, command: GameData.COMMAND_CLEAR, side: 0, state: GameData.STATE_NONE});
		list.push({title: "Save", x: 2, y: 3, command: GameData.COMMAND_SAVE, side: 0, state: GameData.STATE_NONE});
		list.push({title: "0", x: 0, y: 4, command: GameData.COMMAND_NONE, side: GameData.SIDE_A, state: GameData.STATE_HOSTAGE_BG, score: GameData.SIDE_A});
		list.push({title: "0", x: 1, y: 4, command: GameData.COMMAND_NONE, side: GameData.SIDE_B, state: GameData.STATE_HOSTAGE_BG, score: GameData.SIDE_B});
		list.push({title: "0", x: 2, y: 4, command: GameData.COMMAND_NONE, side: GameData.SIDE_C, state: GameData.STATE_HOSTAGE_BG, score: GameData.SIDE_C});
		
		this._btnGroup = new ToggleButtonGroup();
		this._btnGroup.signal.add(this.onToggle);
		
		for (var i:int = 0; i < list.length; i++)
		{
			var item:Object = list[i];
			var title:String = item.title;
			var command:int = item.command;
			var side:int = item.side;
			var state:int = item.state;
			var posX:int = item.x;
			var posY:int = item.y;
			var btn:CommandHexagonToggle = new CommandHexagonToggle(title, GameConfig.FONT_SIZE_CMD, GameConfig.ASSET_KEY_CMD_CELL, {command: command, side: side});
			btn.instance.x = posX * cellSkin.width;
			btn.instance.y = posY * cellSkin.height;
			btn.setState(side, state);
			this._btnGroup.addButton(btn);
			this.addChild(btn);
			
			if (item.score)
			{
				var score:int = item.score;
				switch (score)
				{
				case GameData.SIDE_A: 
					this._btnScoreA = btn;
					break;
				case GameData.SIDE_B: 
					this._btnScoreB = btn;
					break;
				case GameData.SIDE_C: 
					this._btnScoreC = btn;
					break;
				default: 
					;
				}
			}
		}
	}
	
	public override function clear():void
	{
		super.clear();
		//	this._btnGroup.clear();
	}
	
	public override function reset():void
	{
		super.reset();
		this._btnGroup.reset();
	}
	
	public function get command():int
	{
		var data:Object = this._btnGroup.data;
		if (!data)
		{
			return 0;
		}
		return data.command as int;
	}
	
	public function get side():int
	{
		var data:Object = this._btnGroup.data;
		if (!data)
		{
			return 0;
		}
		return data.side as int;
	}
	
	public function setScore(p_side:int, p_score:int):void
	{
		switch (p_side)
		{
		case GameData.SIDE_A: 
			this._btnScoreA.text = String(p_score);
			break;
		case GameData.SIDE_B: 
			this._btnScoreB.text = String(p_score);
			break;
		case GameData.SIDE_C: 
			this._btnScoreC.text = String(p_score);
			break;
		default: 
			;
		}
	}
	
	private function onToggle(p_result:Object):void
	{
		var target:CommandHexagonToggle = p_result.target as CommandHexagonToggle;
		var data:Object = target.data;
		var command:int = data.command as int;
		if (command == GameData.COMMAND_UNDO || command == GameData.COMMAND_CLEAR || command == GameData.COMMAND_SAVE || command == GameData.COMMAND_NONE)
		{
			this._btnGroup.reset();
		}
		this._signal.dispatch(data);
	}

}

class ButtonHexagonGroup extends BasicContainer
{
	private var _idList:Array = null;
	private var _mapBtn:Object = null;
	
	public function ButtonHexagonGroup(p_parent:IContainer)
	{
		super(p_parent);
	}
	
	public override function dispose():void
	{
		super.dispose();
	}
	
	protected override function init():void
	{
		super.init();
	}
	
	public override function reset():void
	{
		super.reset();
	}
	
	public function createMap(p_list:Array):void
	{
		this._idList = [];
		this._mapBtn = {};
		
		var cellSkin:CellSkin = GameAsset.loader.getAsset(GameConfig.ASSET_KEY_MAP_CELL) as CellSkin;
		
		for (var i:int = 0; i < p_list.length; i++)
		{
			var data:MapCell = p_list[i] as MapCell;
			var btn:ButtonHexagon = new ButtonHexagon("" + data.id, GameConfig.FONT_SIZE_MAP, GameConfig.ASSET_KEY_MAP_CELL, data);
			this._idList.push(data.id);
			this._mapBtn[data.id] = btn;
			btn.instance.x = data.posX * int(cellSkin.width * 0.75);
			btn.instance.y = data.posY * int(cellSkin.height * 0.5);
			btn.signal.add(this.onSignal);
			btn.setState(data.side, data.state);
			this.addChild(btn);
		}
	}
	
	public function flashClear():void
	{
		for (var i:int = 0; i < this._idList.length; i++)
		{
			var btn:ButtonHexagon = this._mapBtn[this._idList[i]] as ButtonHexagon;
			btn.flash(false, 0, 0);
		}
	}
	
	public function flash(p_side:int, p_state:int, p_list:Array):void
	{
		this.flashClear();
		for (var i:int = 0; i < p_list.length; i++)
		{
			var btn:ButtonHexagon = this._mapBtn[p_list[i]] as ButtonHexagon;
			btn.flash(true, p_side, p_state);
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
		if (action == AbstractButton.ACTION_UP)
		{
			this.signal.dispatch(p_result.data);
		}
	}

}