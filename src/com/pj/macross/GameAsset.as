package com.pj.macross
{
	import com.pj.common.AssetLoader;
	import com.pj.macross.asset.CellSkin;
	import com.pj.macross.asset.Galaxy;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class GameAsset
	{
		[Embed(source = "/../bin/assets/s01.png")]
		static private var BMP_S01:Class;
		[Embed(source = "/../bin/assets/s02.png")]
		static private var BMP_S02:Class;
		[Embed(source = "/../bin/assets/s03.png")]
		static private var BMP_S03:Class;
		[Embed(source = "/../bin/assets/s04.png")]
		static private var BMP_S04:Class;
		[Embed(source = "/../bin/assets/s05.png")]
		static private var BMP_S05:Class;
		[Embed(source = "/../bin/assets/s06.png")]
		static private var BMP_S06:Class;
		[Embed(source = "/../bin/assets/s07.png")]
		static private var BMP_S07:Class;
		[Embed(source = "/../bin/assets/s08.png")]
		static private var BMP_S08:Class;
		[Embed(source = "/../bin/assets/fold.png")]
		static private var BMP_FOLD:Class;
		
		static private var __loader:AssetLoader = null;
		
		static public function get loader():AssetLoader
		{
			if (!__loader)
			{
				__loader = new AssetLoader();
				__loader.addObject("s01", new BMP_S01());
				__loader.addObject("s02", new BMP_S02());
				__loader.addObject("s03", new BMP_S03());
				__loader.addObject("s04", new BMP_S04());
				__loader.addObject("s05", new BMP_S05());
				__loader.addObject("s06", new BMP_S06());
				__loader.addObject("s07", new BMP_S07());
				__loader.addObject("s08", new BMP_S08());
				__loader.addObject("fold", new BMP_FOLD());
				__loader.addCreate("galaxy", new Galaxy());
				__loader.addCreate(GameConfig.ASSET_KEY_MAP_CELL, new CellSkin(GameConfig.CELL_RADIUS_MAP * 2 + 0.5, GameConfig.CELL_RADIUS_MAP * 1.732 + 0.5, GameConfig.CELL_SIDE_MAP));
				__loader.addCreate(GameConfig.ASSET_KEY_CMD_CELL, new CellSkin(GameConfig.CELL_RADIUS_CMD * 2 + 0.5, GameConfig.CELL_RADIUS_CMD * 1.732 + 0.5, GameConfig.CELL_SIDE_CMD));
			}
			return __loader;
		}
		
		public function GameAsset()
		{
			;
		}
	
	}
}