package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	public class Main extends Sprite
	{
		public function Main():void
		{
			//trace("Hello World!");
			//loader = new Loader();
			//loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void
			//{
			////	loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this);
			//var mc:MovieClip = loader.content as MovieClip;
			//addChild(mc);
			//});
			//loader.load(new URLRequest("basket_x000a_p78.swf"));
			
			for (var i:int = 0; i < 1000; i++)
			{
				var sp:Sprite = this.createCircle(5);
				sp.x = Math.random() * 500;
				sp.y = Math.random() * 500;
				this.addChild(sp);
			}
		}
		
		private function createCircle(p_radius:int):Sprite
		{
			var sp:Sprite = new Sprite();
			var bmpData:BitmapData = new BitmapData(p_radius * 2 + 1, p_radius * 2 + 1, true, 0);
			bmpData.lock();
			for (var i:int = -p_radius; i <= p_radius; i++)
			{
				for (var j:int = -p_radius; j <= p_radius; j++)
				{
					if (i * i + j * j <= (p_radius - 0.5) * (p_radius - 0.5))
					{
						bmpData.setPixel32(i + p_radius, j + p_radius, 0xffff0000);
					}
				}
			}
			bmpData.unlock();
			var bmp:Bitmap = new Bitmap(bmpData);
			bmp.x = -p_radius;
			bmp.y = -p_radius;
			//	bmp.alpha = 0.5;
			sp.addChild(bmp);
			return sp;
		}
	}
}

import flash.display.Sprite;

interface Disposable
{
	function dispose():void
}

class Helper
{
	public static function dispose(p_obj:Object):void
	{
		if (!p_obj)
		{
			return;
		}
		if (p_obj is Disposable)
		{
			(p_obj as Disposable).dispose();
		}
		if (p_obj is Vector.<*>)
		{
			for each (var item:Object in p_obj)
			{
				dispose(item);
			}
		}
	}
}

class World3D extends Sprite implements Disposable
{
	private var _child:Vector.<Sprite> = null;
	
	public function World3D():void
	{
		;
	}
	
	public function dispose():void
	{
		Helper.dispose(this._child);
		this._child = null;
	}
}