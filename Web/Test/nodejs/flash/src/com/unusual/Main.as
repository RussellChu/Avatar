package com.unusual
{
	import com.unusual.avatar.Avatar;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.system.Security;
	
	/**
	 * ...
	 * @author Russell
	 */
	[SWF(frameRate = "30", width = "500", height = "500")]
	public class Main extends MovieClip
	{
		static private const FULL_WIDTH:int = 500;
		static private const FULL_HEIGHT:int = 500;
		
		private var _avatar:Avatar = null;
		
		public function Main()
		{
			if (stage)
			{
				this.init();
			}
			else
			{
				this.addEventListener(Event.ADDED_TO_STAGE, this.init);
			}
		}
		
		private function init(e:Event = null):void
		{
			trace('Init avatar');
			
			this.removeEventListener(Event.ADDED_TO_STAGE, this.init);
			// entry point
			
			this.addEventListener(Event.DEACTIVATE, this.remove);
			
			Security.allowDomain("*");
			
			this._avatar = new Avatar(this);
			
			if (ExternalInterface.available)
			{
				ExternalInterface.addCallback("execute", this.execute);
				ExternalInterface.call("onSwfDataReceived", {action: 'init', width: FULL_WIDTH, height: FULL_HEIGHT, assets: this._avatar.getAssetsData()});
			}
			else
			{
				trace('ExternalInterface not available');
			}
		}
		
		private function remove(e:Event = null):void
		{
			this.removeEventListener(Event.DEACTIVATE, this.remove);
			
			if (this._avatar)
			{
				this._avatar.dispose();
				this._avatar = null;
			}
			
			trace('Dispose avatar');
		}
		
		private function extLog(msg:String):void
		{
			if (ExternalInterface.available)
			{
				ExternalInterface.call("onSwfDataReceived", {action: 'log', msg: msg});
			}
		}
		
		public function execute(data:Object = null):void
		{
			if (!data)
			{
				return;
			}
			
			this.extLog('execute >> ' + JSON.stringify(data));
			
			var action:String = data.action;
			var body:Boolean = false;
			var layer:int = 0;
			switch (action)
			{
			case 'clear': 
				if (!data.hasOwnProperty('body'))
				{
					this.extLog('clearLayer fail');
				}
				body = data.body as Boolean;
				this._avatar.clear(body);
				break;
			case 'clearLayer': 
				if (!data.hasOwnProperty('layer') || //
				!data.hasOwnProperty('body') //
				)
				{
					this.extLog('clearLayer fail');
				}
				body = data.body as Boolean;
				layer = data.layer as int;
				this._avatar.clearLayer(layer, body);
				break;
			case 'init': 
				if (!data.hasOwnProperty('layer'))
				{
					this.extLog('init fail');
				}
				layer = data.layer as int;
				this._avatar.initLayer(layer);
				break;
			case 'show': 
				if (!data.hasOwnProperty('name') || //
				!data.hasOwnProperty('layer') || //
				!data.hasOwnProperty('x') || //
				!data.hasOwnProperty('y') || //
				!data.hasOwnProperty('body') //
				)
				{
					this.extLog('show fail');
				}
				var name:String = data.name as String;
				layer = data.layer as int;
				var posX:int = data.x as int;
				var posY:int = data.y as int;
				body = data.body as Boolean;
				this._avatar.showItem(layer, name, posX, posY, body);
				break;
			default:
				
			}
		}
	
	}
}