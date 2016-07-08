package com.pj
{
	import com.pj.common.Helper;
	import com.pj.common.JColor;
	import com.pj.common.component.BasicContainer;
	import com.pj.common.component.World3D;
	import com.pj.common.component.World3DObj;
	import com.pj.common.j3d.Camera3D;
	import com.pj.common.math.JMath;
	import com.pj.common.math.Vector3D;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class ProjectWorld extends BasicContainer
	{
		private static const CIRCLE_AMOUNT:int = 150;
		private static const CIRCLE_RADIUS:int = 20;
		private static const SPACE_RADIUS:int = 2000;
		
		private var _timer:Timer = null;
		private var _world:World3D = null;
		
		public function ProjectWorld(p_inst:Sprite):void
		{
			super(null, p_inst);
			
			this._timer = new Timer(20);
			this._timer.addEventListener(TimerEvent.TIMER, this.onTime);
			
			this._world = new World3D(this);
			this._world.setCenter(400, 400);
			this._world.camera.mode = Camera3D.MODE_PERSPECTIVE;
			this._world.camera.position = new Vector3D(0, 0, -SPACE_RADIUS * (1 + 0.3));
			this._world.camera.target = new Vector3D(0, 0, 1);
			this._world.camera.up = new Vector3D(0, 1, 0);
			this._world.camera.setProject(SPACE_RADIUS * (1 + 1), SPACE_RADIUS * 0.3, SPACE_RADIUS, SPACE_RADIUS);
			this.createCircle();
			
			this._timer.start();
			
			//	var slider:Slider = new Slider(this, 100, 100);
		}
		
		override public function dispose():void
		{
			if (this._timer)
			{
				this._timer.reset();
				this._timer.removeEventListener(TimerEvent.TIMER, this.onTime);
			}
			Helper.dispose(this._world);
			
			this._timer = null;
			this._world = null;
			
			super.dispose();
		}
		
		private function createCircle():void
		{
			for (var i:int = 0; i < CIRCLE_AMOUNT; i++)
			{
				var item:CircleItem = new CircleItem(CIRCLE_RADIUS, JColor.setRGBA(Math.random(), Math.random(), Math.random(), 1));
				var item3D:World3DObj = this._world.addChild(item) as World3DObj;

				var randResult:Object = JMath.randSphereVolume();
				item3D.pos.x = randResult.x * SPACE_RADIUS;
				item3D.pos.y = randResult.y * SPACE_RADIUS;
				item3D.pos.z = randResult.z * SPACE_RADIUS;
			}
			this._world.refresh();
		}

		private function onTime(event:TimerEvent):void
		{
			this._world.camera.rotateByX(0.01);
			this._world.camera.rotateByY(0.029);
			this._world.camera.rotateByZ(0.013);
			//	this._world.camera.move(new Vector3D(0, 0, 0.5));
			this._world.refresh();
		}
	
	}

}

import com.pj.common.Helper;
import com.pj.common.JColor;
import com.pj.common.component.BasicContainer;
import com.pj.common.component.BasicObject;
import com.pj.common.component.IContainer;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.MovieClip;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.MouseEvent;

class CircleItem extends BasicObject
{
	private var _bmp:Bitmap = null;
	private var _bmpOver:Bitmap = null;
	
	public function CircleItem(p_radius:Number, p_color:uint):void
	{
		super();
		
		var color:JColor = JColor.createColorByHex(p_color);

		var bmpData:BitmapData = new BitmapData(p_radius * 2 + 1, p_radius * 2 + 1, true, 0);
		var bmpDataOver:BitmapData = new BitmapData(p_radius * 2 + 1, p_radius * 2 + 1, true, 0);
		var maskingShape:Shape = new Shape();
		maskingShape.graphics.beginFill(0xFFFFFF, 1);
		bmpData.lock();
		bmpDataOver.lock();
		if (p_radius >= 1)
		{
			var maxR:Number = (p_radius - 0.5) * (p_radius - 0.5);
			var invR:Number = 1 / maxR;
			for (var i:int = -p_radius; i <= p_radius; i++)
			{
				for (var j:int = -p_radius; j <= p_radius; j++)
				{
					var checkR:Number = i * i + j * j;
					if (checkR <= maxR)
					{
						var c:JColor = color.clone();
						c.a = 1 - checkR * invR;
						bmpData.setPixel32(i + p_radius, j + p_radius, c.value);
						c.r = 1;
						c.g = 1;
						c.b = 1;
						bmpDataOver.setPixel32(i + p_radius, j + p_radius, c.value);
						maskingShape.graphics.drawRect(i + p_radius, j + p_radius, 1, 1);
					}
				}
			}
		}
		bmpData.unlock();
		bmpDataOver.unlock();
		maskingShape.graphics.endFill();
		
		this._bmp = new Bitmap(bmpData);
		this._bmp.x = -p_radius;
		this._bmp.y = -p_radius;
		(this.instance as Sprite).addChild(this._bmp);
		
		this._bmpOver = new Bitmap(bmpDataOver);
		this._bmpOver.x = -p_radius;
		this._bmpOver.y = -p_radius;
		this._bmpOver.visible = false;
		(this.instance as Sprite).addChild(this._bmpOver);
		
		//maskingShape.x = -p_radius;
		//maskingShape.y = -p_radius;
		//(this.instance as Sprite).addChild(maskingShape);
		//(this.instance as Sprite).mask = maskingShape;
		
		(this.instance as Sprite).addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
		(this.instance as Sprite).addEventListener(MouseEvent.ROLL_OUT, this.onMouseRollOut);
	}
	
	private function onMouseOver(p_evt:MouseEvent):void
	{
		this._bmpOver.visible = true;
		this._bmp.visible = false;
	}
	
	private function onMouseRollOut(p_evt:MouseEvent):void
	{
		this._bmp.visible = true;
		this._bmpOver.visible = false;
	}

}

class Slider extends BasicObject implements IContainer
{
	private var _container:BasicContainer = null;
	private var _content:BasicContainer = null;
	private var _width:int = 0;
	private var _height:int = 0;
	
	public function Slider(p_parent:BasicContainer, p_width:int, p_height:int):void
	{
		super(new Sprite(), p_parent);
		this._container = new BasicContainer(p_parent, this.instance as Sprite);
		this._content = new BasicContainer(this._container);
		this._width = p_width;
		this._height = p_height;
		
		var maskImg:BitmapData = new BitmapData(this._width, this._height, true, 0);
		var mask:Bitmap = new Bitmap(maskImg);
		this._container.instance.mask = mask;
	}
	
	override public function dispose():void
	{
		Helper.dispose(this._container);
		Helper.dispose(this._content);
		this._container = null;
		this._content = null;
		super.dispose();
	}
	
	public function addChild(p_child:BasicObject):BasicObject
	{
		this._content.addChild(p_child);
		return p_child;
	}

}