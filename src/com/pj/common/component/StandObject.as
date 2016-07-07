package com.pj.common.component
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class StandObject extends BasicObject
	{
		public function StandObject(p_inst:BasicObject):void
		{
			super(new Sprite());
			this.stand.addChild(p_inst.instance);
		}
		
		override public function dispose():void
		{
			super.dispose();
		}
		
		public function get stand():Sprite
		{
			return this.instance as Sprite;
		}
	
	}
}