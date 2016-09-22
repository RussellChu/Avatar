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
		private var _list:Vector.<BasicToggleButton> = null;
		private var _selectedIndex:int = 0;
		private var _signal:JSignal = null;
		
		public function ToggleButtonGroup()
		{
			this.init();
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
		
		public function reset():void
		{
			this._list = new Vector.<BasicToggleButton>();
			this._selectedIndex = -1;
			this._signal.reset();
		}
		
		public function setDefault():void {
			for (var i:int = 0; i < this._list.length; i++) {
				var btn:BasicToggleButton = this._list[i];
				btn.value = false;
			}
		}
		
		public function addButton(p_btn:BasicToggleButton):void
		{
			if (!p_btn)
			{
				return;
			}
			var id:int = this._list.length;
			p_btn.setId(id);
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
			if (action == AbstractButton.ACTION_CLICK)
			{
				var id:int = p_result.id;
				var value:Boolean = p_result.value;
				if (value)
				{
					if (this._selectedIndex > -1)
					{
						var btn:BasicToggleButton = this._list[this._selectedIndex];
						btn.value = false;
					}
					this._selectedIndex = id;
					this._signal.dispatch(data);
				}
				else
				{
					this._selectedIndex = -1;
					this._signal.dispatch(null);
				}
			}
		}
	
	}
}