package com.pj
{
	import com.pj.common.component.BasicContainer;
	import com.pj.common.component.IContainer;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class ProjectMacross extends BasicContainer
	{
		private static const MAP_CENTER_X:int = 300;
		private static const MAP_CENTER_Y:int = 300;
		private static const MAP_WIDTH:int = 600;
		private static const MAP_RADIUS:int = 20;
		private static const BOX_RADIUS:int = 6;
		
		public function ProjectMacross(p_inst:Sprite = null)
		{
			super(null, p_inst);
		}
		
		override protected function init():void{
			super.init();
		}
	
	}

}