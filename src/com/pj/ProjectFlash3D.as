package com.pj
{
	import com.pj.common.component.BasicContainer;
	import com.pj.common.j3d.J3D;
	import com.pj.common.j3d.JPixelShader;
	import com.pj.common.j3d.JVertexShader;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Russell
	 *
	 * http://jacksondunstan.com/articles/1664
	 * http://jacksondunstan.com/articles/1998
	 * http://northwaygames.com/a-pixelfragment-shader-example-in-flash/
	 */
	public class ProjectFlash3D extends BasicContainer
	{
		private var _j3D:J3D = null;
		
		public function ProjectFlash3D(p_inst:Sprite):void
		{
			super(null, p_inst);
			this._j3D = new J3D(this);
			this._j3D.setShader(JVertexShader.TYPE_TEST, JPixelShader.TYPE_TEST);
			this._j3D.init();
		}
	}
}

