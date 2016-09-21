package com.pj.common.component
{
	import com.pj.common.IDisposable;
	import com.pj.common.IResetable;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class ToggleButtonGroup extends EventDispatcher implements IDisposable, IResetable
	{
		private var _list:Vector.<BasicToggleButton> = null;
		private var _selectedIndex:int = 0;
		
		public function ToggleButtonGroup()
		{
			this.init();
			this.reset();
		}
		
		public function dispose():void
		{
			this._list = null;
		}
		
		protected function init():void
		{
			;
		}
		
		public function reset():void
		{
			this._list = new Vector.<BasicToggleButton>();
			this._selectedIndex = -1;
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
				}
				else
				{
					this._selectedIndex = -1;
				}
			}
		}
	
	}
}