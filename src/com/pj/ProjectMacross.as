package com.pj
{
	import com.pj.common.Helper;
	import com.pj.common.component.BasicContainer;
	import com.pj.macross.GameAsset;
	import com.pj.macross.GameData;
	import com.pj.macross.GameModel;
	import com.pj.macross.GameView;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class ProjectMacross extends BasicContainer
	{
		private var _assetReady:Boolean = false;
		private var _width:int = 0;
		private var _height:int = 0;
		private var _model:GameModel = null;
		private var _view:GameView = null;
		
		public function ProjectMacross(p_inst:Sprite = null)
		{
			super(null, p_inst);
		}
		
		override public function dispose():void
		{
			Helper.dispose(this._model);
			Helper.dispose(this._view);
			this._model = null;
			this._view = null;
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
			this._width = p_width;
			this._height = p_height;
			if (!this._assetReady)
			{
				return;
			}
			this._view.resize(this._width, this._height);
		}
		
		private function onModelEvent_LoadComplete(p_result:Object):void {
			var list:Array = p_result.list as Array;
			this._view.createMap(list);
		}
		
		private function onModelEvent_CellUpdate(p_result:Object):void {
			var id:String = String(p_result.id);
			var side:int = p_result.side;
			var state:int = p_result.state;
			this._view.updateMap(id, side, state);
		}
		
		private function onModelEvent_ScoreUpdate(p_result:Object):void {
			var side:int = p_result.side;
			var score:int = p_result.score;
			this._view.updateScore(side, score);
		}
		
		private function onViewEvent_CmdClick(p_result:Object):void {
			var side:int = p_result.side;
			var command:int = p_result.command;
			var list:Array = this._model.getMovableList(command, side);
			var state:int = 0;
			if (command == GameData.COMMAND_ROAD_EX)
			{
				state = GameData.STATE_ROAD_EX;
			}
			else
			{
				state = GameData.STATE_ROAD;
			}
			this._view.flashMap(side, state, list);
		}
		
		private function onViewEvent_MapClick(p_result:Object):void {
			var id:int = p_result.id;
			var side:int = p_result.side;
			var command:int = p_result.command;
			this._model.command(id, side, command);
		}
		
		private function onAssetLoaded(p_result:Object):void
		{
			this._model = new GameModel();
			this._view = new GameView();
			this.container.addChild(this._view.instance);
			
			this._assetReady = true;
			
			this._model.signal.add(this.onModelEvent_LoadComplete, GameModel.EVENT_LOAD_COMPLETE);
			this._model.signal.add(this.onModelEvent_CellUpdate, GameModel.EVENT_CELL_UPDATE);
			this._model.signal.add(this.onModelEvent_ScoreUpdate, GameModel.EVENT_SCORE_UPDATE);
			
			this._view.signal.add(this.onViewEvent_CmdClick, GameView.EVENT_CMD_CLICK);
			this._view.signal.add(this.onViewEvent_MapClick, GameView.EVENT_MAP_CLICK);
			
			this._model.start();
			
			this.resize(this._width, this._height);
		}
		
	}
}