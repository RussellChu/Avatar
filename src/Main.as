package
{
	import com.pj.ProjectWorld;
	import flash.display.Sprite;
	
	[SWF(width = "800", height = "800", frameRate = "60", backgroundColor = "#000044")]
	public class Main extends Sprite
	{
		public function Main():void
		{
			new ProjectWorld(this);
			//trace("Hello World!");
			//loader = new Loader();
			//loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void
			//{
			////	loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this);
			//var mc:MovieClip = loader.content as MovieClip;
			//addChild(mc);
			//});
			//loader.load(new URLRequest("basket_x000a_p78.swf"));
		}
	}

}