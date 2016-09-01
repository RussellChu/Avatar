package com.pj
{
	import com.pj.common.JColor;
	import com.pj.common.component.BasicContainer;
	import com.pj.common.component.IContainer;
	import com.pj.common.component.Slider;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class ProjectMacross extends BasicContainer
	{
		private static const MAP_START_X:int = 0;
		private static const MAP_START_Y:int = 0;
		private static const BTN_RADIUS:int = 15; // 15 or 75
		
		private var _model:GameModel = null;
		
		public function ProjectMacross(p_inst:Sprite = null)
		{
			super(null, p_inst);
		}
		
		override public function dispose():void
		{
			super.dispose();
		}
		
		override protected function init():void
		{
			super.init();
			
			this._model = new GameModel();
			
			var scrollPanel:Slider = new Slider(this, 1200, 800, this._model.getMapRadius() * BTN_RADIUS * 4, this._model.getMapRadius() * BTN_RADIUS * 4);
			
			var btnGroup:ButtonHexagonGroup = new ButtonHexagonGroup(scrollPanel, MAP_START_X, MAP_START_Y, BTN_RADIUS, new JColor(0, 1, 1, 1).value, new JColor(0.5, 0.5, 0.5, 1).value, new JColor(1, 1, 1, 1).value);
			btnGroup.createMap(this._model.getCellList());
		}
		
		override public function reset():void
		{
			super.reset();
		}
	
	}
}

import com.pj.common.JColor;
import com.pj.common.component.AbstractButton;
import com.pj.common.component.BasicButton;
import com.pj.common.component.BasicContainer;
import com.pj.common.component.IContainer;
import com.pj.common.component.SimpleButton;
import flash.display.BitmapData;

class MapCell
{
	public static const STATE_NONE:int = 0;
	public static const STATE_BASE:int = 1;
	public static const STATE_ROAD:int = 2;
	public static const STATE_ROAD_EX:int = 3;
	public static const STATE_OBSTACLE:int = 4;
	public static const STATE_HOSTAGE:int = 5;
	
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
	
	public function MapCellCroup()
	{
		this._list = [];
		this._map = {};
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
	private static const MAP_RADIUS:int = 25;
	
	private var _map:MapCellCroup = null;
	
	public function GameModel():void
	{
		this._map = new MapCellCroup();
		
		var id:int = 0;
		for (var row:int = 0; row < MAP_RADIUS * 2 - 1; row++)
		{
			var len:int = MAP_RADIUS + row;
			if (row >= MAP_RADIUS)
			{
				len = MAP_RADIUS * 3 - 2 - row;
			}
			for (var col:int = 0; col < len; col++)
			{
				var x:int = col;
				if (row >= MAP_RADIUS)
				{
					x += (row - MAP_RADIUS + 1);
				}
				var y:int = row;
				var z:int = (row + 1) * 2 - x - y;
				var posX:int = MAP_RADIUS - 1 + (x - row) * 2 + y;
				var posY:int = y;
				
				this._map.addCell(id, x, y, z, posX, posY);
				
				id++;
			}
		}
	}
	
	public function addObstacle(p_side:int, p_keyX:int, p_keyY:int, p_keyZ:int):Boolean {
		var cell:MapCell = this._map.getCellByKey(p_keyX, p_keyY, p_keyZ);
		if (!cell) {
			return false;
		}
		
		return true;
	}
	
	public function addHostage(p_side:int, p_keyX:int, p_keyY:int, p_keyZ:int):Boolean {
		var cell:MapCell = this._map.getCellByKey(p_keyX, p_keyY, p_keyZ);
		if (!cell) {
			return false;
		}
		
		return true;
	}
	
	public function addRoad(p_side:int, p_keyX:int, p_keyY:int, p_keyZ:int):Boolean {
		var cell:MapCell = this._map.getCellByKey(p_keyX, p_keyY, p_keyZ);
		if (!cell) {
			return false;
		}
		
		return true;
	}
	
	public function addRoadEx(p_side:int, p_keyX:int, p_keyY:int, p_keyZ:int):Boolean {
		var cell:MapCell = this._map.getCellByKey(p_keyX, p_keyY, p_keyZ);
		if (!cell) {
			return false;
		}
		
		return true;
	}
	
	public function clearCell(p_keyX:int, p_keyY:int, p_keyZ:int):Boolean {
		var cell:MapCell = this._map.getCellByKey(p_keyX, p_keyY, p_keyZ);
		if (!cell) {
			return false;
		}
		
		return true;
	}
	
	public function getCellList():Array
	{
		return this._map.getList();
	}
	
	public function getMapRadius():int
	{
		return MAP_RADIUS;
	}

}

class ButtonHexagon extends BasicButton
{
	public function ButtonHexagon(p_title:String, p_width:int, p_height:int, p_bmpDown:BitmapData, p_bmpIdle:BitmapData, p_bmpOver:BitmapData, p_data:Object = null):void
	{
		super(p_title, p_width, p_height, p_bmpDown, p_bmpIdle, p_bmpOver, p_data);
	}
}

class ButtonHexagonGroup extends BasicContainer
{
	private var _mapColor:Object = null;
	
	private var _startX:Number = 0;
	private var _startY:Number = 0;
	private var _valBtnW:Number = 0;
	private var _valBtnH:Number = 0;
	private var _colorDown:uint = 0;
	private var _colorIdle:uint = 0;
	private var _colorOver:uint = 0;
	
	private var _bmpDown:BitmapData = null;
	private var _bmpIdle:BitmapData = null;
	private var _bmpOver:BitmapData = null;
	
	private var _mapBtn:Object = null;
	
	public function ButtonHexagonGroup(p_parent:IContainer, p_startX:Number, p_startY:Number, p_valBtnRadius:Number, p_colorDown:uint, p_colorIdle:uint, p_colorOver:uint):void
	{
		this._startX = p_startX;
		this._startY = p_startY;
		this._valBtnW = p_valBtnRadius * 2;
		this._valBtnH = p_valBtnRadius * 1.732;
		this._colorDown = p_colorDown;
		this._colorIdle = p_colorIdle;
		this._colorOver = p_colorOver;
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
		
		this._bmpDown = new BitmapData(this._valBtnW, this._valBtnH, true, 0);
		this._bmpIdle = new BitmapData(this._valBtnW, this._valBtnH, true, 0);
		this._bmpOver = new BitmapData(this._valBtnW, this._valBtnH, true, 0);
		this._bmpDown.lock();
		this._bmpIdle.lock();
		this._bmpOver.lock();
		
		for (var i:int = 0; i < int(this._valBtnW); i++)
		{
			for (var j:int = 0; j < (this._valBtnH); j++)
			{
				var b0:Boolean = (4 * this._valBtnH * i + 2 * this._valBtnW * j - this._valBtnW * this._valBtnH > 0);
				var b1:Boolean = (-4 * this._valBtnH * i + 2 * this._valBtnW * j - this._valBtnW * this._valBtnH < 0);
				var b2:Boolean = (4 * this._valBtnH * i + 2 * this._valBtnW * j - 5 * this._valBtnW * this._valBtnH < 0);
				var b3:Boolean = (-4 * this._valBtnH * i + 2 * this._valBtnW * j + 3 * this._valBtnW * this._valBtnH > 0);
				if (b0 && b1 && b2 && b3)
				{
					this._bmpDown.setPixel32(i, j, this._colorDown);
					this._bmpIdle.setPixel32(i, j, this._colorIdle);
					this._bmpOver.setPixel32(i, j, this._colorOver);
				}
			}
		}
		this._bmpDown.unlock();
		this._bmpIdle.unlock();
		this._bmpOver.unlock();
	}
	
	public override function reset():void
	{
		super.reset();
	}
	
	private function getBmpBtn(p_state:int, p_side:int):BitmapData {
		return null;
	}
	
	public function createMap(p_list:Array):void
	{
		
		this._mapBtn = {};
		
		for (var i:int = 0; i < p_list.length; i++)
		{
			var data:MapCell = p_list[i] as MapCell;
			var btn:ButtonHexagon = new ButtonHexagon("" + data.keyX + "-" + data.keyY, this._valBtnW, this._valBtnH, this._bmpDown, this._bmpIdle, this._bmpOver, data);
			this._mapBtn[data.id] = btn;
			btn.instance.x = this._startX + data.posX * this._valBtnW * 0.5;
			btn.instance.y = this._startY + data.posY * this._valBtnH;
			this.addChild(btn);
		}
	}

}