package com.pj.common.component
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class StandObject extends BasicObject
	{
		private var _initInst:BasicObject = null;
		
		public function StandObject(p_inst:BasicObject):void
		{
			this._initInst = p_inst;
			super(new Sprite());
		}
		
		override public function dispose():void
		{
			super.dispose();
		}
		
		override protected function init():void
		{
			super.init();
			this.stand.addChild(this._initInst.instance);
			this._initInst = null;
		}
		
		public function get stand():Sprite
		{
			return this.instance as Sprite;
		}
	
	}
}