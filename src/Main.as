package
{
	import com.pj.ProjectMacross;
	import com.pj.common.Helper;
	import com.pj.common.component.BasicContainer;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	//	[SWF(width = 1280, height = 800, frameRate = "60", backgroundColor = "#ffffff")]
	//	[SWF(width = 800, height = 200, frameRate = "60", backgroundColor = "#ffffff")]
	[SWF(frameRate = "60", backgroundColor = "#ffffff")]
	public class Main extends Sprite
	{
		private var _init:Boolean = false;
		private var _project:BasicContainer = null;
		
		public function Main()
		{
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			
			// for exe
			this.stage.addEventListener(Event.ACTIVATE, this.onLoad);
			// for web
			this.stage.addEventListener(Event.ENTER_FRAME, this.onLoad);
		}
		
		private function init():void
		{
			var param:Object = this.loaderInfo.parameters;
			var data:Object = {};
			if (Helper.hasValue(param, "data"))
			{
				var dataStr:String = param.data as String;
				data = JSON.parse(dataStr);
			}
			var paramStr:String = "";
			//this._project = new ProjectTest(this);
			this._project = new ProjectMacross(this, data);
			this.stage.addEventListener(Event.RESIZE, this.onResize);
		}
		
		private function onLoad(p_evt:Event):void
		{
			if (this._init)
			{
				return;
			}
			
			this._init = true;
			this.init();
			this.stage.removeEventListener(Event.ACTIVATE, this.onLoad);
			this.stage.removeEventListener(Event.ENTER_FRAME, this.onLoad);
			
			this._project.resize(this.stage.stageWidth, this.stage.stageHeight);
		}
		
		private function onResize(p_evt:Event):void
		{
			this._project.resize(this.stage.stageWidth, this.stage.stageHeight);
		}
	
	}
}