package com.pj
{
	import com.pj.common.JColor;
	import com.pj.common.component.BasicContainer;
	import com.pj.common.j3d.Camera3D;
	import com.pj.common.j3d.J3D;
	import com.pj.common.j3d.shader.pixel.J3D_PS_Simple;
	import com.pj.common.j3d.shader.vertex.J3D_VS_Simple;
	import com.pj.common.j3d.shape.J3DShapeSquare;
	import com.pj.common.math.Vector3D;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	
	/**
	 * ...
	 * @author Russell
	 *
	 * http://jacksondunstan.com/articles/1664
	 * http://jacksondunstan.com/articles/1998
	 * http://northwaygames.com/a-pixelfragment-shader-example-in-flash/
	 * http://www.adobe.com/devnet/flashplayer/articles/what-is-agal.html
	 */
	public class ProjectFlash3D extends BasicContainer
	{
		private var _vs:J3D_VS_Simple = null;
		private var _camera:Camera3D = null;
		
		public function ProjectFlash3D(p_inst:Sprite):void
		{
			super(null, p_inst);
			
			this._vs = new J3D_VS_Simple();
			
			var j3D:J3D = J3D.i;
			J3D.i.init(this);
			J3D.i.setShader(this._vs, new J3D_PS_Simple());
		//	J3D.i.addChild(new J3DShapeSquare(new JColor(1, 0.7, 0.4, 1)));
			J3D.i.addChild(new J3DShapeSquare(new JColor(1, 1, 1, 1)));
			
			var r:Number = 0.5;
			this._camera = new Camera3D();
			this._camera.mode = Camera3D.MODE_PERSPECTIVE;
			this._camera.position = new Vector3D(-3, 0, -4);
		//	this._camera.position = new Vector3D(0, 0, -4);
			this._camera.target = new Vector3D(0, 0, 0);
			this._camera.up = new Vector3D(0, 1, 0);
			this._camera.setProject(4, 3, 2, 1, 0.5);
			
			this.instance.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
		}
		
		private function onEnterFrame(p_evt:Event):void
		{
			this._camera.rotateByX(0.01);
		//	this._camera.rotateByY(0.029);
		//	this._camera.rotateByZ(0.013);
			this._vs.setCameraMatrix(this._camera.getTransform());
		}
	
	}
}

