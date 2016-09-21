package com.pj
{
	import com.pj.common.Helper;
	import com.pj.common.component.AbstractButton;
	import com.pj.common.component.BasicContainer;
	import com.pj.common.component.JBackground;
	import com.pj.common.component.SimpleButton;
	import com.pj.common.component.SimpleToggleButton;
	import com.pj.common.component.Slider;
	import com.pj.common.component.ToggleButtonGroup;
	import com.pj.macross.GameAsset;
	import com.pj.macross.GameConfig;
	import com.pj.macross.GameData;
	import com.pj.macross.GameModel;
	import com.pj.macross.structure.MapCell;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class ProjectMacross extends BasicContainer
	{
		private var _bg:JBackground = null;
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
			Helper.dispose(this._bg);
			Helper.dispose(this._map);
			Helper.dispose(this._model);
			Helper.dispose(this._tgCommand);
			Helper.dispose(this._tgSide);
			Helper.dispose(this._slider);
			this._bg = null;
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
			GameAsset.loader.signal.add(this.onAssetLoaded);
			GameAsset.loader.load();
		}
		
		override public function reset():void
		{
			super.reset();
		}
		
		override public function resize(p_width:int, p_height:int):void
		{
			this._bg.resize(p_width, p_height);
			this._slider.resize(p_width, p_height);
		}
		
		private function onAssetLoaded(p_result:Object):void
		{
			var SIDE_LIST:Array = [ //
			{label: "Red", data: {side: GameData.SIDE_A}} //
			, {label: "Green", data: {side: GameData.SIDE_B}} //
			, {label: "Blue", data: {side: GameData.SIDE_C}} //
			];
			
			var COMMAND_LIST:Array = [ //
			{label: "Road", data: {command: GameData.COMMAND_ROAD}} //
			, {label: "RoadEx", data: {command: GameData.COMMAND_ROAD_EX}} //
			, {label: "Attack", data: {command: GameData.COMMAND_ATTACK}} //
			];
			
			this._model = new GameModel();
			
			this._bg = new JBackground((GameAsset.loader.getAsset("galaxy") as Bitmap).bitmapData);
			this._bg.resize(this.instance.stage.stageWidth, this.instance.stage.stageHeight);
			this.addChild(this._bg);
			
			var totalWidth:int = (GameConfig.MAP_RADIUS * 6 - 3) * GameConfig.BTN_RADIUS;
			this._slider = new Slider(this, this.instance.stage.stageWidth, this.instance.stage.stageHeight, totalWidth, totalWidth);
			
			var btnToggle:SimpleToggleButton = null;
			var item:Object = null;
			var i:int = 0;
			var posY:int = 0;
			
			this._tgSide = new ToggleButtonGroup();
			for (i = 0; i < SIDE_LIST.length; i++)
			{
				item = SIDE_LIST[i];
				btnToggle = new SimpleToggleButton(item.label, GameConfig.CTRL_BTN_WIDTH / 3, GameConfig.CTRL_BTN_HEIGHT, item.data);
				btnToggle.instance.x = GameConfig.CTRL_BTN_WIDTH / 3 * i;
				btnToggle.instance.y = posY;
				this._tgSide.addButton(btnToggle);
				this.addChild(btnToggle);
			}
			posY += GameConfig.CTRL_BTN_HEIGHT;
			
			this._tgCommand = new ToggleButtonGroup();
			for (i = 0; i < COMMAND_LIST.length; i++)
			{
				item = COMMAND_LIST[i];
				btnToggle = new SimpleToggleButton(item.label, GameConfig.CTRL_BTN_WIDTH, GameConfig.CTRL_BTN_HEIGHT, item.data);
				btnToggle.instance.x = 0;
				btnToggle.instance.y = posY;
				this._tgCommand.addButton(btnToggle);
				this.addChild(btnToggle);
				posY += GameConfig.CTRL_BTN_HEIGHT;
			}
			
			var btn:SimpleButton = null;
			btn = new SimpleButton("Undo", GameConfig.CTRL_BTN_WIDTH, GameConfig.CTRL_BTN_HEIGHT);
			btn.instance.x = 0;
			btn.instance.y = posY;
			btn.signal.add(function(p_result:Object):void
			{
				var action:String = p_result.action;
				if (action != AbstractButton.ACTION_UP)
				{
					return;
				}
				var dataState:Object = _model.undo();
				if (!dataState)
				{
					return;
				}
				_map.setState(dataState.id, dataState.side, dataState.state);
			});
			this.addChild(btn);
			posY += GameConfig.CTRL_BTN_HEIGHT;
			
			btn = new SimpleButton("Clear", GameConfig.CTRL_BTN_WIDTH, GameConfig.CTRL_BTN_HEIGHT);
			btn.instance.x = 0;
			btn.instance.y = posY;
			btn.signal.add(function(p_result:Object):void
			{
				var action:String = p_result.action;
				if (action != AbstractButton.ACTION_UP)
				{
					return;
				}
				var dataState:Object = {};
				while (dataState)
				{
					dataState = _model.undo();
					if (!dataState)
					{
						return;
					}
					_map.setState(dataState.id, dataState.side, dataState.state);
				}
			});
			this.addChild(btn);
			posY += GameConfig.CTRL_BTN_HEIGHT;
			
			btn = new SimpleButton("Capture", GameConfig.CTRL_BTN_WIDTH, GameConfig.CTRL_BTN_HEIGHT);
			btn.instance.x = 0;
			btn.instance.y = posY;
			btn.signal.add(function(p_result:Object):void
			{
				var action:String = p_result.action;
				if (action == AbstractButton.ACTION_CLICK)
				{
					_slider.saveCapture(GameConfig.DEFAULT_PNG);
				}
			});
			this.addChild(btn);
			posY += GameConfig.CTRL_BTN_HEIGHT;
			
			this._map = new ButtonHexagonGroup(this._slider);
			this._map.createMap(this._model.getCellList());
			this._map.signal.add(this.onMapSignal);
		}
		
		private function onMapSignal(p_result:Object):void
		{
			var dataCell:MapCell = p_result as MapCell;
			var dataCommand:Object = this._tgCommand.data;
			var dataSide:Object = this._tgSide.data;
			if (!dataCommand)
			{
				return;
			}
			if (!dataSide)
			{
				return;
			}
			
			var command:int = dataCommand.command;
			var side:int = dataSide.side;
			var dataState:Object = this._model.command(dataCell.id, side, command);
			if (dataState)
			{
				this._map.setState(dataState.id, dataState.side, dataState.state);
			}
		}
	
	}
}

import com.pj.common.component.AbstractButton;
import com.pj.common.component.BasicButton;
import com.pj.common.component.BasicButtonFace;
import com.pj.common.component.BasicContainer;
import com.pj.common.component.IContainer;
import com.pj.macross.GameAsset;
import com.pj.macross.GameConfig;
import com.pj.macross.GameData;
import com.pj.macross.asset.CellSkin;
import com.pj.macross.structure.MapCell;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.TimerEvent;
import flash.text.TextFormat;
import flash.utils.Timer;

class ButtonHexagonFace extends BasicButtonFace
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
	static public const FACE_HOSTAGE:int = 10;
	static public const FACE_OBSTACLE:int = 11;
	
	private var _imgBase0:Bitmap = null;
	private var _imgBase1:Bitmap = null;
	private var _imgBase2:Bitmap = null;
	private var _imgRoad0:Bitmap = null;
	private var _imgRoad1:Bitmap = null;
	private var _imgRoad2:Bitmap = null;
	private var _imgFold:Sprite = null;
	private var _imgHostage:Bitmap = null;
	private var _imgObstacle:Bitmap = null;
	
	private var _timer:Timer = null;
	private var _timeVal:Number = 0;
	
	private var _mapImage:Object = null;
	
	public function ButtonHexagonFace( //
	p_bmpBase0:BitmapData//
	, p_bmpBase1:BitmapData//
	, p_bmpBase2:BitmapData//
	, p_bmpRoad0:BitmapData//
	, p_bmpRoad1:BitmapData//
	, p_bmpRoad2:BitmapData//
	, p_bmpFold:BitmapData//
	, p_bmpHostage:BitmapData//
	, p_bmpObstacle:BitmapData//
	)
	{
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
		this._imgHostage = new Bitmap(p_bmpHostage);
		this._imgObstacle = new Bitmap(p_bmpObstacle);
		super();
	}
	
	override public function dispose():void
	{
		if (this._timer)
		{
			this._timer.stop();
			this._timer.removeEventListener(TimerEvent.TIMER, this.onTime);
			this._timer = null;
		}
		this._imgBase0 = null;
		this._imgBase1 = null;
		this._imgBase2 = null;
		this._imgRoad0 = null;
		this._imgRoad1 = null;
		this._imgRoad2 = null;
		this._imgFold = null;
		this._imgHostage = null;
		this._imgObstacle = null;
		this._mapImage = null;
		super.dispose();
	}
	
	override protected function init():void
	{
		super.init();
		this.container.addChild(this._imgBase0);
		this.container.addChild(this._imgBase1);
		this.container.addChild(this._imgBase2);
		this.container.addChild(this._imgRoad0);
		this.container.addChild(this._imgRoad1);
		this.container.addChild(this._imgRoad2);
		this.container.addChild(this._imgFold);
		this.container.addChild(this._imgHostage);
		this.container.addChild(this._imgObstacle);
		
		this._mapImage = {};
		this._mapImage[FACE_BASE_0] = this._imgBase0;
		this._mapImage[FACE_BASE_1] = this._imgBase1;
		this._mapImage[FACE_BASE_2] = this._imgBase2;
		this._mapImage[FACE_ROAD_0] = this._imgRoad0;
		this._mapImage[FACE_ROAD_1] = this._imgRoad1;
		this._mapImage[FACE_ROAD_2] = this._imgRoad2;
		this._mapImage[FACE_HOSTAGE] = this._imgHostage;
		this._mapImage[FACE_OBSTACLE] = this._imgObstacle;
		
		this._timer = new Timer(20);
		this._timer.addEventListener(TimerEvent.TIMER, this.onTime);
	}
	
	override public function reset():void
	{
		super.reset();
		this._timer.stop();
		this._timeVal = 0;
		this.setFace(FACE_BLANK);
	}
	
	private function onTime(p_evt:TimerEvent):void
	{
		this._timeVal += 0.01;
		if (this._timeVal > 1)
		{
			this._timeVal -= 1;
		}
		if (this._imgFold.visible)
		{
			this._imgFold.rotation = 360 * this._timeVal;
		}
	}
	
	public function setFace(p_id:int):void
	{
		var realId:int = p_id;
		if (p_id == FACE_ROAD_EX_0)
		{
			realId = FACE_ROAD_0;
		}
		if (p_id == FACE_ROAD_EX_1)
		{
			realId = FACE_ROAD_1;
		}
		if (p_id == FACE_ROAD_EX_2)
		{
			realId = FACE_ROAD_2;
		}
		
		var img:DisplayObject = this._mapImage[realId] as DisplayObject;
		this.showImage(img);
		this._imgFold.visible = (realId != p_id);
		if (this._imgFold.visible)
		{
			this._timer.start();
		}
		else
		{
			this._timer.stop();
			this._timeVal = 0;
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
	, p_faceDown:BasicButtonFace //
	, p_faceFront:ButtonHexagonFace //
	, p_faceIdle:BasicButtonFace //
	, p_faceOver:BasicButtonFace //
	, p_data:Object = null //
	)
	{
		this._fontSize = p_fontSize;
		super(p_title, p_width, p_height, p_faceDown, p_faceFront, p_faceIdle, p_faceOver, p_data, ALIGN_BOTTON);
	}
	
	override protected function init():void
	{
		super.init();
		
		var format:TextFormat = new TextFormat();
		format.size = this._fontSize;
		this._txtTitle.defaultTextFormat = format;
		this._txtTitle.visible = true;
	}
	
	public function setState(p_side:int, p_state:int):void
	{
		var face:ButtonHexagonFace = this.faceFront as ButtonHexagonFace;
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
		case GameData.STATE_HOSTAGE: 
			face.setFace(ButtonHexagonFace.FACE_HOSTAGE);
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

class ButtonHexagonGroup extends BasicContainer
{
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
		this._mapBtn = {};
		
		var cellSkin:CellSkin = GameAsset.loader.getAsset("cellSkin") as CellSkin;
		
		for (var i:int = 0; i < p_list.length; i++)
		{
			var data:MapCell = p_list[i] as MapCell;
			var faceFront:ButtonHexagonFace = new ButtonHexagonFace( //
			cellSkin.getBitmap(CellSkin.IMG_BASE_0)//
			, cellSkin.getBitmap(CellSkin.IMG_BASE_1)//
			, cellSkin.getBitmap(CellSkin.IMG_BASE_2)//
			, cellSkin.getBitmap(CellSkin.IMG_ROAD_0)//
			, cellSkin.getBitmap(CellSkin.IMG_ROAD_1)//
			, cellSkin.getBitmap(CellSkin.IMG_ROAD_2)//
			, cellSkin.getBitmap(CellSkin.IMG_FOLD)//
			, cellSkin.getBitmap(CellSkin.IMG_HOSTAGE)//
			, cellSkin.getBitmap(CellSkin.IMG_OBSTACLE)//
			);
			var btn:ButtonHexagon = new ButtonHexagon( //
			"" + data.id //
			, cellSkin.width //
			, cellSkin.height //
			, GameConfig.FONT_SIZE //
			, new BasicButtonFace(cellSkin.getBitmap(CellSkin.IMG_DOWN)) //
			, faceFront //
			, new BasicButtonFace(cellSkin.getBitmap(CellSkin.IMG_BLANK)) //
			, new BasicButtonFace(cellSkin.getBitmap(CellSkin.IMG_OVER)) //
			, data //
			);
			this._mapBtn[data.id] = btn;
			btn.instance.x = data.posX * int(cellSkin.width * 0.75);
			btn.instance.y = data.posY * int(cellSkin.height * 0.5);
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
		if (action == AbstractButton.ACTION_UP)
		{
			this.signal.dispatch(p_result.data);
		}
	}

}