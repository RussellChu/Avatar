package com.pj
{
	import com.pj.common.component.BasicContainer;
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

import com.adobe.utils.AGALMiniAssembler;
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
import flash.utils.ByteArray;
import flash.utils.getTimer;

class JShader
{
	protected var _assembler:AGALMiniAssembler = null;
	
	public function JShader():void
	{
		this._assembler = new AGALMiniAssembler();
	}
	
	protected function line(p_arr:Array):String
	{
		if (!p_arr)
		{
			return "";
		}
		
		var result:String = "";
		for (var i:int = 0; i < p_arr.length; i++)
		{
			var str:String = p_arr[i] as String;
			if (!str)
			{
				continue;
			}
			if (str == "")
			{
				continue;
			}
			result += str + "\n";
		}
		return result;
	}
	
	public function getAgalCode():ByteArray
	{
		return this._assembler.agalcode;
	}
}

class JVertexShader extends JShader
{
	public static const TYPE_TEST:int = 1;
	
	public function JVertexShader(p_type:int):void
	{
		super();
		var code:String = "";
		switch (p_type)
		{
		case TYPE_TEST: 
		default: 
			code = this.line(["" // nothing
			, "mov v0, va1" // copy va1 (unknown) to v0(=color channel 0)
			, "m44 op, va0, vc0" // transform va0(vertex) by vc0(matrix) to op(vertex output)
			]);
		}
		this._assembler.assemble(Context3DProgramType.VERTEX, code);
	}
}

class JPixelShader extends JShader
{
	public static const TYPE_TEST:int = 1;
	
	public function JPixelShader(p_type:int):void
	{
		super();
		var code:String = "";
		switch (p_type)
		{
		case TYPE_TEST: 
		default: 
			code = this.line(["" // nothing
			, "mov oc, v0"]); // copy v0(=color channel 0) to oc(color output)
		}
		this._assembler.assemble(Context3DProgramType.FRAGMENT, code);
	}
}

class JShaderManager
{
	private var _vMap:Object = null;
	private var _pMap:Object = null;
	
	public function JShaderManager():void
	{
		this._vMap = {};
		this._pMap = {};
	}
	
	public function loadVertexShader(p_type:int):JVertexShader
	{
		if (this._vMap[p_type])
		{
			return this._vMap[p_type];
		}
		this._vMap[p_type] = new JVertexShader(p_type);
		return this._vMap[p_type];
	}
	
	public function loadPixelShader(p_type:int):JPixelShader
	{
		if (this._pMap[p_type])
		{
			return this._pMap[p_type];
		}
		this._pMap[p_type] = new JPixelShader(p_type);
		return this._pMap[p_type];
	}
}

class J3D extends BasicObject
{
	private var _context3D:Context3D = null;
	private var _nextVertexShader:int = 0;
	private var _nextPixelShader:int = 0;
	private var _program:Program3D = null;
	private var _shaderManager:JShaderManager = null;
	
	public function J3D(p_parent:IContainer):void
	{
		super(null, p_parent);
		this._shaderManager = new JShaderManager();
		this.instance.stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE, this.onInit);
		this.instance.addEventListener(Event.ENTER_FRAME, this.onRender);
	}
	
	public function setShader(p_vertex:int, p_pixel:int):void
	{
		this._nextVertexShader = p_vertex;
		this._nextPixelShader = p_pixel;
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
		
		// Testing Start
		
		var vertices:Vector.<Number> = Vector.<Number>([-0.3, -0.3, 0, 1, 0, 0, // x, y, z, r, g, b
		-0.3, 0.3, 0, 0, 1, 0, 0.3, 0.3, 0, 0, 0, 1]);
		
		var vertexbuffer:VertexBuffer3D;
		var indexbuffer:IndexBuffer3D;
		
		// Create VertexBuffer3D. 3 vertices, of 6 Numbers each
		vertexbuffer = this._context3D.createVertexBuffer(3, 6);
		// Upload VertexBuffer3D to GPU. Offset 0, 3 vertices
		vertexbuffer.uploadFromVector(vertices, 0, 3);
		
		var indices:Vector.<uint> = Vector.<uint>([0, 1, 2]);
		
		// Create IndexBuffer3D. Total of 3 indices. 1 triangle of 3 vertices
		indexbuffer = this._context3D.createIndexBuffer(3);
		// Upload IndexBuffer3D to GPU. Offset 0, count 3
		indexbuffer.uploadFromVector(indices, 0, 3);
		
		// vertex position to attribute register 0
		this._context3D.setVertexBufferAt(0, vertexbuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
		// color to attribute register 1
		this._context3D.setVertexBufferAt(1, vertexbuffer, 3, Context3DVertexBufferFormat.FLOAT_3);
		// assign shader program
		this._context3D.setProgram(this._program);
		
		var m:Matrix3D = new Matrix3D();
		m.appendRotation(getTimer() / 40, Vector3D.Z_AXIS);
		this._context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, m, true);
		
		this._context3D.drawTriangles(indexbuffer);
		// Testing End
		
		this._context3D.present();
	}

}