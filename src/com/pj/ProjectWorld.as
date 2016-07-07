package com.pj
{
	import com.pj.common.Helper;
	import com.pj.common.component.BasicContainer;
	import com.pj.common.component.World3D;
	import com.pj.common.component.World3DObj;
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
		private static const CIRCLE_AMOUNT:int = 600;
		private static const CIRCLE_RADIUS:int = 10;
		private static const SPACE_RADIUS:int = 400;
		
		private var _timer:Timer = null;
		private var _world:World3D = null;
		
		public function ProjectWorld(p_inst:Sprite):void
		{
			super(null, p_inst);
			
			this._timer = new Timer(20);
			this._timer.addEventListener(TimerEvent.TIMER, this.onTime);
			
			this._world = new World3D(this);
			this._world.setCenter(SPACE_RADIUS, SPACE_RADIUS);
			this._world.camera.position = new Vector3D(0, 0, -SPACE_RADIUS * (1.8 + 0.3));
			this._world.camera.target = new Vector3D(0, 0, 0);
			this._world.camera.up = new Vector3D(0, 1, 0);
			this._world.camera.setProject(SPACE_RADIUS * (1.8 * 2), SPACE_RADIUS * 0.3, SPACE_RADIUS, SPACE_RADIUS);
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
				var color:int = 0xff000000 | 0x10000 * int(Math.random() * 0xff) | 0x100 * int(Math.random() * 0xff) | 0x1 * int(Math.random() * 0xff);
				var item:CircleItem = new CircleItem(CIRCLE_RADIUS, color);
				var item3D:World3DObj = this._world.addChild(item) as World3DObj;
				item3D.pos.x = (Math.random() * 2 - 1) * SPACE_RADIUS;
				item3D.pos.y = (Math.random() * 2 - 1) * SPACE_RADIUS;
				item3D.pos.z = (Math.random() * 2 - 1) * SPACE_RADIUS;
				
				var ratio:Number = 0;
				if (i % 3 > 0)
				{
					if (Math.abs(item3D.pos.x) > Math.abs(item3D.pos.y) && Math.abs(item3D.pos.x) > Math.abs(item3D.pos.z))
					{
						ratio = SPACE_RADIUS / Math.abs(item3D.pos.x);
					}
					if (Math.abs(item3D.pos.y) > Math.abs(item3D.pos.z) && Math.abs(item3D.pos.y) > Math.abs(item3D.pos.x))
					{
						ratio = SPACE_RADIUS / Math.abs(item3D.pos.y);
					}
					if (Math.abs(item3D.pos.z) > Math.abs(item3D.pos.x) && Math.abs(item3D.pos.z) > Math.abs(item3D.pos.y))
					{
						ratio = SPACE_RADIUS / Math.abs(item3D.pos.z);
					}
					ratio *= 0.5;
				}
				else
				{
					ratio = SPACE_RADIUS * 0.7 / Math.sqrt(item3D.pos.lengthStr());
					ratio *= 2;
				}
				item3D.pos.x *= ratio;
				item3D.pos.y *= ratio;
				item3D.pos.z *= ratio;
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
import com.pj.common.component.BasicContainer;
import com.pj.common.component.BasicObject;
import com.pj.common.component.IContainer;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

class CircleItem extends BasicObject
{
	public function CircleItem(p_radius:Number, p_color:int):void
	{
		super();
		
		var sp:Sprite = new Sprite();
		var bmpData:BitmapData = new BitmapData(p_radius * 2 + 1, p_radius * 2 + 1, true, 0);
		bmpData.lock();
		for (var i:int = -p_radius; i <= p_radius; i++)
		{
			for (var j:int = -p_radius; j <= p_radius; j++)
			{
				if (i * i + j * j <= (p_radius - 0.5) * (p_radius - 0.5))
				{
					bmpData.setPixel32(i + p_radius, j + p_radius, p_color);
				}
			}
		}
		bmpData.unlock();
		var bmp:Bitmap = new Bitmap(bmpData);
		bmp.x = -p_radius;
		bmp.y = -p_radius;
		(this.instance as Sprite).addChild(bmp);
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