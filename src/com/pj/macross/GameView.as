package com.pj.macross
{
	import com.pj.common.Helper;
	import com.pj.common.component.BasicContainer;
	import com.pj.common.component.BasicObject;
	import com.pj.common.component.Slider;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class GameView extends BasicContainer
	{
		static public const EVENT_CMD_CLICK:String = "EVENT_CMD_CLICK";
		static public const EVENT_MAP_CLICK:String = "EVENT_MAP_CLICK";
		
		private var _bg:BasicContainer = null;
		private var _cmd:GameCommand = null;
		private var _cmdPlay:GameCommandPlay = null;
		private var _meteor:BasicObject = null;
		private var _map:GameMap = null;
		private var _mark:MarkBoard = null;
		private var _slider:Slider = null;
		private var _tips:TipsBoard = null;
		
		private var _cmdSide:int = 0;
		private var _cmdCode:int = 0;
		
		public function GameView()
		{
			super();
		}
		
		override public function dispose():void
		{
			Helper.dispose(this._bg);
			Helper.dispose(this._cmd);
			Helper.dispose(this._cmdPlay);
			Helper.dispose(this._meteor);
			Helper.dispose(this._map);
			Helper.dispose(this._mark);
			Helper.dispose(this._slider);
			this._bg = null;
			this._cmd = null;
			this._cmdPlay = null;
			this._meteor = null;
			this._map = null;
			this._mark = null;
			this._slider = null;
			super.dispose();
		}
		
		override protected function init():void
		{
			super.init();
			
			this._bg = GameAsset.loader.getAsset(GameAsset.KEY_GALAXY) as BasicContainer;
			this.addChild(this._bg);
			
			//this._meteor = GameAsset.loader.getAsset(GameAsset.KEY_METEOR) as BasicObject;
			//this.addChild(this._meteor);
			
			this._map = new GameMap();
			this._map.signal.add(this.onMapClick, GameMap.ACTION_CLICK);
			this._mark = new MarkBoard();
		}
		
		public function capMap(p_name:String):void
		{
			this._slider.saveCapture(p_name + ".png");
		}
		
		public function createMap(p_list:Array):void
		{
			this._map.create(p_list);
			
			if (!this._slider)
			{
				this._slider = new Slider(this, 0, 0, this._map.width, this._map.height, false);
				this._slider.addChild(this._map);
				this.addChild(this._slider);
				this.addChild(this._mark);
				
				this._cmd = new GameCommand();
				this._cmd.signal.add(this.onCmdClick, GameCommand.ACTION_CLICK);
				this.addChild(this._cmd);
				
				this._cmdPlay = new GameCommandPlay();
				this._cmdPlay.signal.add(this.onCmdClick, GameCommand.ACTION_CLICK);
				this._cmdPlay.instance.visible = false;
				this.addChild(this._cmdPlay);
				
				this._tips = new TipsBoard();
				this.addChild(this._tips);
				this._tips.showMsg(TipsBoard.MSG_START_01);
			}
		}
		
		public function flashMap(p_side:int, p_state:int, p_list:Array):void
		{
			this._map.clearCellFlash();
			for (var i:int = 0; i < p_list.length; i++)
			{
				var id:String = String(p_list[i]);
				this._map.setCellFlash(id, p_side, p_state);
			}
		}
		
		public function changeCmd(p_state:int):void
		{
			if (p_state == 0)
			{
				this._cmdPlay.instance.visible = false;
				this._cmd.instance.visible = true;
				return;
			}
			this._cmdPlay.instance.visible = true;
			this._cmd.instance.visible = false;
			this._cmdPlay.openList();
		}
		
		public function updateCmd(p_side:int, p_atk:int, p_jmp:int, p_mov:int):void
		{
			if (p_side != GameData.SIDE_A)
			{
				return;
			}
			this._cmdPlay.updateCmd(p_atk, p_jmp, p_mov);
		}
		
		public function updateMap(p_id:String, p_side:int, p_state:int):void
		{
			this._map.setCell(p_id, p_side, p_state);
			GameController.i.signal.dispatch({side: this._cmdSide, command: this._cmdCode}, EVENT_CMD_CLICK);
		}
		
		public function updateScore(p_side:int, p_score:int):void
		{
			this._mark.setScore(p_side, p_score);
		}
		
		override public function resize(p_width:int, p_height:int):void
		{
			this._bg.resize(p_width, p_height);
			this._slider.resize(p_width, p_height);
			
			var posX:int = (p_width - this._map.width) * 0.5;
			var posY:int = (p_height - this._map.height) * 0.5;
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
			
			posX = (p_width - this._tips.width) * 0.5;
			this._tips.instance.x = posX;
			
			//this._meteor.instance.x = p_width * 0.5;
			//this._meteor.instance.y = p_height * 0.5;
			this._mark.instance.x = p_width - this._mark.instance.width - 50;
		}
		
		private function onCmdClick(p_result:Object):void
		{
			var cmdCode:int = p_result.cmd;
			switch (cmdCode)
			{
			case GameData.COMMAND_OPEN: 
				this._tips.showMsg(TipsBoard.MSG_START_02);
				break;
			case GameData.COMMAND_ROAD: 
			case GameData.COMMAND_ROAD_EX: 
			case GameData.COMMAND_ATTACK: 
				switch (cmdCode)
				{
				case GameData.COMMAND_ROAD: 
					this._tips.showMsg(TipsBoard.MSG_CMD_MOVE);
					break;
				case GameData.COMMAND_ROAD_EX: 
					this._tips.showMsg(TipsBoard.MSG_CMD_JUMP);
					break;
				case GameData.COMMAND_ATTACK: 
					this._tips.showMsg(TipsBoard.MSG_CMD_ATK);
					break;
				}
				this._cmdSide = p_result.side;
				this._cmdCode = cmdCode;
				GameController.i.signal.dispatch({side: this._cmdSide, command: this._cmdCode}, EVENT_CMD_CLICK);
				break;
			case GameData.COMMAND_LANG: 
				var lang:String = p_result.lang;
				GameController.i.signal.dispatch({lang: lang}, GameLang.EVENT_SET_LANG);
				break;
			case GameData.COMMAND_TIPS: 
				this._tips.showMsg(TipsBoard.MSG_CMD_TIPS);
				break;
			case GameData.COMMAND_AUTO: 
				this._tips.showMsg(TipsBoard.MSG_CMD_AUTO);
				GameController.i.signal.dispatch({command: cmdCode}, EVENT_CMD_CLICK);
				break;
			case GameData.COMMAND_CLOSE: 
				GameController.i.signal.dispatch({command: cmdCode}, EVENT_CMD_CLICK);
				break;
			case GameData.COMMAND_PLAY: 
				this._tips.showMsg(TipsBoard.MSG_CMD_PLAY);
				GameController.i.signal.dispatch({command: cmdCode}, EVENT_CMD_CLICK);
				break;
			case GameData.COMMAND_PASS: 
				this._cmdSide = 0;
				GameController.i.signal.dispatch({side: this._cmdSide, command: this._cmdCode}, EVENT_CMD_CLICK);
				GameController.i.signal.dispatch({command: cmdCode}, EVENT_CMD_CLICK);
				break;
			case GameData.COMMAND_PRINT: 
				this._slider.saveCapture(GameConfig.getCapId());
				break;
			default: 
				GameController.i.signal.dispatch({command: cmdCode}, EVENT_CMD_CLICK);
			}
		}
		
		private function onMapClick(p_result:Object):void
		{
			var data:Object = p_result.data;
			var id:String = data.id;
			var side:int = data.side;
			var state:int = data.state;
			if (state == GameData.STATE_BASE)
			{
				if (this._cmdSide != side)
				{
					this._cmdSide = side;
					this._cmdCode = GameData.COMMAND_ROAD;
				}
				else if (this._cmdCode == GameData.COMMAND_ROAD)
				{
					this._cmdCode = GameData.COMMAND_ROAD_EX;
				}
				else if (this._cmdCode == GameData.COMMAND_ROAD_EX)
				{
					this._cmdCode = GameData.COMMAND_ATTACK;
				}
				else if (this._cmdCode == GameData.COMMAND_ATTACK)
				{
					this._cmdSide = 0;
				}
				GameController.i.signal.dispatch({side: this._cmdSide, command: this._cmdCode}, EVENT_CMD_CLICK);
			}
			else
			{
				GameController.i.signal.dispatch({id: id, side: this._cmdSide, command: this._cmdCode}, EVENT_MAP_CLICK);
			}
		}
	
	}
}

import com.pj.common.Helper;
import com.pj.common.JTimer;
import com.pj.common.JTweener;
import com.pj.common.component.AbstractButton;
import com.pj.common.component.BasicButton;
import com.pj.common.component.BasicContainer;
import com.pj.common.component.BasicImage;
import com.pj.common.component.BasicObject;
import com.pj.common.component.BasicSkin;
import com.pj.common.component.JText;
import com.pj.common.component.SimpleSkin;
import com.pj.common.math.JMath;
import com.pj.macross.GameAsset;
import com.pj.macross.GameConfig;
import com.pj.macross.GameController;
import com.pj.macross.GameData;
import com.pj.macross.GameLang;
import com.pj.macross.structure.MapCell;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.filters.GlowFilter;
import flash.text.TextField;

class SkinStoreItem extends BasicSkin
{
	private var _skin:BasicObject = null;
	private var _store:SkinStore = null;
	private var _type:int = 0;
	
	public function SkinStoreItem()
	{
		this._type = SkinStore.TYPE_NONE;
		super();
	}
	
	override public function dispose():void
	{
		this.show(SkinStore.TYPE_NONE);
		this._skin = null;
		this._store = null;
		this._skin = null;
		super.dispose();
	}
	
	override protected function init():void
	{
		super.init();
		this._store = new SkinStore();
	}
	
	override public function reset():void
	{
		super.reset();
		this.show(SkinStore.TYPE_NONE);
	}
	
	override public function show(p_id:int):void
	{
		if (p_id == this._type)
		{
			return;
		}
		
		this.container.removeChildren();
		this._store.payBack(this._type, this._skin);
		this._type = SkinStore.TYPE_NONE;
		this._skin = null;
		
		if (p_id == SkinStore.TYPE_NONE)
		{
			return;
		}
		
		this._type = p_id;
		this._skin = this._store.borrow(this._type);
		if (!this._skin)
		{
			this._type = SkinStore.TYPE_NONE;
			return;
		}
		
		this.container.addChild(this._skin.instance);
	}

}

class SkinStore
{
	static public const TYPE_NONE:int = -1;
	static public const TYPE_BLANK:int = 0;
	static public const TYPE_BASE_0:int = 1;
	static public const TYPE_BASE_1:int = 2;
	static public const TYPE_BASE_2:int = 3;
	static public const TYPE_ROAD_0:int = 4;
	static public const TYPE_ROAD_1:int = 5;
	static public const TYPE_ROAD_2:int = 6;
	static public const TYPE_ROAD_EX_0:int = 7;
	static public const TYPE_ROAD_EX_1:int = 8;
	static public const TYPE_ROAD_EX_2:int = 9;
	static public const TYPE_ATTACK:int = 10;
	static public const TYPE_HOSTAGE_0:int = 11;
	static public const TYPE_HOSTAGE_1:int = 12;
	static public const TYPE_HOSTAGE_2:int = 13;
	static public const TYPE_OBSTACLE:int = 14;
	static public const TYPE_HOSTAGE_BG_0:int = 15;
	static public const TYPE_HOSTAGE_BG_1:int = 16;
	static public const TYPE_HOSTAGE_BG_2:int = 17;
	static public const TYPE_OVER:int = 18;
	static public const TYPE_DOWN:int = 19;
	static public const TYPE_LIGHT:int = 20;
	
	static private var __map:Object = null;
	
	public function SkinStore()
	{
		if (!__map)
		{
			__map = {};
			__map[String(TYPE_BLANK)] = [];
			__map[String(TYPE_BASE_0)] = [];
			__map[String(TYPE_BASE_1)] = [];
			__map[String(TYPE_BASE_2)] = [];
			__map[String(TYPE_ROAD_0)] = [];
			__map[String(TYPE_ROAD_1)] = [];
			__map[String(TYPE_ROAD_2)] = [];
			__map[String(TYPE_ROAD_EX_0)] = [];
			__map[String(TYPE_ROAD_EX_1)] = [];
			__map[String(TYPE_ROAD_EX_2)] = [];
			__map[String(TYPE_ATTACK)] = [];
			__map[String(TYPE_HOSTAGE_0)] = [];
			__map[String(TYPE_HOSTAGE_1)] = [];
			__map[String(TYPE_HOSTAGE_2)] = [];
			__map[String(TYPE_OBSTACLE)] = [];
			__map[String(TYPE_HOSTAGE_BG_0)] = [];
			__map[String(TYPE_HOSTAGE_BG_1)] = [];
			__map[String(TYPE_HOSTAGE_BG_2)] = [];
			__map[String(TYPE_OVER)] = [];
			__map[String(TYPE_DOWN)] = [];
			__map[String(TYPE_LIGHT)] = [];
		}
	}
	
	public function borrow(p_type:int):BasicObject
	{
		if (!Helper.hasValue(__map, String(p_type)))
		{
			return null;
		}
		
		var item:BasicObject = null;
		var list:Array = __map[String(p_type)] as Array;
		if (list.length > 0)
		{
			item = list.pop();
			return item;
		}
		
		var addFold:Boolean = false;
		var assetKey:String = "";
		var bmp:BitmapData = null;
		var img:Bitmap = null;
		var sp:Sprite = new Sprite();
		
		switch (p_type)
		{
		case TYPE_BLANK: 
			assetKey = GameAsset.KEY_CELL_BLANK;
			break;
		case TYPE_BASE_0: 
			assetKey = GameAsset.KEY_CELL_BASE_A;
			break;
		case TYPE_BASE_1: 
			assetKey = GameAsset.KEY_CELL_BASE_B;
			break;
		case TYPE_BASE_2: 
			assetKey = GameAsset.KEY_CELL_BASE_C;
			break;
		case TYPE_ROAD_0: 
			assetKey = GameAsset.KEY_CELL_ROAD_A;
			break;
		case TYPE_ROAD_1: 
			assetKey = GameAsset.KEY_CELL_ROAD_B;
			break;
		case TYPE_ROAD_2: 
			assetKey = GameAsset.KEY_CELL_ROAD_C;
			break;
		case TYPE_ATTACK: 
			assetKey = GameAsset.KEY_CELL_ATTACK;
			break;
		case TYPE_OBSTACLE: 
			assetKey = GameAsset.KEY_CELL_OBSTACLE;
			break;
		case TYPE_OVER: 
			assetKey = GameAsset.KEY_CELL_OVER;
			break;
		case TYPE_DOWN: 
			assetKey = GameAsset.KEY_CELL_DOWN;
			break;
		case TYPE_LIGHT: 
			assetKey = GameAsset.KEY_CELL_LIGHT;
			break;
		case TYPE_ROAD_EX_0: 
			addFold = true;
			assetKey = GameAsset.KEY_CELL_ROAD_A;
			break;
		case TYPE_ROAD_EX_1: 
			addFold = true;
			assetKey = GameAsset.KEY_CELL_ROAD_B;
			break;
		case TYPE_ROAD_EX_2: 
			addFold = true;
			assetKey = GameAsset.KEY_CELL_ROAD_C;
			break;
		case TYPE_HOSTAGE_0: 
			item = GameAsset.loader.getAsset(GameAsset.getHostageKeyById(JMath.randInt(0, 7), GameData.SIDE_A)) as BasicObject;
			break;
		case TYPE_HOSTAGE_1: 
			item = GameAsset.loader.getAsset(GameAsset.getHostageKeyById(JMath.randInt(0, 7), GameData.SIDE_B)) as BasicObject;
			break;
		case TYPE_HOSTAGE_2: 
			item = GameAsset.loader.getAsset(GameAsset.getHostageKeyById(JMath.randInt(0, 7), GameData.SIDE_C)) as BasicObject;
			break;
		case TYPE_HOSTAGE_BG_0: 
		case TYPE_HOSTAGE_BG_1: 
		case TYPE_HOSTAGE_BG_2: 
		default: 
			bmp = (GameAsset.loader.getAsset(GameAsset.KEY_S01) as Bitmap).bitmapData;
			item = new BasicImage(bmp);
		}
		
		if (assetKey != "")
		{
			bmp = (GameAsset.loader.getAsset(assetKey) as Bitmap).bitmapData;
			img = new Bitmap(bmp);
			img.x = -img.width * 0.5;
			img.y = -img.height * 0.5;
			sp.addChild(img);
			item = new BasicObject(sp);
		}
		
		if (addFold)
		{
			var bg:BasicObject = item;
			var container:BasicContainer = new BasicContainer();
			var fold:BasicObject = GameAsset.loader.getAsset(GameAsset.KEY_FOLD_MC) as BasicObject;
			container.addChild(bg);
			container.addChild(fold);
			item = container;
		}
		
		return item;
	}
	
	public function payBack(p_type:int, p_item:BasicObject):void
	{
		if (!p_item)
		{
			return;
		}
		if (!Helper.hasValue(__map, String(p_type)))
		{
			return;
		}
		var list:Array = __map[String(p_type)] as Array;
		list.push(p_item);
	}

}

class MarkBoard extends BasicObject
{
	private var _tf0:JText = null;
	private var _tf1:JText = null;
	private var _tf2:JText = null;
	
	public function MarkBoard()
	{
		super();
	}
	
	override public function dispose():void
	{
		super.dispose();
	}
	
	override protected function init():void
	{
		super.init();
		
		var store:SkinStore = new SkinStore();
		var logo0:BasicObject = store.borrow(SkinStore.TYPE_HOSTAGE_0);
		var logo1:BasicObject = store.borrow(SkinStore.TYPE_HOSTAGE_1);
		var logo2:BasicObject = store.borrow(SkinStore.TYPE_HOSTAGE_2);
		
		logo0.instance.x = logo0.instance.width * 0.5;
		logo1.instance.x = logo1.instance.width * 0.5;
		logo2.instance.x = logo2.instance.width * 0.5;
		
		logo0.instance.y = logo0.instance.height * 0.5;
		logo1.instance.y = logo0.instance.y + logo0.instance.height;
		logo2.instance.y = logo1.instance.y + logo1.instance.height;
		
		var container:Sprite = this.instance as Sprite;
		container.mouseChildren = false;
		container.mouseEnabled = false;
		container.addChild(logo0.instance);
		container.addChild(logo1.instance);
		container.addChild(logo2.instance);
		
		this._tf0 = new JText(GameConfig.getFontSize() * 2, 0xffff00, JText.ALIGN_CENTER, 0, 0, logo0.instance.height);
		this._tf1 = new JText(GameConfig.getFontSize() * 2, 0xffff00, JText.ALIGN_CENTER, 0, 0, logo1.instance.height);
		this._tf2 = new JText(GameConfig.getFontSize() * 2, 0xffff00, JText.ALIGN_CENTER, 0, 0, logo2.instance.height);
		
		this.setScore(GameData.SIDE_A, 0);
		this.setScore(GameData.SIDE_B, 0);
		this.setScore(GameData.SIDE_C, 0);
		
		this._tf0.instance.x = logo0.instance.x + logo0.instance.width * 0.5;
		this._tf1.instance.x = logo1.instance.x + logo1.instance.width * 0.5;
		this._tf2.instance.x = logo2.instance.x + logo2.instance.width * 0.5;
		this._tf0.instance.y = logo0.instance.y - logo0.instance.height * 0.5;
		this._tf1.instance.y = logo1.instance.y - logo1.instance.height * 0.5;
		this._tf2.instance.y = logo2.instance.y - logo2.instance.height * 0.5;
		
		container.addChild(this._tf0.instance);
		container.addChild(this._tf1.instance);
		container.addChild(this._tf2.instance);
	}
	
	override public function reset():void
	{
		super.reset();
	}
	
	public function setScore(p_side:int, p_score:int):void
	{
		switch (p_side)
		{
		case GameData.SIDE_A: 
			this._tf0.text = " x " + p_score;
			break;
		case GameData.SIDE_B: 
			this._tf1.text = " x " + p_score;
			break;
		case GameData.SIDE_C: 
			this._tf2.text = " x " + p_score;
			break;
		default: 
			;
		}
	}

}

class TipsBoard extends JText
{
	static public const MSG_START_01:int = 1;
	static public const MSG_START_02:int = 2;
	static public const MSG_CMD_MOVE:int = 3;
	static public const MSG_CMD_JUMP:int = 4;
	static public const MSG_CMD_ATK:int = 5;
	static public const MSG_CMD_TIPS:int = 6;
	static public const MSG_CMD_AUTO:int = 7;
	static public const MSG_CMD_PLAY:int = 8;
	
	public function TipsBoard()
	{
		super(12, 0xff000000, JText.ALIGN_CENTER, 0, 1000, 30);
	}
	
	override public function dispose():void
	{
		super.dispose();
	}
	
	override protected function init():void
	{
		super.init();
		this.textField.background = true;
		this.textField.backgroundColor = 0xffffff;
	}
	
	public function showMsg(p_code:int):void
	{
		switch (p_code)
		{
		case MSG_START_01: 
			this.text = GameLang.i.getValue("tips-00001");
			break;
		case MSG_START_02: 
			this.text = GameLang.i.getValue("tips-00002");
			break;
		case MSG_CMD_MOVE: 
			this.text = GameLang.i.getValue("tips-00003");
			break;
		case MSG_CMD_JUMP: 
			this.text = GameLang.i.getValue("tips-00004");
			break;
		case MSG_CMD_ATK: 
			this.text = GameLang.i.getValue("tips-00005");
			break;
		case MSG_CMD_AUTO: 
			this.text = GameLang.i.getValue("tips-00006");
			break;
		case MSG_CMD_PLAY: 
			this.text = GameLang.i.getValue("tips-00007");
			break;
		case MSG_CMD_TIPS: 
			var list:Array = [//
			"tips-10000"//
			, "tips-10001"//
			, "tips-10002"//
			, "tips-10003"//
			, "tips-10004"//
			, "tips-10005"//
			, "tips-10006"//
			, "tips-10007"//
			, "tips-10008"//
			];
			if (new Date().time > new Date(2016, 11, 19).time)
			{
				list.push("tips-20000");
				list.push("tips-20001");
				list.push("tips-20002");
				list.push("tips-20003");
				list.push("tips-20004");
				list.push("tips-20005");
				list.push("tips-20006");
				list.push("tips-20007");
				list.push("tips-20008");
				list.push("tips-20009");
				list.push("tips-20010");
			}
			if (new Date().time > new Date(2016, 11, 27).time && new Date().time < new Date(2016, 11, 28).time)
			{
				list.push("tips-10090");
			}
			else if (new Date().time < new Date(2017, 11, 28).time)
			{
				list.push("tips-10091");
			}
			else
			{
				list.push("tips-10092");
			}
			this.text = GameLang.i.getValue(Helper.selectFrom(list) as String);
			break;
		default: 
			;
		}
	}

}

class ButtonGroup extends BasicObject
{
	public function ButtonGroup()
	{
		super();
	}
	
	override public function dispose():void
	{
		this.container.removeEventListener(MouseEvent.CLICK, this.onMouseClick);
		this.container.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
		this.container.removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
		this.container.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
		this.container.removeEventListener(MouseEvent.ROLL_OUT, this.onMouseRollOut);
		super.dispose();
	}
	
	override protected function init():void
	{
		super.init();
		this.container.addEventListener(MouseEvent.CLICK, this.onMouseClick);
		this.container.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
		this.container.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
		this.container.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
		this.container.addEventListener(MouseEvent.ROLL_OUT, this.onMouseRollOut);
	}
	
	override public function reset():void
	{
		super.reset();
		this.container.removeChildren();
	}
	
	private function get container():Sprite
	{
		return (this.instance as Sprite);
	}
	
	public function add(p_btn:BasicObject, p_x:int, p_y:int):void
	{
		p_btn.instance.x = p_x;
		p_btn.instance.y = p_y;
		this.container.addChild(p_btn.instance);
	}
	
	protected function onMouseClick(p_evt:MouseEvent):void
	{
		;
	}
	
	protected function onMouseDown(p_evt:MouseEvent):void
	{
		;
	}
	
	protected function onMouseOver(p_evt:MouseEvent):void
	{
		;
	}
	
	protected function onMouseUp(p_evt:MouseEvent):void
	{
		;
	}
	
	protected function onMouseRollOut(p_evt:MouseEvent):void
	{
		;
	}

}

class ButtonList extends BasicObject
{
	private var _bmpIdleA:BitmapData = null;
	private var _bmpIdleB:BitmapData = null;
	private var _bmpIdleC:BitmapData = null;
	private var _bmpIdleD:BitmapData = null;
	private var _bmpOverA:BitmapData = null;
	private var _bmpOverB:BitmapData = null;
	private var _bmpOverC:BitmapData = null;
	private var _bmpOverD:BitmapData = null;
	private var _count:int = 0;
	private var _lastBtn:BasicButton = null;
	private var _txtMap:Object = null;
	
	public function ButtonList(//
	p_bmpIdleA:BitmapData//
	, p_bmpIdleB:BitmapData//
	, p_bmpIdleC:BitmapData//
	, p_bmpIdleD:BitmapData//
	, p_bmpOverA:BitmapData//
	, p_bmpOverB:BitmapData//
	, p_bmpOverC:BitmapData//
	, p_bmpOverD:BitmapData//
	)
	{
		this._bmpIdleA = p_bmpIdleA;
		this._bmpIdleB = p_bmpIdleB;
		this._bmpIdleC = p_bmpIdleC;
		this._bmpIdleD = p_bmpIdleD;
		this._bmpOverA = p_bmpOverA;
		this._bmpOverB = p_bmpOverB;
		this._bmpOverC = p_bmpOverC;
		this._bmpOverD = p_bmpOverD;
		
		super();
	}
	
	override public function dispose():void
	{
		this._bmpIdleA = null;
		this._bmpIdleB = null;
		this._bmpIdleC = null;
		this._bmpIdleD = null;
		this._bmpOverA = null;
		this._bmpOverB = null;
		this._bmpOverC = null;
		this._bmpOverD = null;
		this._lastBtn = null;
		this._txtMap = null;
		
		super.dispose();
	}
	
	override protected function init():void
	{
		super.init();
		this._txtMap = {};
	}
	
	private function get container():Sprite
	{
		return (this.instance as Sprite);
	}
	
	public function add(p_key:String, p_lang:String, p_langData:Array, p_data:Object):void
	{
		var skin:SimpleSkin = new SimpleSkin();
		if (!this._lastBtn)
		{
			skin.addSkin(BasicButton.SKIN_DISABLE, new BasicImage(this._bmpIdleD));
			skin.addSkin(BasicButton.SKIN_DOWN, new BasicImage(this._bmpOverD));
			skin.addSkin(BasicButton.SKIN_IDLE, new BasicImage(this._bmpIdleD));
			skin.addSkin(BasicButton.SKIN_OVER, new BasicImage(this._bmpOverD));
		}
		else
		{
			if (this._count == 1)
			{
				skin.addSkin(BasicButton.SKIN_DISABLE, new BasicImage(this._bmpIdleA));
				skin.addSkin(BasicButton.SKIN_DOWN, new BasicImage(this._bmpOverA));
				skin.addSkin(BasicButton.SKIN_IDLE, new BasicImage(this._bmpIdleA));
				skin.addSkin(BasicButton.SKIN_OVER, new BasicImage(this._bmpOverA));
			}
			else
			{
				skin.addSkin(BasicButton.SKIN_DISABLE, new BasicImage(this._bmpIdleB));
				skin.addSkin(BasicButton.SKIN_DOWN, new BasicImage(this._bmpOverB));
				skin.addSkin(BasicButton.SKIN_IDLE, new BasicImage(this._bmpIdleB));
				skin.addSkin(BasicButton.SKIN_OVER, new BasicImage(this._bmpOverB));
			}
			this._lastBtn.reloadSkin(skin);
			
			skin = new SimpleSkin();
			skin.addSkin(BasicButton.SKIN_DISABLE, new BasicImage(this._bmpIdleC));
			skin.addSkin(BasicButton.SKIN_DOWN, new BasicImage(this._bmpOverC));
			skin.addSkin(BasicButton.SKIN_IDLE, new BasicImage(this._bmpIdleC));
			skin.addSkin(BasicButton.SKIN_OVER, new BasicImage(this._bmpOverC));
		}
		this._lastBtn = new BasicButton(skin, p_data);
		this._lastBtn.instance.y = this._count * this._bmpIdleA.height;
		this._lastBtn.signal.add(this.onClick, AbstractButton.ACTION_CLICK);
		this._count++;
		this.container.addChild(this._lastBtn.instance);
		
		var tf:JText = new JText(12, 0, JText.ALIGN_CENTER, 0, this._bmpIdleA.width, this._bmpIdleA.height);
		tf.instance.y = this._lastBtn.instance.y;
		this.container.addChild(tf.instance);
		
		this._txtMap[p_key] = {btn: this._lastBtn, tf: tf, lang: p_lang, langData: p_langData};
	}
	
	public function setLangByKey(p_key:String, p_lang:String, p_langData:Array):void
	{
		var item:Object = this._txtMap[p_key];
		if (!item)
		{
			return;
		}
		
		item.lang = p_lang;
		item.langData = p_langData;
		
		var tf:JText = item.tf as JText;
		var lang:String = item.lang as String;
		var langData:Array = item.langData as Array;
		var str:String = GameLang.i.getValue(lang, langData);
		tf.text = str;
	}
	
	public function setEnable(p_key:String, p_value:Boolean):void
	{
		var item:Object = this._txtMap[p_key];
		if (!item)
		{
			return;
		}
		var btn:BasicButton = item.btn as BasicButton;
		btn.enable = p_value;
		
		var tf:JText = item.tf as JText;
		if (p_value)
		{
			tf.color = 0;
		}
		else
		{
			tf.color = 0x6d6d6d;
		}
	}
	
	public function updateLang():void
	{
		for (var key:String in this._txtMap)
		{
			var item:Object = this._txtMap[key];
			var tf:JText = item.tf as JText;
			var lang:String = item.lang as String;
			var langData:Array = item.langData as Array;
			var str:String = GameLang.i.getValue(lang, langData);
			tf.text = str;
		}
	}
	
	private function onClick(p_result:Object):void
	{
		this.signal.dispatch(p_result.data);
	}

}

class GameMapItem extends BasicObject
{
	private var _key:String = "";
	private var _flashValue:Number = 0;
	private var _side:int = 0;
	private var _state:int = 0;
	
	private var _bottom:SkinStoreItem = null;
	private var _face:SkinStoreItem = null;
	private var _flash:SkinStoreItem = null;
	private var _front:SkinStoreItem = null;
	private var _txt:JText = null;
	
	private var _timer:JTimer = null;
	
	public function GameMapItem(p_key:String):void
	{
		this._key = p_key;
		super();
	}
	
	override public function dispose():void
	{
		Helper.dispose(this._bottom);
		Helper.dispose(this._face);
		Helper.dispose(this._flash);
		Helper.dispose(this._front);
		Helper.dispose(this._timer);
		Helper.dispose(this._txt);
		this._bottom = null;
		this._face = null;
		this._flash = null;
		this._front = null;
		this._timer = null;
		this._txt = null;
		super.dispose();
	}
	
	override protected function init():void
	{
		super.init();
		
		this.container.mouseChildren = false;
		//	this.container.mouseEnabled = false;
		
		this._bottom = new SkinStoreItem();
		this._face = new SkinStoreItem();
		this._flash = new SkinStoreItem();
		this._front = new SkinStoreItem();
		this.container.addChild(this._bottom.instance);
		this.container.addChild(this._face.instance);
		this.container.addChild(this._flash.instance);
		this.container.addChild(this._front.instance);
		
		this._txt = new JText(GameConfig.getFontSize(), GameConfig.getFontColor(), JText.ALIGN_BOTTON, 0, GameConfig.getCellRadius() * 2, GameConfig.getCellRadius() * 1.732);
		var tf:TextField = this._txt.textField;
		
		//tf.background = true;
		//tf.backgroundColor = 0x88ffff88;
		tf.filters = [new GlowFilter(0xffffff, 1, GameConfig.getFontSize() * 0.3, GameConfig.getFontSize() * 0.3)//
		, new DropShadowFilter(GameConfig.getFontSize() * 0.1, 131, 0, 1, GameConfig.getFontSize() * 0.3, GameConfig.getFontSize() * 0.3)];
		
		this._txt.text = this._key;
		this._txt.instance.x = -GameConfig.getCellRadius();
		this._txt.instance.y = -GameConfig.getCellRadius();
		if (GameConfig.getFontDisplay())
		{
			this.container.addChild(this._txt.instance);
		}
		
		this._bottom.show(SkinStore.TYPE_BLANK);
		this._flash.instance.visible = false;
		
		this._timer = new JTimer(this.onTime);
	}
	
	public function setMouseClear():void
	{
		this._front.show(SkinStore.TYPE_NONE);
	}
	
	public function setMouseDown():void
	{
		this._front.show(SkinStore.TYPE_DOWN);
	}
	
	public function setMouseOver():void
	{
		this._front.show(SkinStore.TYPE_OVER);
	}
	
	private function setSkin(p_skin:SkinStoreItem, p_state:int, p_side:int):void
	{
		switch (p_state)
		{
		case GameData.STATE_BASE: 
			switch (p_side)
			{
			case GameData.SIDE_A: 
				p_skin.show(SkinStore.TYPE_BASE_0);
				break;
			case GameData.SIDE_B: 
				p_skin.show(SkinStore.TYPE_BASE_1);
				break;
			case GameData.SIDE_C: 
				p_skin.show(SkinStore.TYPE_BASE_2);
				break;
			default: 
				p_skin.show(SkinStore.TYPE_NONE);
			}
			break;
		case GameData.STATE_ATTACK: 
			p_skin.show(SkinStore.TYPE_ATTACK);
			break;
		case GameData.STATE_HOSTAGE: 
			switch (p_side)
			{
			case GameData.SIDE_A: 
				p_skin.show(SkinStore.TYPE_HOSTAGE_0);
				break;
			case GameData.SIDE_B: 
				p_skin.show(SkinStore.TYPE_HOSTAGE_1);
				break;
			case GameData.SIDE_C: 
				p_skin.show(SkinStore.TYPE_HOSTAGE_2);
				break;
			default: 
				p_skin.show(SkinStore.TYPE_NONE);
			}
			break;
		case GameData.STATE_OBSTACLE: 
			p_skin.show(SkinStore.TYPE_OBSTACLE);
			break;
		case GameData.STATE_ROAD: 
			switch (p_side)
			{
			case GameData.SIDE_A: 
				p_skin.show(SkinStore.TYPE_ROAD_0);
				break;
			case GameData.SIDE_B: 
				p_skin.show(SkinStore.TYPE_ROAD_1);
				break;
			case GameData.SIDE_C: 
				p_skin.show(SkinStore.TYPE_ROAD_2);
				break;
			default: 
				p_skin.show(SkinStore.TYPE_NONE);
			}
			break;
		case GameData.STATE_ROAD_EX: 
			switch (p_side)
			{
			case GameData.SIDE_A: 
				p_skin.show(SkinStore.TYPE_ROAD_EX_0);
				break;
			case GameData.SIDE_B: 
				p_skin.show(SkinStore.TYPE_ROAD_EX_1);
				break;
			case GameData.SIDE_C: 
				p_skin.show(SkinStore.TYPE_ROAD_EX_2);
				break;
			default: 
				p_skin.show(SkinStore.TYPE_NONE);
			}
			break;
		case GameData.STATE_NONE: 
		default: 
			p_skin.show(SkinStore.TYPE_NONE);
		}
	}
	
	public function setState(p_state:int, p_side:int):void
	{
		this._side = p_side;
		this._state = p_state;
		this.setSkin(this._face, p_state, p_side);
		
		this._front.show(SkinStore.TYPE_LIGHT);
		new JTweener(1000, function(p_value:Number):void
		{
			_front.instance.alpha = (1000 - p_value) * 0.001;
		}, function():void
		{
			_front.show(SkinStore.TYPE_NONE);
			_front.instance.alpha = 1;
		}).run();
	}
	
	public function setFlash(p_state:int, p_side:int):void
	{
		this.setSkin(this._flash, p_state, p_side);
		if (this._flash.instance.visible)
		{
			if (p_state == GameData.STATE_NONE)
			{
				this._flash.instance.visible = false;
				this._timer.stop();
			}
		}
		else
		{
			if (p_state == GameData.STATE_NONE)
			{
				return;
			}
			
			this._flashValue = 0;
			this._flash.instance.alpha = 0;
			this._flash.instance.visible = true;
			this._timer.start();
		}
	}
	
	public function setText(p_value:String):void
	{
		this._txt.text = p_value;
	}
	
	public function get state():int
	{
		return this._state;
	}
	
	public function get side():int
	{
		return this._side;
	}
	
	private function onTime(p_delta:Number):void
	{
		if (!this._flash)
		{
			return;
		}
		
		this._flashValue += 0.001 * p_delta;
		if (this._flashValue > 1)
		{
			this._flashValue -= 2;
		}
		
		this._flash.instance.alpha = Math.abs(this._flashValue);
	}
	
	private function get container():Sprite
	{
		return (this.instance as Sprite);
	}

}

class GameMap extends ButtonGroup
{
	static public const ACTION_CLICK:String = "GameMap.ACTION_CLICK";
	
	private var _itemMap:Object = null;
	private var _downKey:String = "";
	private var _overKey:String = "";
	private var _xMax:int = 0;
	private var _yMax:int = 0;
	
	public function GameMap()
	{
		super();
	}
	
	override public function dispose():void
	{
		this._itemMap = null;
		super.dispose();
	}
	
	override protected function init():void
	{
		super.init();
		this._itemMap = {};
	}
	
	override public function reset():void
	{
		super.reset();
		this._itemMap = {};
		this._downKey = "";
		this._overKey = "";
		this._xMax = 0;
		this._yMax = 0;
	}
	
	public function create(p_list:Array):void
	{
		this.reset();
		
		var cellWidth:int = GameConfig.getCellRadius() * 2 + 0.5;
		var cellHeight:int = GameConfig.getCellRadius() * 1.732 + 0.5;
		for (var i:int = 0; i < p_list.length; i++)
		{
			var data:MapCell = p_list[i] as MapCell;
			var key:String = String(data.id);
			var item:GameMapItem = new GameMapItem(key);
			item.instance.name = key;
			item.setState(data.state, data.side);
			//	item.setText( "" + data.keyX +"," + data.keyY +"," + data.keyZ);
			var posX:int = data.posX * int(cellWidth * 0.75) + cellWidth;
			var posY:int = data.posY * int(cellHeight * 0.5) + cellHeight;
			if (posX > this._xMax)
			{
				this._xMax = posX;
			}
			if (posY > this._yMax)
			{
				this._yMax = posY;
			}
			this.add(item, posX, posY);
			
			this._itemMap[key] = item;
		}
		this._xMax += cellWidth;
		this._yMax += cellHeight;
	}
	
	public function get width():int
	{
		return this._xMax;
	}
	
	public function get height():int
	{
		return this._yMax;
	}
	
	private function findItem(p_key:String):GameMapItem
	{
		if (!Helper.hasValue(this._itemMap, p_key))
		{
			return null;
		}
		
		return this._itemMap[p_key] as GameMapItem;
	}
	
	public function setCell(p_id:String, p_side:int, p_state:int):void
	{
		var item:GameMapItem = this.findItem(p_id);
		if (!item)
		{
			return;
		}
		item.setState(p_state, p_side);
	}
	
	public function clearCellFlash():void
	{
		for (var key:String in this._itemMap)
		{
			var item:GameMapItem = this._itemMap[key];
			item.setFlash(GameData.STATE_NONE, 0);
		}
	}
	
	public function setCellFlash(p_id:String, p_side:int, p_state:int):void
	{
		var item:GameMapItem = this.findItem(p_id);
		if (!item)
		{
			return;
		}
		item.setFlash(p_state, p_side);
	}
	
	override protected function onMouseClick(p_evt:MouseEvent):void
	{
		var target:DisplayObject = p_evt.target as DisplayObject;
		var key:String = target.name;
		var item:GameMapItem = this.findItem(key);
		//	trace(key);
		if (!item)
		{
			return;
		}
		this.signal.dispatch({action: ACTION_CLICK, data: {id: key, side: item.side, state: item.state}, target: this});
	}
	
	override protected function onMouseDown(p_evt:MouseEvent):void
	{
		var target:DisplayObject = p_evt.target as DisplayObject;
		var key:String = target.name;
		if (key == this._downKey)
		{
			return;
		}
		var item:GameMapItem = null;
		if (this._downKey != "")
		{
			item = this.findItem(this._downKey);
			item.setMouseClear();
			this._downKey = "";
		}
		item = this.findItem(key);
		if (!item)
		{
			return;
		}
		this._downKey = key;
		item.setMouseDown();
	}
	
	override protected function onMouseOver(p_evt:MouseEvent):void
	{
		var target:DisplayObject = p_evt.target as DisplayObject;
		var key:String = target.name;
		if (key == this._overKey)
		{
			return;
		}
		var item:GameMapItem = null;
		if (this._overKey != "")
		{
			item = this.findItem(this._overKey);
			item.setMouseClear();
			this._overKey = "";
		}
		item = this.findItem(key);
		if (!item)
		{
			return;
		}
		this._overKey = key;
		item.setMouseOver();
	}
	
	override protected function onMouseUp(p_evt:MouseEvent):void
	{
		var target:DisplayObject = p_evt.target as DisplayObject;
		var key:String = target.name;
		var item:GameMapItem = null;
		if (this._downKey != "")
		{
			item = this.findItem(this._downKey);
			item.setMouseClear();
			this._downKey = "";
		}
		item = this.findItem(key);
		if (!item)
		{
			return;
		}
		this._overKey = key;
		item.setMouseOver();
	}
	
	override protected function onMouseRollOut(p_evt:MouseEvent):void
	{
		if (this._overKey == "")
		{
			return;
		}
		var item:GameMapItem = this.findItem(this._overKey);
		item.setMouseClear();
		this._overKey = "";
	}

}

class GameCommandPlay extends BasicObject
{
	static public const ACTION_CLICK:String = "GameCommand.ACTION_CLICK";
	
	private var _btn:BasicButton = null;
	private var _listBtn:ButtonList = null;
	
	public function GameCommandPlay()
	{
		super();
	}
	
	override public function dispose():void
	{
		Helper.dispose(this._btn);
		Helper.dispose(this._listBtn);
		this._btn = null;
		this._listBtn = null;
		
		super.dispose();
	}
	
	override protected function init():void
	{
		super.init();
	}
	
	override public function reset():void
	{
		super.reset();
		
		var skin:SimpleSkin = new SimpleSkin();
		skin.addSkin(BasicButton.SKIN_DOWN, new BasicImage((GameAsset.loader.getAssetOfGroup(GameAsset.KEY_IMAGE, "cmdOver") as Bitmap).bitmapData));
		skin.addSkin(BasicButton.SKIN_IDLE, new BasicImage((GameAsset.loader.getAssetOfGroup(GameAsset.KEY_IMAGE, "cmdIdle") as Bitmap).bitmapData));
		skin.addSkin(BasicButton.SKIN_OVER, new BasicImage((GameAsset.loader.getAssetOfGroup(GameAsset.KEY_IMAGE, "cmdOver") as Bitmap).bitmapData));
		this._btn = new BasicButton(skin, null, true);
		this._btn.signal.add(this.onEnterClick, BasicButton.ACTION_VALUE_CHANGE);
		
		this.container.addChild(this._btn.instance);
		
		this._listBtn = new ButtonList(//
		(GameAsset.loader.getAssetOfGroup(GameAsset.KEY_IMAGE, "cmdListIdleA") as Bitmap).bitmapData//
		, (GameAsset.loader.getAssetOfGroup(GameAsset.KEY_IMAGE, "cmdListIdleB") as Bitmap).bitmapData//
		, (GameAsset.loader.getAssetOfGroup(GameAsset.KEY_IMAGE, "cmdListIdleC") as Bitmap).bitmapData//
		, (GameAsset.loader.getAssetOfGroup(GameAsset.KEY_IMAGE, "cmdListIdleD") as Bitmap).bitmapData//
		, (GameAsset.loader.getAssetOfGroup(GameAsset.KEY_IMAGE, "cmdListOverA") as Bitmap).bitmapData//
		, (GameAsset.loader.getAssetOfGroup(GameAsset.KEY_IMAGE, "cmdListOverB") as Bitmap).bitmapData//
		, (GameAsset.loader.getAssetOfGroup(GameAsset.KEY_IMAGE, "cmdListOverC") as Bitmap).bitmapData//
		, (GameAsset.loader.getAssetOfGroup(GameAsset.KEY_IMAGE, "cmdListOverD") as Bitmap).bitmapData//
		);
		this._listBtn.instance.x = this._btn.instance.x;
		this._listBtn.instance.y = this._btn.instance.y + this._btn.instance.height;
		this.loadListBtn();
		this._listBtn.signal.add(this.onCmdClick);
		this.container.addChild(this._listBtn.instance);
		
		GameController.i.signal.add(this.onLangUpdate, GameLang.EVENT_LANG_UPDATE);
	}
	
	private function loadListBtn():void
	{
		var list:Array = [//
		{cmd: "a:mov", lang: "cmds-00001", enable: false}//
		, {cmd: "a:jmp", lang: "cmds-00002", enable: false}//
		, {cmd: "a:atk", lang: "cmds-00003", enable: false}//
		, {cmd: "sys:pass", lang: "cmds-00016", enable: true}//
		, {cmd: "sys:close", lang: "cmds-00017", enable: true}//
		];
		for (var i:int = 0; i < list.length; i++)
		{
			this._listBtn.add(list[i].cmd, list[i].lang, [""], {cmd: list[i].cmd});
			this._listBtn.setEnable(list[i].cmd, list[i].enable);
		}
		this._listBtn.updateLang();
	}
	
	private function get container():Sprite
	{
		return (this.instance as Sprite);
	}
	
	private function onCmdClick(p_result:Object):void
	{
		var data:Object = {};
		var cmd:String = p_result.cmd as String;
		var cmdCode:int = 0;
		var cmdSide:int = 0;
		switch (cmd)
		{
		case "a:mov": 
			data = {cmd: GameData.COMMAND_ROAD, side: GameData.SIDE_A};
			break;
		case "a:jmp": 
			data = {cmd: GameData.COMMAND_ROAD_EX, side: GameData.SIDE_A};
			break;
		case "a:atk": 
			data = {cmd: GameData.COMMAND_ATTACK, side: GameData.SIDE_A};
			break;
		case "sys:close": 
			data = {cmd: GameData.COMMAND_CLOSE};
			break;
		case "sys:pass": 
			data = {cmd: GameData.COMMAND_PASS};
			break;
		default: 
			return;
		}
		this.signal.dispatch(data, ACTION_CLICK);
	}
	
	private function onLangUpdate(p_result:Object):void
	{
		this._listBtn.updateLang();
	}
	
	public function updateCmd(p_atk:int, p_jmp:int, p_mov:int):void
	{
		this._listBtn.setLangByKey("a:atk", "cmds-00003", [" (" + p_atk + ")"]);
		this._listBtn.setLangByKey("a:jmp", "cmds-00002", [" (" + p_jmp + ")"]);
		this._listBtn.setLangByKey("a:mov", "cmds-00001", [" (" + p_mov + ")"]);
		
		this._listBtn.setEnable("a:atk", p_atk > 0);
		this._listBtn.setEnable("a:jmp", p_jmp > 0);
		this._listBtn.setEnable("a:mov", p_mov > 0);
	}
	
	private function updateEnter(p_value:Boolean):void
	{
		var data:Object = {};
		this._listBtn.instance.visible = p_value;
		if (p_value)
		{
			data = {cmd: GameData.COMMAND_OPEN};
		}
		else
		{
			data = {cmd: GameData.COMMAND_TIPS};
		}
		this.signal.dispatch(data, ACTION_CLICK);
	}
	
	private function onEnterClick(p_result:Object):void
	{
		this.updateEnter(this._btn.value);
	}
	
	public function openList():void
	{
		this._btn.value = true;
		this.updateEnter(this._btn.value);
	}

}

class GameCommand extends BasicObject
{
	static public const ACTION_CLICK:String = "GameCommand.ACTION_CLICK";
	
	private var _btn:BasicButton = null;
	private var _listBtn:ButtonList = null;
	
	public function GameCommand()
	{
		super();
	}
	
	override public function dispose():void
	{
		Helper.dispose(this._btn);
		Helper.dispose(this._listBtn);
		this._btn = null;
		this._listBtn = null;
		
		super.dispose();
	}
	
	override protected function init():void
	{
		super.init();
	}
	
	override public function reset():void
	{
		super.reset();
		
		var skin:SimpleSkin = new SimpleSkin();
		skin.addSkin(BasicButton.SKIN_DOWN, new BasicImage((GameAsset.loader.getAssetOfGroup(GameAsset.KEY_IMAGE, "cmdOver") as Bitmap).bitmapData));
		skin.addSkin(BasicButton.SKIN_IDLE, new BasicImage((GameAsset.loader.getAssetOfGroup(GameAsset.KEY_IMAGE, "cmdIdle") as Bitmap).bitmapData));
		skin.addSkin(BasicButton.SKIN_OVER, new BasicImage((GameAsset.loader.getAssetOfGroup(GameAsset.KEY_IMAGE, "cmdOver") as Bitmap).bitmapData));
		this._btn = new BasicButton(skin, null, true);
		this._btn.signal.add(this.onEnterClick, BasicButton.ACTION_VALUE_CHANGE);
		
		this.container.addChild(this._btn.instance);
		
		this._listBtn = new ButtonList(//
		(GameAsset.loader.getAssetOfGroup(GameAsset.KEY_IMAGE, "cmdListIdleA") as Bitmap).bitmapData//
		, (GameAsset.loader.getAssetOfGroup(GameAsset.KEY_IMAGE, "cmdListIdleB") as Bitmap).bitmapData//
		, (GameAsset.loader.getAssetOfGroup(GameAsset.KEY_IMAGE, "cmdListIdleC") as Bitmap).bitmapData//
		, (GameAsset.loader.getAssetOfGroup(GameAsset.KEY_IMAGE, "cmdListIdleD") as Bitmap).bitmapData//
		, (GameAsset.loader.getAssetOfGroup(GameAsset.KEY_IMAGE, "cmdListOverA") as Bitmap).bitmapData//
		, (GameAsset.loader.getAssetOfGroup(GameAsset.KEY_IMAGE, "cmdListOverB") as Bitmap).bitmapData//
		, (GameAsset.loader.getAssetOfGroup(GameAsset.KEY_IMAGE, "cmdListOverC") as Bitmap).bitmapData//
		, (GameAsset.loader.getAssetOfGroup(GameAsset.KEY_IMAGE, "cmdListOverD") as Bitmap).bitmapData//
		);
		this._listBtn.instance.x = this._btn.instance.x;
		this._listBtn.instance.y = this._btn.instance.y + this._btn.instance.height;
		this._listBtn.instance.visible = false;
		this.loadListBtn();
		this._listBtn.signal.add(this.onCmdClick);
		this.container.addChild(this._listBtn.instance);
		
		GameController.i.signal.add(this.onLangUpdate, GameLang.EVENT_LANG_UPDATE);
	}
	
	private function loadListBtn():void
	{
		var list:Array = GameController.i.config.view.game_command_list as Array;
		Helper.loadArray(list, 3, function(p_result:Array):void
		{
			if (p_result.length != 3)
			{
				return;
			}
			var key:String = p_result[0];
			var lang:String = p_result[1];
			var state:int = p_result[2];
			if (state == 0)
			{
				return;
			}
			var cmd:String = key;
			_listBtn.add(key, lang, [""], {cmd: cmd});
		});
		this._listBtn.updateLang();
	}
	
	private function get container():Sprite
	{
		return (this.instance as Sprite);
	}
	
	private function onCmdClick(p_result:Object):void
	{
		this._btn.value = false;
		this._listBtn.instance.visible = this._btn.value;
		
		var data:Object = {};
		var cmd:String = p_result.cmd as String;
		var cmdCode:int = 0;
		var cmdSide:int = 0;
		switch (cmd)
		{
		case "a:mov": 
			data = {cmd: GameData.COMMAND_ROAD, side: GameData.SIDE_A};
			break;
		case "a:jmp": 
			data = {cmd: GameData.COMMAND_ROAD_EX, side: GameData.SIDE_A};
			break;
		case "a:atk": 
			data = {cmd: GameData.COMMAND_ATTACK, side: GameData.SIDE_A};
			break;
		case "b:mov": 
			data = {cmd: GameData.COMMAND_ROAD, side: GameData.SIDE_B};
			break;
		case "b:jmp": 
			data = {cmd: GameData.COMMAND_ROAD_EX, side: GameData.SIDE_B};
			break;
		case "b:atk": 
			data = {cmd: GameData.COMMAND_ATTACK, side: GameData.SIDE_B};
			break;
		case "c:mov": 
			data = {cmd: GameData.COMMAND_ROAD, side: GameData.SIDE_C};
			break;
		case "c:jmp": 
			data = {cmd: GameData.COMMAND_ROAD_EX, side: GameData.SIDE_C};
			break;
		case "c:atk": 
			data = {cmd: GameData.COMMAND_ATTACK, side: GameData.SIDE_C};
			break;
		case "lang:zh": 
			data = {cmd: GameData.COMMAND_LANG, lang: GameLang.LANG_ZH};
			break;
		case "lang:en": 
			data = {cmd: GameData.COMMAND_LANG, lang: GameLang.LANG_EN};
			break;
		case "sys:undo": 
			data = {cmd: GameData.COMMAND_UNDO};
			break;
		case "sys:clr": 
			data = {cmd: GameData.COMMAND_CLEAR};
			break;
		case "sys:save": 
			data = {cmd: GameData.COMMAND_SAVE};
			break;
		case "sys:tips": 
			data = {cmd: GameData.COMMAND_TIPS};
			break;
		case "sys:auto": 
			data = {cmd: GameData.COMMAND_AUTO};
			break;
		case "sys:play": 
			data = {cmd: GameData.COMMAND_PLAY};
			break;
		case "sys:prtScn": 
			data = {cmd: GameData.COMMAND_PRINT};
			break;
		default: 
			return;
		}
		this.signal.dispatch(data, ACTION_CLICK);
	}
	
	private function onEnterClick(p_result:Object):void
	{
		var data:Object = {};
		this._listBtn.instance.visible = this._btn.value;
		if (this._btn.value)
		{
			data = {cmd: GameData.COMMAND_OPEN};
		}
		else
		{
			data = {cmd: GameData.COMMAND_TIPS};
		}
		this.signal.dispatch(data, ACTION_CLICK);
	}
	
	private function onLangUpdate(p_result:Object):void
	{
		this._listBtn.updateLang();
	}

}