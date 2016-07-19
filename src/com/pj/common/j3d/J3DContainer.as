package com.pj.common.j3d
{
	import com.pj.common.Helper;
	import flash.display3D.Context3D;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class J3DContainer extends J3DObject implements I3DContainer
	{
		protected var _child:Vector.<J3DObject> = null;
		
		public function J3DContainer()
		{
			super();
			this._child = new Vector.<J3DObject>();
		}
		
		override public function dispose():void
		{
			Helper.dispose(this._child);
			this._child = null;
			super.dispose();
		}
		
		public function addChild(p_child:J3DObject):J3DObject
		{
			this._child.push(p_child);
			return p_child;
		}
		
		override public function draw(p_context:Context3D):void
		{
			super.draw(p_context);
			if (!this._child) {
				return;
			}
			for (var i:int = 0; i < this._child.length; i++) {
				var child:J3DObject = this._child[i];
				child.draw(p_context);
			}
		}
	
	}
}