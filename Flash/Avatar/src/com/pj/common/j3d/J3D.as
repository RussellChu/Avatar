package com.pj.common.j3d
{
	import com.pj.common.Helper;
	import com.pj.common.JColor;
	import com.pj.common.component.BasicObject;
	import com.pj.common.component.IContainer;
	import com.pj.common.j3d.shader.J3DShader;
	import com.pj.common.j3d.vertex.J3DVertex;
	import flash.display.BitmapData;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DBlendFactor;
	import flash.display3D.Context3DProfile;
	import flash.display3D.Context3DRenderMode;
	import flash.display3D.Context3DTriangleFace;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.Program3D;
	import flash.display3D.VertexBuffer3D;
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class J3D extends BasicObject implements I3DContainer
	{
		static private var __instance:J3D = null;
		
		static public function init(p_parent:IContainer):J3D
		{
			if (!__instance)
			{
				__instance = new J3D(p_parent);
			}
			return __instance;
		}
		
		private var _container:J3DContainer = null;
		private var _context3D:Context3D = null;
		private var _pixelShader:J3DShader = null;
		private var _vertexShader:J3DShader = null;
		private var _program:Program3D = null;
		private var _texture:J3DTextureManager = null;
		
		public function J3D(p_parent:IContainer)
		{
			super(null, p_parent);
		}
		
		override public function dispose():void
		{
			Helper.dispose(this._container);
			Helper.dispose(this._pixelShader);
			Helper.dispose(this._vertexShader);
			this._container = null;
			this._context3D = null;
			this._program = null;
			this._pixelShader = null;
			this._vertexShader = null;
			super.dispose();
		}
		
		override protected function init():void{
			super.init();
			this._container = new J3DContainer();
			this.instance.stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE, this.onInit);
			this.instance.addEventListener(Event.ENTER_FRAME, this.onRender);
			this.instance.stage.stage3Ds[0].requestContext3D(Context3DRenderMode.AUTO, Context3DProfile.STANDARD);
		}
		
		override public function reset():void{
			super.reset();
		}
		
		public function addChild(p_child:J3DObject):J3DObject
		{
			return this._container.addChild(p_child);
		}
		
		public function drawObject(p_vertices:J3DVertex, p_indices:J3DIndex, p_vertexShader:J3DShader, p_pixelShader:J3DShader):void
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
			
			var vp:ByteArray = this._vertexShader.getAgalCode();
			var pp:ByteArray = this._pixelShader.getAgalCode();
			if (vp.length > 0 && pp.length > 0) {
				this._program.upload(this._vertexShader.getAgalCode(), this._pixelShader.getAgalCode());
				this._vertexShader.update(this._context3D);
				this._pixelShader.update(this._context3D);
			}
			
			var indexbuffer:IndexBuffer3D = p_indices.setupBuffer(this._context3D);
			var vertexbuffer:VertexBuffer3D = p_vertices.setupBuffer(this._context3D, this._vertexShader);
			this._context3D.drawTriangles(indexbuffer);
		}
		
		private function onInit(p_evt:Event):void
		{
			this._context3D = this.instance.stage.stage3Ds[0].context3D;
			this._context3D.configureBackBuffer(400, 200, 1, true);
			this._context3D.setCulling(Context3DTriangleFace.BACK); // Remove "Back" triangle
			this._context3D.setBlendFactors(Context3DBlendFactor.SOURCE_ALPHA, Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
		//	this._context3D.setBlendFactors(Context3DBlendFactor.SOURCE_ALPHA, Context3DBlendFactor.SOURCE_ALPHA);
			this._program = this._context3D.createProgram();
			this._context3D.setProgram(this._program);
			
			this._texture = new J3DTextureManager(this._context3D);
			
			var width:int = 256;
			var height:int = 256;
			var bmpData:BitmapData = new BitmapData(width, height, true, 0);
			bmpData.lock();
			for (var i:int = 0; i < width; i++)
			{
				for (var j:int = 0; j < height; j++)
				{
					var color:uint = new JColor(Math.random(), Math.random(), Math.random(), 1).value;
					bmpData.setPixel32(i, j, color);
				}
			}
			bmpData.unlock();
		//	this._texture.loadBitmapData("test", 
		}
		
		private function onRender(p_evt:Event):void
		{
			if (!this._context3D || !this._program)
			{
				return;
			}
			
			this._context3D.clear(0, 0, 0, 1);
			this._container.draw(this);
			this._context3D.present();
		}
		
		public function setShader(p_vertex:J3DShader, p_pixel:J3DShader):void
		{
			this._container.vertexShader = p_vertex;
			this._container.pixelShader = p_pixel;
		}
	
	}
}