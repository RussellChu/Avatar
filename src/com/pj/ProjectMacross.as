package com.pj
{
	import com.pj.common.AssetLoader;
	import com.pj.common.Helper;
	import com.pj.common.component.AbstractButton;
	import com.pj.common.component.BasicContainer;
	import com.pj.common.component.SimpleButton;
	import com.pj.common.component.SimpleToggleButton;
	import com.pj.common.component.Slider;
	import com.pj.common.component.ToggleButtonGroup;
	import com.pj.common.component.JBackground;
	import com.pj.macross.GameAsset;
	import com.pj.macross.GameConfig;
	import com.pj.macross.GameData;
	import com.pj.macross.GameModel;
	import com.pj.macross.structure.MapCell;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.net.FileReference;
	
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
			, {label: "(Test) Hostage", data: {command: GameData.COMMAND_TEST_HOSTAGE}, testOnly: true} //
			, {label: "(Test) Obstacle", data: {command: GameData.COMMAND_TEST_OBSTACLE}, testOnly: true} //
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
				if (item.testOnly && !GameConfig.TESTING_MODE)
				{
					continue;
				}
				btnToggle = new SimpleToggleButton(item.label, GameConfig.CTRL_BTN_WIDTH, GameConfig.CTRL_BTN_HEIGHT, item.data);
				btnToggle.instance.x = 0;
				btnToggle.instance.y = posY;
				this._tgCommand.addButton(btnToggle);
				this.addChild(btnToggle);
				posY += GameConfig.CTRL_BTN_HEIGHT;
			}
			
			if (GameConfig.TESTING_MODE)
			{
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
			}
			
			this._map = new ButtonHexagonGroup(this._slider, GameConfig.BTN_RADIUS, GameConfig.BTN_SIDE, GameConfig.FONT_SIZE);
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
			var command:int = dataCommand.command;
			var side:int = 0;
			
			switch (command)
			{
			case GameData.COMMAND_TEST_HOSTAGE: 
			case GameData.COMMAND_TEST_OBSTACLE: 
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
		}
	
	}
}

import com.pj.common.AssetLoader;
import com.pj.common.JColor;
import com.pj.common.component.AbstractButton;
import com.pj.common.component.BasicButton;
import com.pj.common.component.BasicButtonFace;
import com.pj.common.component.BasicContainer;
import com.pj.common.component.IContainer;
import com.pj.macross.GameAsset;
import com.pj.macross.GameConfig;
import com.pj.macross.GameData;
import com.pj.macross.structure.MapCell;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.TimerEvent;
import flash.geom.Matrix;
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
		
		this._txtTitle.visible = false;
		
		if (GameConfig.TESTING_MODE)
		{
			var format:TextFormat = new TextFormat();
			format.size = this._fontSize;
			this._txtTitle.defaultTextFormat = format;
			this._txtTitle.visible = true;
		}
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
	
	public function ButtonHexagonGroup(p_parent:IContainer, p_valBtnRadius:Number, p_valSide:Number, p_valFontSize:int)
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
		
		var colorDown:uint = new JColor(0, 1, 1, 0.5).value;
		var colorIdle:uint = new JColor(0.5, 0.5, 0.5, 0.5).value;
		var colorOver:uint = new JColor(1, 1, 0, 0.5).value;
		var colorBase0:uint = new JColor(1, 0.411, 0.411, 1).value;
		var colorBase1:uint = new JColor(0, 1, 0, 1).value;
		var colorBase2:uint = new JColor(0.534, 0.534, 1, 1).value;
		var colorRoad0:uint = new JColor(1, 0, 0, 1).value;
		var colorRoad1:uint = new JColor(0, 0.509, 0, 1).value;
		var colorRoad2:uint = new JColor(0.209, 0.209, 1, 1).value;
		var colorHostage:uint = new JColor(0.967, 0.673, 0.9055, 0.5).value;
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
		
		var v0:Number = 0;
		var v1:Number = 0;
		var v2:Number = 0;
		var v3:Number = 0;
		var v4:Number = 0;
		
		var funcHex:Function = function(p_d:Number):Boolean
		{
			var r:Number = p_d * _valBtnW * 4;
			var b0:Boolean = (v0 > r);
			var b1:Boolean = (v1 < -r);
			var b2:Boolean = (v2 < -r);
			var b3:Boolean = (v3 > r);
			var b4:Boolean = v4 >= p_d && v4 < _valBtnH - p_d;
			return b0 && b1 && b2 && b3 && b4;
		}
		
		for (var i:int = 0; i < this._valBtnW; i++)
		{
			for (var j:int = 0; j < this._valBtnH; j++)
			{
				v0 = 4 * this._valBtnH * i + 2 * this._valBtnW * j - this._valBtnW * this._valBtnH;
				v1 = -4 * this._valBtnH * i + 2 * this._valBtnW * j - this._valBtnW * this._valBtnH;
				v2 = 4 * this._valBtnH * i + 2 * this._valBtnW * j - 5 * this._valBtnW * this._valBtnH;
				v3 = -4 * this._valBtnH * i + 2 * this._valBtnW * j + 3 * this._valBtnW * this._valBtnH;
				v4 = j;
				
				if (funcHex(this._valSide))
				{
					this._bmpDown.setPixel32(i, j, colorDown);
					this._bmpIdle.setPixel32(i, j, colorIdle);
					this._bmpOver.setPixel32(i, j, colorOver);
					this._bmpIdleBase0.setPixel32(i, j, colorBase0);
					this._bmpIdleBase1.setPixel32(i, j, colorBase1);
					this._bmpIdleBase2.setPixel32(i, j, colorBase2);
					this._bmpIdleObstacle.setPixel32(i, j, colorObstacle);
				}
				
				if (funcHex(this._valBtnH * 0.1875))
				{
					this._bmpIdleRoad0.setPixel32(i, j, colorRoad0);
					this._bmpIdleRoad1.setPixel32(i, j, colorRoad1);
					this._bmpIdleRoad2.setPixel32(i, j, colorRoad2);
				}
				
				// var a:Number = this._valBtnW * 0.2; // max
				var a:Number = this._valBtnW * 0.1;
				var k:int = 0;
				var s:int = 6;
				var sum:int = 0;
				for (k = 0; k < s; k++)
				{
					sum += ((Math.cos(Math.PI * (2 / s * k - 0.5)) * (i - this._valBtnW * 0.5) + Math.sin(Math.PI * (2 / s * k - 0.5)) * (j - this._valBtnH * 0.5) < a) ? 1 : 0);
				}
				if (sum == s - 1)
				{
					this._bmpIdleRoad0.setPixel32(i, j, colorBase0);
					this._bmpIdleRoad1.setPixel32(i, j, colorBase1);
					this._bmpIdleRoad2.setPixel32(i, j, colorBase2);
				}
				
				a = this._valBtnW * 0.2;
				sum = 0;
				for (k = 0; k < s; k++)
				{
					sum += ((Math.cos(Math.PI * (2 / s * k)) * (i - this._valBtnW * 0.5) + Math.sin(Math.PI * (2 / s * k)) * (j - this._valBtnH * 0.5) < a) ? 1 : 0);
				}
				if (sum == s - 1)
				{
					this._bmpIdleHostage.setPixel32(i, j, colorHostage);
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
		var i:int = 0;
		
		this._mapBtn = {};
		
		var hostageList:Array = [];
		hostageList.push({key: "s01", bmp: null});
		hostageList.push({key: "s02", bmp: null});
		hostageList.push({key: "s03", bmp: null});
		hostageList.push({key: "s04", bmp: null});
		hostageList.push({key: "s05", bmp: null});
		hostageList.push({key: "s06", bmp: null});
		hostageList.push({key: "s07", bmp: null});
		hostageList.push({key: "s08", bmp: null});
		
		var ratio:Number = 0;
		var mx:Matrix = null;
		
		for (i = 0; i < hostageList.length; i++)
		{
			var hostage:Bitmap = GameAsset.loader.getAsset(hostageList[i].key) as Bitmap;
			var bmpHostage:BitmapData = new BitmapData(this._valBtnW, this._valBtnH, true, 0);
			ratio = this._valBtnH / hostage.height;
			mx = new Matrix();
			mx.scale(ratio, ratio);
			mx.translate((this._valBtnW - hostage.width * this._valBtnH / hostage.height) * 0.5, 0);
			bmpHostage.lock();
			bmpHostage.draw(this._bmpIdleHostage);
			bmpHostage.draw(hostage.bitmapData, mx);
			bmpHostage.unlock();
			hostageList[i].bmp = bmpHostage;
		}
		
		var imgFold:Bitmap = GameAsset.loader.getAsset("fold") as Bitmap;
		var bmpFold:BitmapData = new BitmapData(this._valBtnW, this._valBtnH, true, 0);
		ratio = this._valBtnH / imgFold.height;
		mx = new Matrix();
		mx.scale(ratio, ratio);
		mx.translate((this._valBtnW - imgFold.width * this._valBtnH / imgFold.height) * 0.5, 0);
		bmpFold.lock();
		bmpFold.draw(imgFold.bitmapData, mx);
		bmpFold.unlock();
		
		for (i = 0; i < p_list.length; i++)
		{
			var data:MapCell = p_list[i] as MapCell;
			var faceFront:ButtonHexagonFace = new ButtonHexagonFace( //
			this._bmpIdleBase0//
			, this._bmpIdleBase1//
			, this._bmpIdleBase2//
			, this._bmpIdleRoad0//
			, this._bmpIdleRoad1//
			, this._bmpIdleRoad2//
			, bmpFold//
			//, this._bmpIdleHostage//
			, hostageList[int(Math.random() * hostageList.length)].bmp//
			, this._bmpIdleObstacle//
			);
			var btn:ButtonHexagon = new ButtonHexagon( //
			"" + data.id //
			// "" + data.keyX + ":" + data.keyY + ":" + data.keyZ //
			, this._valBtnW //
			, this._valBtnH //
			, this._valFontSize //
			, new BasicButtonFace(this._bmpDown) //
			, faceFront //
			, new BasicButtonFace(this._bmpIdle) //
			, new BasicButtonFace(this._bmpOver) //
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
		if (action == AbstractButton.ACTION_UP)
		{
			this.signal.dispatch(p_result.data);
		}
	}

}