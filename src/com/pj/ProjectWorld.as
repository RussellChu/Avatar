package com.pj
{
	import com.pj.common.Helper;
	import com.pj.common.component.BasicContainer;
	import com.pj.common.component.SimpleButton;
	import com.pj.common.component.Slider;
	import com.pj.common.component.World3D;
	import com.pj.common.component.World3DObj;
	import com.pj.common.image.JImage_Circle;
	import com.pj.common.image.JImage_RandSqr;
	import com.pj.common.math.JMath;
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
			
			//	var testHolder:DragableContainer = new DragableContainer(this, 200, 200, 400, 400);
			//	new JImage_RandSqr(testHolder, 400, 400);
			
			var slider:Slider = new Slider(this, 200, 50, 300, 300);
			new JImage_RandSqr(slider, 300, 300);
			
			var moveBg:JImage_Circle = new JImage_Circle(50, JImage_Circle.STYLE_DEFAULT, {color: 0xff0000ff});
			var moveCursor:JImage_Circle = new JImage_Circle(20, JImage_Circle.STYLE_DEFAULT, {color: 0xffff00ff});
			var mouseCtrl:MoveInput = new MoveInput(this, moveBg, moveCursor);
			mouseCtrl.x = 200;
			mouseCtrl.y = 200;
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

import com.pj.common.component.BasicObject;
import com.pj.common.component.DragableObject;
import com.pj.common.component.IContainer;
import com.pj.common.component.IMoveHandler;

class MoveInput extends BasicObject implements IMoveHandler
{
	private var _dragable:DragableObject = null;
	
	public function MoveInput(p_parent:IContainer, p_bg:BasicObject, p_cursor:BasicObject):void
	{
		super(null, p_parent);
		
		this._dragable = new DragableObject(p_cursor, this, false);
	}
	
	private function get container():Sprite
	{
		return this.instance as Sprite;
	}
	
	public function checkMove(p_from:Vector2D, p_to:Vector2D):Vector2D
	{
		return p_to;
	}
	
	public function onMoveComplete(p_to:Vector2D):void
	{
		;
	}
}