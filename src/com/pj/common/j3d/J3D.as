package com.pj.common.j3d
{
	import com.pj.common.Helper;
	import com.pj.common.component.BasicObject;
	import com.pj.common.component.IContainer;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.Program3D;
	import flash.display3D.VertexBuffer3D;
	import flash.events.Event;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class J3D extends BasicObject implements I3DContainer
	{
		private var _container:J3DContainer = null;
		private var _context3D:Context3D = null;
		private var _nextVertexShader:int = 0;
		private var _nextPixelShader:int = 0;
		private var _program:Program3D = null;
		private var _shaderManager:JShaderManager = null;
		
		public function J3D(p_parent:IContainer):void
		{
			super(null, p_parent);
			this._container = new J3DContainer();
			this._shaderManager = new JShaderManager();
			this.instance.stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE, this.onInit);
			this.instance.addEventListener(Event.ENTER_FRAME, this.onRender);
		}
		
		override public function dispose():void
		{
			Helper.dispose(this._shaderManager);
			this._context3D = null;
			this._program = null;
			this._shaderManager = null;
		}
		
		public function addChild(p_child:J3DObject):J3DObject
		{
			return this._container.addChild(p_child);
		}
		
		public function init():void
		{
			this.instance.stage.stage3Ds[0].requestContext3D();
		}
		
		private function onInit(p_evt:Event):void
		{
			this._context3D = this.instance.stage.stage3Ds[0].context3D;
			this._context3D.configureBackBuffer(400, 400, 1, true);
			this._program = this._context3D.createProgram();
		}
		
		private function onRender(p_evt:Event):void
		{
			if (!this._context3D || !this._program)
			{
				return;
			}
			
			if (this._nextVertexShader > 0 || this._nextPixelShader > 0)
			{
				var vShader:JVertexShader = this._shaderManager.loadVertexShader(this._nextVertexShader);
				var pShader:JPixelShader = this._shaderManager.loadPixelShader(this._nextPixelShader);
				this._program.upload(vShader.getAgalCode(), pShader.getAgalCode());
				this._nextVertexShader = 0;
				this._nextPixelShader = 0;
			}
			
			this._context3D.clear(0, 1, 1, 1);

			// assign shader program
			var m:Matrix3D = new Matrix3D();
			m.appendRotation(getTimer() / 40, Vector3D.Z_AXIS);
			this._context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, m, true);
			this._context3D.setProgram(this._program);
			
			var abc:J3DObject = new J3DObject();
			abc.draw(this._context3D);
			
			this._context3D.present();
		}
		
		public function setShader(p_vertex:int, p_pixel:int):void
		{
			this._nextVertexShader = p_vertex;
			this._nextPixelShader = p_pixel;
		}
	
	}
}