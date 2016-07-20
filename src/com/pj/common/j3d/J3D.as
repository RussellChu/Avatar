package com.pj.common.j3d
{
	import com.pj.common.Helper;
	import com.pj.common.JColor;
	import com.pj.common.component.BasicObject;
	import com.pj.common.component.IContainer;
	import com.pj.common.j3d.shader.pixel.J3DPixelShader;
	import com.pj.common.j3d.shader.vertex.J3DVertexShader;
	import com.pj.common.j3d.shape.J3DShapeSquare;
	import flash.display3D.Context3D;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.Program3D;
	import flash.display3D.VertexBuffer3D;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class J3D extends BasicObject implements I3DContainer
	{
		private var _container:J3DContainer = null;
		private var _context3D:Context3D = null;
		private var _pixelShader:J3DPixelShader = null;
		private var _vertexShader:J3DVertexShader = null;
		private var _program:Program3D = null;
		
		public function J3D(p_parent:IContainer):void
		{
			super(null, p_parent);
			this._container = new J3DContainer();
			this.instance.stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE, this.onInit);
			this.instance.addEventListener(Event.ENTER_FRAME, this.onRender);
		}
		
		override public function dispose():void
		{
			Helper.dispose(this._pixelShader);
			Helper.dispose(this._vertexShader);
			this._context3D = null;
			this._program = null;
			this._pixelShader = null;
			this._vertexShader = null;
		}
		
		public function addChild(p_child:J3DObject):J3DObject
		{
			return this._container.addChild(p_child);
		}
		
		public function drawObject(p_vertices:J3DVertex, p_indices:J3DIndex, p_vertexShader:J3DVertexShader, p_pixelShader:J3DPixelShader):void
		{
			if (p_vertexShader)
			{
				this._vertexShader = p_vertexShader;
			}
			if (p_pixelShader)
			{
				this._pixelShader = p_pixelShader;
			}
			if (!this._vertexShader || !this._pixelShader)
			{
				return;
			}
			if (!p_vertices || !p_indices)
			{
				return;
			}
			
			this._program.upload(this._vertexShader.getAgalCode(), this._pixelShader.getAgalCode());
			this._vertexShader.update(this._context3D);
			this._pixelShader.update(this._context3D);
			
			var indexbuffer:IndexBuffer3D = p_indices.setupBuffer(this._context3D);
			var vertexbuffer:VertexBuffer3D = p_vertices.setupBuffer(this._context3D);
			this._context3D.drawTriangles(indexbuffer);
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
			this._context3D.setProgram(this._program);
		}
		
		private function onRender(p_evt:Event):void
		{
			if (!this._context3D || !this._program)
			{
				return;
			}
			
			this._context3D.clear(0, 1, 1, 1);
			this._container.draw(this);
			this._context3D.present();
		}
		
		public function setShader(p_vertex:J3DVertexShader, p_pixel:J3DPixelShader):void
		{
			this._container.vertexShader = p_vertex;
			this._container.pixelShader = p_pixel;
		}
	
	}
}