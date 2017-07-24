package com.pj.macross.structure
{
	
	/**
	 * ...
	 * @author Russell
	 */
	public class MapCell
	{
		public var id:int = 0;
		public var keyX:int = 0;
		public var keyY:int = 0;
		public var keyZ:int = 0;
		public var posX:int = 0;
		public var posY:int = 0;
		
		public var state:int = 0;
		public var side:int = 0;
		
		public function MapCell(p_id:int, p_keyX:int, p_keyY:int, p_keyZ:int, p_posX:int, p_posY:int)
		{
			this.id = p_id;
			this.keyX = p_keyX;
			this.keyY = p_keyY;
			this.keyZ = p_keyZ;
			this.posX = p_posX;
			this.posY = p_posY;
		}
	
	}
}