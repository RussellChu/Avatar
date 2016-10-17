package com.pj.macross
{
	
	/**
	 * ...
	 * @author Russell
	 */
	public class GameLang
	{
		static public const EVENT_LANG_UPDATE:String = "GameLang.EVENT_LANG_UPDATE";
		static public const EVENT_LOAD_LANG:String = "GameLang.EVENT_LOAD_LANG";
		static public const EVENT_SET_LANG:String = "GameLang.EVENT_SET_LANG";
		
		static public const LANG_EN:String = "en";
		static public const LANG_ZH:String = "zh";
		
		static private var __i:GameLang = null;
		
		static public function get i():GameLang
		{
			if (!__i)
			{
				__i = new GameLang();
			}
			return __i;
		}
		
		private var _lang:String = "";
		private var _map:Object = null;
		
		public function GameLang()
		{
			this._map = {};
			this._map[LANG_EN] = {};
			this._map[LANG_ZH] = {};
			this._lang = LANG_ZH;
			GameController.i.signal.add(this.onLoadLang, EVENT_LOAD_LANG);
			GameController.i.signal.add(this.onSetLang, EVENT_SET_LANG);
			this.onLoadLang({list: ["lang-00001", "Loading", "載入中"]});
		}
		
		private function loadArray(p_src:Array, p_sizeEach:int, p_func:Function):void
		{
			var result:Array;
			for (var i:int = 0; i < p_src.length; i++)
			{
				var index:int = i % p_sizeEach;
				if (index == 0)
				{
					result = [];
				}
				result.push(p_src[i]);
				if (index >= p_sizeEach - 1)
				{
					p_func(result);
				}
			}
		}
		
		public function getLang():String
		{
			return this._lang;
		}
		
		public function getValue(p_key:String):String
		{
			if (!this._map[this._lang])
			{
				return "";
			}
			if (!this._map[this._lang][p_key])
			{
				return "";
			}
			return this._map[this._lang][p_key];
		}
		
		private function onLoadLang(p_result:Object):void
		{
			var list:Array = p_result.list as Array;
			this.loadArray(list, 3, function(p_result:Array):void
			{
				if (p_result.length != 3)
				{
					return;
				}
				var key:String = p_result[0];
				var en:String = p_result[1];
				var zh:String = p_result[2];
				_map[LANG_EN][key] = en;
				_map[LANG_ZH][key] = zh;
			});
		}
		
		private function onSetLang(p_result:Object):void
		{
			this._lang = p_result.lang;
			GameController.i.signal.dispatch({}, EVENT_SET_LANG);
		}
	
	}
}