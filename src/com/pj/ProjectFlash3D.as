package com.pj
{
	import com.pj.common.JColor;
	import com.pj.common.component.BasicContainer;
	import com.pj.common.j3d.J3D;
	import com.pj.common.j3d.shader.pixel.J3D_PS_Test;
	import com.pj.common.j3d.shader.vertex.J3D_VS_Test;
	import com.pj.common.j3d.shape.J3DShapeSquare;
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
			this._j3D.setShader(new J3D_VS_Test(), new J3D_PS_Test());
			this._j3D.init();
			
			this._j3D.addChild(new J3DShapeSquare(new JColor(1, 0, 0, 1)));
		}
		
	}
}

