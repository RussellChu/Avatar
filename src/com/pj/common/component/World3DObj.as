package com.pj.common.component
{
	import com.pj.common.math.Vector3D;
	import com.pj.common.math.Vector4D;
	import com.pj.common.math.Matrix4D;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class World3DObj extends StandObject
	{
		private var _pos:Vector3D = null;
		private var _project:Vector4D = null;
		
		public function World3DObj(p_inst:BasicObject):void
		{
			super(p_inst);
		}
		
		override public function dispose():void
		{
			this._pos = null;
			this._project = null;
			super.dispose();
		}
		
		override protected function init():void {
			super.init();
		}
		
		override public function reset():void {
			super.reset();
			this._pos = new Vector3D();
			this._project = new Vector4D();
		}
		
		public function get pos():Vector3D
		{
			return this._pos;
		}
		
		public function get project():Vector4D
		{
			return this._project;
		}
		
		public function updateProject(p_m:Matrix4D):void
		{
			this._project = p_m.transform(this._pos.clone4(1));
		}
	
	}
}