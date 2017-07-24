package com.pj.macross
{
	import com.pj.common.IHasSignal;
	import com.pj.common.JSignal;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class GameController implements IHasSignal
	{
		static private var __i:GameController = null;
		
		static public function get i():GameController
		{
			if (!__i)
			{
				__i = new GameController();
			}
			return __i;
		}
		
		private var _config:Object = null;
		private var _signal:JSignal = null;
		
		public function GameController()
		{
			;
		}
		
		public function init():void
		{
			GameLang.i;
		}
		
		public function get signal():JSignal
		{
			if (!this._signal)
			{
				this._signal = new JSignal();
			}
			return this._signal;
		}
		
		public function get config():Object
		{
			return this._config;
		}
		
		public function set config(p_config:Object):void
		{
			this._config = p_config;
		}
	
	}
}