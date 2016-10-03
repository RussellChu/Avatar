package com.pj.macross
{
	import com.pj.common.component.BasicObject;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class GameView extends BasicObject
	{
		private var _map:GameMap = null;
		
		public function GameView()
		{
			super();
		}
		
		override protected function init():void
		{
			super.init();
			
			var store:SkinStore = new SkinStore();
			this._map = new GameMap(store);
			this.container.addChild(this._map.instance);
		}
		
		public function createMap(p_list:Array):void
		{
			this._map.create(p_list);
		}
		
		private function get container():Sprite
		{
			return (this.instance as Sprite);
		}
	
	}

}

import com.pj.common.Helper;
import com.pj.common.component.BasicContainer;
import com.pj.common.component.BasicImage;
import com.pj.common.component.BasicObject;
import com.pj.macross.GameAsset;
import com.pj.macross.GameConfig;
import com.pj.macross.GameData;
import com.pj.macross.asset.CellSkin;
import com.pj.macross.structure.MapCell;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;

class SkinStoreItem extends BasicObject
{
	private var _skin:BasicObject = null;
	private var _store:SkinStore = null;
	private var _type:int = 0;
	
	public function SkinStoreItem(p_store:SkinStore)
	{
		this._skin = null;
		this._store = p_store;
		this._type = SkinStore.TYPE_NONE;
		super();
	}
	
	override public function dispose():void
	{
		this._skin = null;
		this._store = null;
		this._skin = null;
		super.dispose();
	}
	
	override protected function init():void
	{
		super.init();
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
	
	private var _map:Object = null;
	
	public function SkinStore()
	{
		this._map = {};
		this._map[String(TYPE_BLANK)] = [];
		this._map[String(TYPE_BASE_0)] = [];
		this._map[String(TYPE_BASE_1)] = [];
		this._map[String(TYPE_BASE_2)] = [];
		this._map[String(TYPE_ROAD_0)] = [];
		this._map[String(TYPE_ROAD_1)] = [];
		this._map[String(TYPE_ROAD_2)] = [];
		this._map[String(TYPE_ROAD_EX_0)] = [];
		this._map[String(TYPE_ROAD_EX_1)] = [];
		this._map[String(TYPE_ROAD_EX_2)] = [];
		this._map[String(TYPE_ATTACK)] = [];
		this._map[String(TYPE_HOSTAGE_0)] = [];
		this._map[String(TYPE_HOSTAGE_1)] = [];
		this._map[String(TYPE_HOSTAGE_2)] = [];
		this._map[String(TYPE_OBSTACLE)] = [];
		this._map[String(TYPE_HOSTAGE_BG_0)] = [];
		this._map[String(TYPE_HOSTAGE_BG_1)] = [];
		this._map[String(TYPE_HOSTAGE_BG_2)] = [];
		this._map[String(TYPE_OVER)] = [];
		this._map[String(TYPE_DOWN)] = [];
	}
	
	public function borrow(p_type:int):BasicObject
	{
		if (!Helper.hasValue(this._map, String(p_type)))
		{
			return null;
		}
		
		var item:BasicObject = null;
		var list:Array = this._map[String(p_type)] as Array;
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
			item = GameAsset.loader.getAsset(GameAsset.getHostageKeyById(0, GameData.SIDE_A)) as BasicObject;
			item.instance.scaleX = 0.5;
			item.instance.scaleY = 0.5;
			break;
		case TYPE_HOSTAGE_1: 
			item = GameAsset.loader.getAsset(GameAsset.getHostageKeyById(0, GameData.SIDE_B)) as BasicObject;
			item.instance.scaleX = 0.5;
			item.instance.scaleY = 0.5;
			break;
		case TYPE_HOSTAGE_2: 
			item = GameAsset.loader.getAsset(GameAsset.getHostageKeyById(0, GameData.SIDE_C)) as BasicObject;
			item.instance.scaleX = 0.5;
			item.instance.scaleY = 0.5;
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
		
		if (addFold) {
			var bg:BasicObject = item;
			var container:BasicContainer = new BasicContainer();
			var fold:BasicObject = GameAsset.loader.getAsset(GameAsset.KEY_FOLD_MC) as BasicObject;
			fold.instance.scaleX = 0.5;
			fold.instance.scaleY = 0.5;
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
		if (!Helper.hasValue(this._map, String(p_type)))
		{
			return;
		}
		var list:Array = this._map[String(p_type)] as Array;
		list.push(p_item);
	}

}

class ButtonGroupItem
{
	private var _btn:BasicObject = null;
	private var _x:int = 0;
	private var _y:int = 0;
	private var _radius:int = 0;
	
	public function ButtonGroupItem(p_btn:BasicObject, p_x:int, p_y:int, p_radius:int)
	{
		this._btn = p_btn;
		this._x = p_x;
		this._y = p_y;
		this._radius = p_radius;
	}
	
	public function get btn():BasicObject  { return this._btn; }
	
	public function get x():int  { return this._x; }
	
	public function get y():int  { return this._y; }
	
	public function get radius():int  { return this._radius; }
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
	
	private function get container():Sprite
	{
		return (this.instance as Sprite);
	}
	
	public function add(p_btn:BasicObject, p_x:int, p_y:int, p_radius:int):void
	{
		var item:ButtonGroupItem = new ButtonGroupItem(p_btn, p_x, p_y, p_radius);
		p_btn.instance.x = p_x;
		p_btn.instance.y = p_y;
		this.container.addChild(p_btn.instance);
	}
	
	public function generate():void
	{
		;
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
	
	private var _bottom:SkinStoreItem = null;
	private var _face:SkinStoreItem = null;
	private var _flash:SkinStoreItem = null;
	private var _front:SkinStoreItem = null;
	private var _store:SkinStore = null;
	
	public function GameMapItem(p_store:SkinStore, p_key:String):void
	{
		this._key = p_key;
		this._store = p_store;
		super();
	}
	
	override public function dispose():void
	{
		Helper.dispose(this._bottom);
		Helper.dispose(this._face);
		Helper.dispose(this._flash);
		Helper.dispose(this._front);
		this._bottom = null;
		this._face = null;
		this._flash = null;
		this._front = null;
		this._store = null;
		super.dispose();
	}
	
	override protected function init():void
	{
		super.init();
		
		this.container.mouseChildren = false;
		//	this.container.mouseEnabled = false;
		
		this._bottom = new SkinStoreItem(this._store);
		this._face = new SkinStoreItem(this._store);
		this._flash = new SkinStoreItem(this._store);
		this._front = new SkinStoreItem(this._store);
		this.container.addChild(this._bottom.instance);
		this.container.addChild(this._face.instance);
		this.container.addChild(this._flash.instance);
		this.container.addChild(this._front.instance);
		
		this._bottom.setSkin(SkinStore.TYPE_BLANK);
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
	
	public function setState(p_state:int, p_side:int):void
	{
		switch (p_state)
		{
		case GameData.STATE_BASE: 
			switch (p_side)
			{
			case GameData.SIDE_A: 
				this._face.setSkin(SkinStore.TYPE_BASE_0);
				break;
			case GameData.SIDE_B: 
				this._face.setSkin(SkinStore.TYPE_BASE_1);
				break;
			case GameData.SIDE_C: 
				this._face.setSkin(SkinStore.TYPE_BASE_2);
				break;
			default: 
				this._face.setSkin(SkinStore.TYPE_NONE);
			}
			break;
		case GameData.STATE_ATTACK: 
			this._face.setSkin(SkinStore.TYPE_ATTACK);
			break;
		case GameData.STATE_HOSTAGE: 
			switch (p_side)
			{
			case GameData.SIDE_A: 
				this._face.setSkin(SkinStore.TYPE_HOSTAGE_0);
				break;
			case GameData.SIDE_B: 
				this._face.setSkin(SkinStore.TYPE_HOSTAGE_1);
				break;
			case GameData.SIDE_C: 
				this._face.setSkin(SkinStore.TYPE_HOSTAGE_2);
				break;
			default: 
				this._face.setSkin(SkinStore.TYPE_NONE);
			}
			break;
		case GameData.STATE_OBSTACLE: 
			this._face.setSkin(SkinStore.TYPE_OBSTACLE);
			break;
		case GameData.STATE_ROAD: 
			switch (p_side)
			{
			case GameData.SIDE_A: 
				this._face.setSkin(SkinStore.TYPE_ROAD_0);
				break;
			case GameData.SIDE_B: 
				this._face.setSkin(SkinStore.TYPE_ROAD_1);
				break;
			case GameData.SIDE_C: 
				this._face.setSkin(SkinStore.TYPE_ROAD_2);
				break;
			default: 
				this._face.setSkin(SkinStore.TYPE_NONE);
			}
			break;
		case GameData.STATE_ROAD_EX: 
			switch (p_side)
			{
			case GameData.SIDE_A: 
				this._face.setSkin(SkinStore.TYPE_ROAD_EX_0);
				break;
			case GameData.SIDE_B: 
				this._face.setSkin(SkinStore.TYPE_ROAD_EX_1);
				break;
			case GameData.SIDE_C: 
				this._face.setSkin(SkinStore.TYPE_ROAD_EX_2);
				break;
			default: 
				this._face.setSkin(SkinStore.TYPE_NONE);
			}
			break;
		default: 
			this._face.setSkin(SkinStore.TYPE_NONE);
		}
	}
	
	private function get container():Sprite
	{
		return (this.instance as Sprite);
	}
}

class GameMap extends ButtonGroup
{
	private var _itemMap:Object = null;
	private var _downKey:String = "";
	private var _overKey:String = "";
	private var _xMax:int = 0;
	private var _yMax:int = 0;
	private var _store:SkinStore = null;
	
	public function GameMap(p_store:SkinStore)
	{
		this._store = p_store;
		super();
	}
	
	override public function dispose():void
	{
		this._itemMap = null;
		this._store = null;
		super.dispose();
	}
	
	override protected function init():void
	{
		super.init();
		this._itemMap = {};
	}
	
	public function create(p_list:Array):void
	{
		var cellSkin:CellSkin = GameAsset.loader.getAsset(GameConfig.ASSET_KEY_MAP_CELL) as CellSkin;
		for (var i:int = 0; i < p_list.length; i++)
		{
			var data:MapCell = p_list[i] as MapCell;
			var key:String = String(data.id);
			var item:GameMapItem = new GameMapItem(this._store, key);
			item.instance.name = key;
			item.setState(data.state, data.side);
			//	item.setSkin(SkinStore.TYPE_BLANK);
			var posX:int = data.posX * int(cellSkin.width * 0.75) + cellSkin.width;
			var posY:int = data.posY * int(cellSkin.height * 0.5) + cellSkin.height;
			if (posX > this._xMax)
			{
				this._xMax = posX;
			}
			if (posY > this._yMax)
			{
				this._yMax = posY;
			}
			this.add(item, posX, posY, 0);
			
			this._itemMap[key] = item;
		}
		this._xMax += cellSkin.width;
		this._yMax += cellSkin.height;
		this.generate();
	}
	
	private function findItem(p_key:String):GameMapItem
	{
		if (!Helper.hasValue(this._itemMap, p_key))
		{
			return null;
		}
		
		return this._itemMap[p_key] as GameMapItem;
	}
	
	override protected function onMouseClick(p_evt:MouseEvent):void
	{
		//	this.signal.dispatch({action: ACTION_CLICK, data: this._data, target: this});
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