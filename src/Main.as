package
{
	import com.pj.ProjectFlash3D;
	import com.pj.ProjectMacross;
	import com.pj.ProjectMP4;
	import com.pj.ProjectWorld;
	import com.pj.common.component.BasicContainer;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
//	[SWF(width = 1280, height = 800, frameRate = "60", backgroundColor = "#ffffff")]
	[SWF(frameRate = "60", backgroundColor = "#ffffff")]
	public class Main extends Sprite
	{
		private var _init:Boolean = false;
		private var _project:BasicContainer = null;
		
		public function Main():void
		{
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			//new ProjectWorld(this);
			//new ProjectFlash3D(this);
			// new ProjectMacross(this);
			//new ProjectMP4(this);
			//trace("Hello World!");
			//loader = new Loader();
			//loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void
			//{
			//loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this);
			//var mc:MovieClip = loader.content as MovieClip;
			//addChild(mc);
			//});
			//loader.load(new URLRequest("basket_x000a_p78.swf"));
			this.stage.addEventListener(Event.ACTIVATE, this.onStage);
		}
		
		private function init():void
		{
			this._project = new ProjectMacross(this);
			this.stage.addEventListener(Event.RESIZE, this.onResize);
		}
		
		private function onResize(p_evt:Event):void
		{
			this._project.resize(this.stage.stageWidth, this.stage.stageHeight);
		}
		
		private function onStage(p_evt:Event):void
		{
			if (this._init)
			{
				return;
			}
			
			this._init = true;
			this.init();
		}
	
	}
}