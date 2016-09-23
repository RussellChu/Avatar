package com.pj.common.component
{
	import com.pj.common.Helper;
	import com.pj.common.IDisposable;
	import com.pj.common.IHasSignal;
	import com.pj.common.IResetable;
	import com.pj.common.JSignal;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class ToggleButtonGroup implements IDisposable, IHasSignal, IResetable
	{
		private var _list:Vector.<BasicButton> = null;
		private var _selectedIndex:int = 0;
		private var _signal:JSignal = null;
		
		public function ToggleButtonGroup()
		{
			this.init();
			this.clear();
			this.reset();
		}
		
		public function dispose():void
		{
			Helper.dispose(this._signal);
			this._list = null;
			this._signal = null;
		}
		
		protected function init():void
		{
			this._signal = new JSignal();
		}
		
		public function clear():void
		{
			this._list = new Vector.<BasicButton>();
			this._selectedIndex = -1;
			this._signal.clear();
		}
		
		public function reset():void
		{
			for (var i:int = 0; i < this._list.length; i++)
			{
				var btn:BasicButton = this._list[i];
				btn.value = false;
			}
			this._signal.reset();
		}
		
		public function addButton(p_btn:BasicButton):void
		{
			if (!p_btn)
			{
				return;
			}
			var id:int = this._list.length;
			p_btn.id = id;
			p_btn.signal.add(this.onSignal);
			this._list.push(p_btn);
		}
		
		public function get data():Object
		{
			if (this._selectedIndex < 0)
			{
				return null;
			}
			
			if (this._list.length <= this._selectedIndex)
			{
				return null;
			}
			
			return this._list[this._selectedIndex].data;
		}
		
		public function get signal():JSignal
		{
			return this._signal;
		}
		
		private function onSignal(p_result:Object):void
		{
			var action:String = p_result.action;
			var data:Object = p_result.data;
			var target:BasicButton = p_result.target as BasicButton;
			if (action != BasicButton.ACTION_VALUE_CHANGE)
			{
				return;
			}
			if (target.value)
			{
				if (this._selectedIndex > -1)
				{
					var btn:BasicButton = this._list[this._selectedIndex];
					btn.value = false;
				}
				this._selectedIndex = target.id;
				this._signal.dispatch(p_result);
			}
			else
			{
				this._selectedIndex = -1;
				this._signal.dispatch(p_result);
			}
		}
	
	}
}