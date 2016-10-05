package com.pj.macross
{
	import com.pj.common.Helper;
	import com.pj.common.component.BasicContainer;
	import com.pj.common.component.JBackground;
	import com.pj.common.component.Slider;
	import flash.display.Bitmap;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class GameView extends BasicContainer
	{
		static public const EVENT_CMD_CLICK:String = "EVENT_CMD_CLICK";
		static public const EVENT_MAP_CLICK:String = "EVENT_MAP_CLICK";
		
		private var _bg:JBackground = null;
		private var _map:GameMap = null;
		private var _mark:MarkBoard = null;
		private var _slider:Slider = null;
		
		private var _cmdSide:int = 0;
		private var _cmdCode:int = 0;
		
		public function GameView()
		{
			super();
		}
		
		override public function dispose():void
		{
			Helper.dispose(this._bg);
			Helper.dispose(this._map);
			Helper.dispose(this._mark);
			Helper.dispose(this._slider);
			this._bg = null;
			this._map = null;
			this._mark = null;
			this._slider = null;
			super.dispose();
		}
		
		override protected function init():void
		{
			super.init();
			
			this._bg = new JBackground((GameAsset.loader.getAsset(GameAsset.KEY_GALAXY) as Bitmap).bitmapData);
			this.addChild(this._bg);
			
			this._map = new GameMap();
			this._map.signal.add(this.onMapClick, GameMap.ACTION_CLICK);
			this._mark = new MarkBoard();
		}
		
		public function createMap(p_list:Array):void
		{
			this._map.create(p_list);
			
			if (!this._slider)
			{
				this._slider = new Slider(this, 0, 0, this._map.width, this._map.height);
				this._slider.addChild(this._map);
				this.addChild(this._slider);
				this.addChild(this._mark);
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
		
		public function updateMap(p_id:String, p_side:int, p_state:int):void
		{
			this._map.setCell(p_id, p_side, p_state);
			this.signal.dispatch({side: this._cmdSide, command: this._cmdCode}, EVENT_CMD_CLICK);
		}
		
		public function updateScore(p_side:int, p_score:int):void {
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
					this._cmdCode = GameData.COMMAND_ROAD;
				}
				this.signal.dispatch({side: this._cmdSide, command: this._cmdCode}, EVENT_CMD_CLICK);
			}
			else
			{
				this.signal.dispatch({id: id, side: this._cmdSide, command: this._cmdCode}, EVENT_MAP_CLICK);
			}
		}
	
	}
}

import com.pj.common.Helper;
import com.pj.common.JTimer;
import com.pj.common.component.BasicContainer;
import com.pj.common.component.BasicImage;
import com.pj.common.component.BasicObject;
import com.pj.common.component.JText;
import com.pj.common.math.JMath;
import com.pj.macross.GameAsset;
import com.pj.macross.GameConfig;
import com.pj.macross.GameData;
import com.pj.macross.structure.MapCell;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.filters.GlowFilter;
import flash.text.TextField;

class SkinStoreItem extends BasicObject
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
		this.setSkin(SkinStore.TYPE_NONE);
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
		this.setSkin(SkinStore.TYPE_NONE);
	}
	
	public function setSkin(p_type:int):void
	{
		if (p_type == this._type)
		{
			return;
		}
		
		this.container.removeChildren();
		this._store.payBack(this._type, this._skin);
		this._type = SkinStore.TYPE_NONE;
		this._skin = null;
		
		if (p_type == SkinStore.TYPE_NONE)
		{
			return;
		}
		
		this._type = p_type;
		this._skin = this._store.borrow(this._type);
		if (!this._skin)
		{
			this._type = SkinStore.TYPE_NONE;
			return;
		}
		
		this.container.addChild(this._skin.instance);
	}
	
	private function get container():Sprite
	{
		return (this.instance as Sprite);
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
		container.addChild(logo0.instance);
		container.addChild(logo1.instance);
		container.addChild(logo2.instance);
		
		this._tf0 = new JText(GameConfig.FONT_SIZE_MAP * 2, 0xffff00, JText.ALIGN_CENTER, 0, 0, logo0.instance.height);
		this._tf1 = new JText(GameConfig.FONT_SIZE_MAP * 2, 0xffff00, JText.ALIGN_CENTER, 0, 0, logo1.instance.height);
		this._tf2 = new JText(GameConfig.FONT_SIZE_MAP * 2, 0xffff00, JText.ALIGN_CENTER, 0, 0, logo2.instance.height);
		
		this._tf0.instance.x = logo0.instance.x + logo0.instance.width * 0.5;
		this._tf1.instance.x = logo1.instance.x + logo1.instance.width * 0.5;
		this._tf2.instance.x = logo2.instance.x + logo2.instance.width * 0.5;
		this._tf0.instance.y = logo0.instance.y - logo0.instance.height * 0.5;
		this._tf1.instance.y = logo1.instance.y - logo0.instance.height * 0.5;
		this._tf2.instance.y = logo2.instance.y - logo0.instance.height * 0.5;
		
		container.addChild(this._tf0.instance);
		container.addChild(this._tf1.instance);
		container.addChild(this._tf2.instance);
		
		this.setScore(GameData.SIDE_A, 0);
		this.setScore(GameData.SIDE_B, 0);
		this.setScore(GameData.SIDE_C, 0);
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
		
		this._txt = new JText(GameConfig.FONT_SIZE_MAP, GameConfig.FONT_COLOR_MAP, JText.ALIGN_BOTTON, 0, GameConfig.CELL_RADIUS_MAP * 2, GameConfig.CELL_RADIUS_MAP * 1.732);
		var tf:TextField = this._txt.textField;
		
		//tf.background = true;
		//tf.backgroundColor = 0x88ffff88;
		tf.filters = [new GlowFilter(0xffffff, 1, GameConfig.FONT_SIZE_MAP * 0.3, GameConfig.FONT_SIZE_MAP * 0.3)//
		, new DropShadowFilter(GameConfig.FONT_SIZE_MAP * 0.1, 131, 0, 1, GameConfig.FONT_SIZE_MAP * 0.3, GameConfig.FONT_SIZE_MAP * 0.3)];
		
		this._txt.text = this._key;
		this._txt.instance.x = -GameConfig.CELL_RADIUS_MAP;
		this._txt.instance.y = -GameConfig.CELL_RADIUS_MAP;
		this.container.addChild(this._txt.instance);
		
		this._bottom.setSkin(SkinStore.TYPE_BLANK);
		this._flash.instance.visible = false;
		
		this._timer = new JTimer(this.onTime);
	}
	
	public function setMouseClear():void
	{
		this._front.setSkin(SkinStore.TYPE_NONE);
	}
	
	public function setMouseDown():void
	{
		this._front.setSkin(SkinStore.TYPE_DOWN);
	}
	
	public function setMouseOver():void
	{
		this._front.setSkin(SkinStore.TYPE_OVER);
	}
	
	private function setSkin(p_skin:SkinStoreItem, p_state:int, p_side:int):void
	{
		switch (p_state)
		{
		case GameData.STATE_BASE: 
			switch (p_side)
			{
			case GameData.SIDE_A: 
				p_skin.setSkin(SkinStore.TYPE_BASE_0);
				break;
			case GameData.SIDE_B: 
				p_skin.setSkin(SkinStore.TYPE_BASE_1);
				break;
			case GameData.SIDE_C: 
				p_skin.setSkin(SkinStore.TYPE_BASE_2);
				break;
			default: 
				p_skin.setSkin(SkinStore.TYPE_NONE);
			}
			break;
		case GameData.STATE_ATTACK: 
			p_skin.setSkin(SkinStore.TYPE_ATTACK);
			break;
		case GameData.STATE_HOSTAGE: 
			switch (p_side)
			{
			case GameData.SIDE_A: 
				p_skin.setSkin(SkinStore.TYPE_HOSTAGE_0);
				break;
			case GameData.SIDE_B: 
				p_skin.setSkin(SkinStore.TYPE_HOSTAGE_1);
				break;
			case GameData.SIDE_C: 
				p_skin.setSkin(SkinStore.TYPE_HOSTAGE_2);
				break;
			default: 
				p_skin.setSkin(SkinStore.TYPE_NONE);
			}
			break;
		case GameData.STATE_OBSTACLE: 
			p_skin.setSkin(SkinStore.TYPE_OBSTACLE);
			break;
		case GameData.STATE_ROAD: 
			switch (p_side)
			{
			case GameData.SIDE_A: 
				p_skin.setSkin(SkinStore.TYPE_ROAD_0);
				break;
			case GameData.SIDE_B: 
				p_skin.setSkin(SkinStore.TYPE_ROAD_1);
				break;
			case GameData.SIDE_C: 
				p_skin.setSkin(SkinStore.TYPE_ROAD_2);
				break;
			default: 
				p_skin.setSkin(SkinStore.TYPE_NONE);
			}
			break;
		case GameData.STATE_ROAD_EX: 
			switch (p_side)
			{
			case GameData.SIDE_A: 
				p_skin.setSkin(SkinStore.TYPE_ROAD_EX_0);
				break;
			case GameData.SIDE_B: 
				p_skin.setSkin(SkinStore.TYPE_ROAD_EX_1);
				break;
			case GameData.SIDE_C: 
				p_skin.setSkin(SkinStore.TYPE_ROAD_EX_2);
				break;
			default: 
				p_skin.setSkin(SkinStore.TYPE_NONE);
			}
			break;
		case GameData.STATE_NONE: 
		default: 
			p_skin.setSkin(SkinStore.TYPE_NONE);
		}
	}
	
	public function setState(p_state:int, p_side:int):void
	{
		this._side = p_side;
		this._state = p_state;
		this.setSkin(this._face, p_state, p_side);
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
		
		var cellWidth:int = GameConfig.CELL_RADIUS_MAP * 2 + 0.5;
		var cellHeight:int = GameConfig.CELL_RADIUS_MAP * 1.732 + 0.5;
		for (var i:int = 0; i < p_list.length; i++)
		{
			var data:MapCell = p_list[i] as MapCell;
			var key:String = String(data.id);
			var item:GameMapItem = new GameMapItem(key);
			item.instance.name = key;
			item.setState(data.state, data.side);
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