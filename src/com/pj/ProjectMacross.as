package com.pj
{
	import com.pj.common.AssetLoader;
	import com.pj.common.Helper;
	import com.pj.common.component.BasicContainer;
	import com.pj.macross.GameAsset;
	import com.pj.macross.GameConfig;
	import com.pj.macross.GameController;
	import com.pj.macross.GameData;
	import com.pj.macross.GameLang;
	import com.pj.macross.GameModel;
	import com.pj.macross.GameView;
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class ProjectMacross extends BasicContainer
	{
		private var _assetReady:Boolean = false;
		private var _width:int = 0;
		private var _height:int = 0;
		private var _layer:Sprite = null;
		private var _loading:LoadingPanel = null;
		private var _model:GameModel = null;
		private var _param:Object = null;
		private var _view:GameView = null;
		
		public function ProjectMacross(p_inst:Sprite = null, p_param:Object = null)
		{
			this._param = p_param;
			super(null, p_inst);
		}
		
		override public function dispose():void
		{
			Helper.dispose(this._loading);
			Helper.dispose(this._model);
			Helper.dispose(this._view);
			this._layer = null;
			this._loading = null;
			this._model = null;
			this._view = null;
			super.dispose();
		}
		
		override protected function init():void
		{
			super.init();
			GameController.i.init();
			this._layer = new Sprite();
			this._loading = new LoadingPanel();
			this.container.addChild(this._layer);
			this.container.addChild(this._loading.instance);
			GameAsset.loader.signal.add(this.onAssetLoading, AssetLoader.EVENT_LOADING);
			GameAsset.loader.signal.add(this.onAssetLoaded, AssetLoader.EVENT_COMPLETE);
			GameAsset.loader.load();
		}
		
		override public function reset():void
		{
			super.reset();
		}
		
		override public function resize(p_width:int, p_height:int):void
		{
			this._width = p_width;
			this._height = p_height;
			this._loading.resize(p_width, p_height);
			if (!this._assetReady)
			{
				return;
			}
			this._view.resize(this._width, this._height);
		}
		
		private function onModelEvent_CellUpdate(p_result:Object):void
		{
			var id:String = String(p_result.id);
			var side:int = p_result.side;
			var state:int = p_result.state;
			this._view.updateMap(id, side, state);
		}
		
		private function onModelEvent_CreateResult(p_result:Object):void
		{
			var isReady:Boolean = p_result.isReady;
			if (isReady)
			{
				//trace("o: " + JSON.stringify(p_result.obstage));
				//trace("a: " + JSON.stringify(p_result.hostageA));
				//trace("b: " + JSON.stringify(p_result.hostageB));
				//trace("c: " + JSON.stringify(p_result.hostageC));
				this._view.capMap(GameConfig.CAP_ID);
			}
		}
		
		private function onModelEvent_LoadComplete(p_result:Object):void
		{
			var list:Array = p_result.list as Array;
			this._view.createMap(list);
			this._loading.leave();
		}
		
		private function onModelEvent_ScoreUpdate(p_result:Object):void
		{
			var side:int = p_result.side;
			var score:int = p_result.score;
			this._view.updateScore(side, score);
		}
		
		private function onViewEvent_CmdClick(p_result:Object):void
		{
			var command:int = p_result.command;
			switch (command)
			{
			case GameData.COMMAND_ROAD: 
			case GameData.COMMAND_ROAD_EX: 
			case GameData.COMMAND_ATTACK: 
				var side:int = p_result.side;
				var state:int = GameData.STATE_NONE;
				var list:Array = this._model.getMovableList(command, side);
				if (command == GameData.COMMAND_ROAD_EX)
				{
					state = GameData.STATE_ROAD_EX;
					this._view.flashMap(side, state, list);
				}
				else
				{
					state = GameData.STATE_ROAD;
				}
				this._view.flashMap(side, state, list);
				break;
			case GameData.COMMAND_UNDO: 
				this._model.undo();
				break;
			case GameData.COMMAND_CLEAR: 
				while (this._model.undo()){};
				break;
			default: 
				;
			}
		}
		
		private function onViewEvent_MapClick(p_result:Object):void
		{
			var id:int = p_result.id;
			var side:int = p_result.side;
			var command:int = p_result.command;
			this._model.command(id, side, command);
		}
		
		private function onAssetLoaded(p_result:Object):void
		{
			var ba:ByteArray = GameAsset.loader.getAsset(GameAsset.KEY_CONFIG) as ByteArray;
			var str:String = ba.toString();
			var obj:Object = JSON.parse(str);
			GameController.i.config = obj;
			GameController.i.signal.dispatch({list: GameController.i.config.lang}, GameLang.EVENT_LOAD_LANG);
			
			this._model = new GameModel();
			this._view = new GameView();
			this._layer.addChild(this._view.instance);
			
			this._assetReady = true;
			
			GameController.i.signal.add(this.onModelEvent_CellUpdate, GameModel.EVENT_CELL_UPDATE);
			GameController.i.signal.add(this.onModelEvent_CreateResult, GameModel.EVENT_CREATE_RESULT);
			GameController.i.signal.add(this.onModelEvent_LoadComplete, GameModel.EVENT_LOAD_COMPLETE);
			GameController.i.signal.add(this.onModelEvent_ScoreUpdate, GameModel.EVENT_SCORE_UPDATE);
			GameController.i.signal.add(this.onViewEvent_CmdClick, GameView.EVENT_CMD_CLICK);
			GameController.i.signal.add(this.onViewEvent_MapClick, GameView.EVENT_MAP_CLICK);
			
			this._model.start();
			
			this.resize(this._width, this._height);
		}
		
		private function onAssetLoading(p_result:Object):void
		{
			var index:int = p_result.index;
			var total:int = p_result.total;
			this._loading.update(index, total);
		}
	
	}
}

import com.pj.common.Helper;
import com.pj.common.JTimer;
import com.pj.common.component.BasicObject;
import com.pj.common.component.JText;
import com.pj.common.component.Quad;
import com.pj.macross.GameController;
import com.pj.macross.GameLang;
import flash.display.Sprite;

class LoadingPanel extends BasicObject
{
	private var _bg:Quad = null;
	private var _leave:int = 0;
	private var _msg:String = "";
	private var _timer:JTimer = null;
	private var _txt:JText = null;
	private var _value:Number = 0;
	
	public function LoadingPanel()
	{
		super();
	}
	
	override public function dispose():void
	{
		Helper.dispose(this._bg);
		Helper.dispose(this._timer);
		Helper.dispose(this._txt);
		this._bg = null;
		this._timer = null;
		this._txt = null;
		super.dispose();
	}
	
	override protected function init():void
	{
		super.init();
		
		this._bg = new Quad(1, 1, 0xffffff);
		(this.instance as Sprite).addChild(this._bg.instance);
		
		this._txt = new JText(12, 0, JText.ALIGN_CENTER);
		this._txt.text = "";
		(this.instance as Sprite).addChild(this._txt.instance);
		
		GameController.i.signal.add(this.onLangUpdate, GameLang.EVENT_LANG_UPDATE);
		
		this._timer = new JTimer(this.onTime);
		this._timer.start();
	}
	
	private function onTime(p_delta:Number):void
	{
		var preValue:Number = this._value
		this._value += 0.2;
		if (this._value > 1)
		{
			this._value -= 2;
		}
		if (this._leave == 1)
		{
			if (preValue > 0 && this._value < 0)
			{
				this._leave = 2;
			}
		}
		if (this._leave == 2)
		{
			if (preValue < 0 && this._value > 0)
			{
				this._leave = 3;
				this._timer.stop();
				this.instance.visible = false;
				return;
			}
		}
		if (this._leave == 2)
		{
			this._bg.instance.alpha = Math.abs(this._value);
		}
		this._txt.instance.alpha = Math.abs(this._value);
	}
	
	public function leave():void
	{
		if (this._leave == 0)
		{
			this._leave = 1;
		}
	}
	
	public function resize(p_width:int, p_height:int):void
	{
		this._bg.instance.scaleX = p_width;
		this._bg.instance.scaleY = p_height;
		this._txt.instance.x = (p_width - this._txt.instance.width) * 0.5;
		this._txt.instance.y = (p_height - this._txt.instance.height) * 0.5;
	}
	
	public function update(p_index:int, p_total:int):void
	{
		this._msg = ": " + (p_total - p_index) + " / " + p_total;
		this.onLangUpdate(null);
	}
	
	private function onLangUpdate(p_result:Object):void
	{
		this._txt.text = GameLang.i.getValue("text-00001") + this._msg;
	}

}