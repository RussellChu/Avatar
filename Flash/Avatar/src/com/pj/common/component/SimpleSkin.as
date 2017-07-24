package com.pj.common.component
{
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class SimpleSkin extends BasicSkin
	{
		private var _currInst:DisplayObject = null;
		private var _skinMap:Object = null;
		
		public function SimpleSkin()
		{
			super();
		}
		
		override public function dispose():void
		{
			this._currInst = null;
			this._skinMap = null;
			super.dispose();
		}
		
		override protected function init():void
		{
			super.init();
			this._skinMap = {};
		}
		
		public function addSkin(p_id:int, p_skin:BasicObject):void
		{
			this._skinMap[p_id] = p_skin;
		}
		
		override public function show(p_id:int):void
		{
			var skin:BasicObject = this._skinMap[p_id];
			if (!skin)
			{
				this.container.removeChildren();
				return;
			}
			if (this._currInst == skin.instance)
			{
				return;
			}
			
			this.container.removeChildren();
			this.container.addChild(skin.instance);
		}
	
	}
}