package com.pj
{
	import com.pj.common.Helper;
	import com.pj.common.component.BasicContainer;
	import com.pj.common.component.DragableContainer;
	import com.pj.common.component.SimpleButton;
	import com.pj.common.component.World3D;
	import com.pj.common.component.World3DObj;
	import com.pj.common.image.JImage_Circle;
	import com.pj.common.image.JImage_RandSqr;
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
			this._world.setCenter(640, 400);
			this._world.camera.mode = Camera3D.MODE_PERSPECTIVE;
			this._world.camera.position = new Vector3D(0, 0, -SPACE_RADIUS * (1 + 0.3));
			this._world.camera.target = new Vector3D(0, 0, 1);
			this._world.camera.up = new Vector3D(0, 1, 0);
			this._world.camera.setProject(SPACE_RADIUS * (1 + 1), SPACE_RADIUS * 0.3, SPACE_RADIUS, SPACE_RADIUS);
			this.createCircle();
			
			this._timer.start();
			
			var btn:SimpleButton = new SimpleButton("Hello world", 200, 50);
			//	this.addChild(btn);
			
			var testHolder:DragableContainer = new DragableContainer(this, 200, 200, 400, 400);
			new JImage_RandSqr(testHolder, 400, 400);
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
				// JColor.setRGBA(Math.random(), Math.random(), Math.random(), 1)
				var item:JImage_Circle = new JImage_Circle(CIRCLE_RADIUS, JImage_Circle.STYLE_RAND, {});
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
import com.pj.common.component.BasicContainer;
import com.pj.common.component.BasicObject;
import com.pj.common.component.DragableContainer;
import com.pj.common.component.DragableObject;
import com.pj.common.component.IContainer;
import flash.display.Shape;
import flash.display.Sprite;

class Slider extends BasicObject implements IContainer
{
	private static const CTRL_BAR_COLOR:uint = 0xffc8c8c8;
	private static const CTRL_BG_COLOR:uint = 0xfff0f0f0;
	private static const CTRL_WIDTH:int = 15;
	private var _content:DragableContainer = null;
	private var _ctrlBar:Shape = null;
	private var _ctrlBg:Shape = null;
	
	public function Slider(p_parent:IContainer, p_borderWidth:int = 0, p_borderHeight:int = 0, p_contentWidth:int = 0, p_contentHeight:int = 0):void
	{
		super(null, p_parent);
		var borderWidth:int = p_borderWidth;
		var borderHeight:int = p_borderHeight;
		var contentWidth:int = p_contentWidth;
		var contentHeight:int = p_contentHeight;
		if (borderWidth < CTRL_WIDTH)
		{
			borderWidth = CTRL_WIDTH;
		}
		if (borderHeight < 0)
		{
			borderHeight = 0;
		}
		if (contentWidth < 0)
		{
			contentWidth = 0;
		}
		if (contentHeight < 0)
		{
			contentHeight = 0;
		}
		this._content = new DragableContainer(null);
		this.container.addChild(this._content.instance);
		
		this._ctrlBg = new Shape();
		this._ctrlBg.width = 1;
		this._ctrlBg.height = 1;
		this._ctrlBg.graphics.beginFill(CTRL_BG_COLOR, 1);
		this._ctrlBg.graphics.drawRect(0, 0, 1, 1);
		this._ctrlBg.graphics.endFill();
		this._ctrlBg.scaleX = CTRL_WIDTH;
		this._ctrlBg.scaleY = borderHeight;
		this.container.addChild(this._ctrlBg);
		
		var ratio:Number = 1;
		if (contentHeight > 0)
		{
			ratio = borderHeight / contentHeight;
		}
		if (ratio > 1)
		{
			ratio = 1;
		}
		this._ctrlBar = new Shape();
		this._ctrlBar.x = borderWidth - CTRL_WIDTH;
		this._ctrlBar.y = 0;
		this._ctrlBar.width = 1;
		this._ctrlBar.height = 1;
		this._ctrlBar.graphics.beginFill(CTRL_BAR_COLOR, 1);
		this._ctrlBar.graphics.drawRect(0, 0, 1, 1);
		this._ctrlBar.graphics.endFill();
		this._ctrlBar.scaleX = CTRL_WIDTH;
		this._ctrlBar.scaleY = borderHeight * ratio;
		this.container.addChild(this._ctrlBar);
	}
	
	override public function dispose():void
	{
		Helper.dispose(this._content);
		this._content = null;
		this._ctrlBar = null;
		this._ctrlBg = null;
		super.dispose();
	}
		
	private function get container():Sprite {
		return this.instance as Sprite;
	}
	
	public function addChild(p_child:BasicObject):BasicObject
	{
		this._content.addChild(p_child);
		return p_child;
	}

}