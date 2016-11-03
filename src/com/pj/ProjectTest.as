package com.pj
{
	import com.pj.common.JColor;
	import com.pj.common.component.BasicContainer;
	import com.pj.common.component.Quad;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class ProjectTest extends BasicContainer
	{
		public function ProjectTest(p_inst:Sprite = null)
		{
			super(null, p_inst);
		
		}
		
		override protected function init():void
		{
			super.init();
			var bg:Quad = new Quad(Fire.RADIUS * 2, Fire.RADIUS * 2, 0x0000cc);
			this.addChild(bg);
			
			var mov:Fire = new Fire();
			this.addChild(mov);
		}
	
	}
}
import com.pj.common.JColor;
import com.pj.common.JTimer;
import com.pj.common.component.BasicObject;
import com.pj.common.component.JBmp;
import com.pj.common.math.JMath;
import com.pj.common.math.Vector3D;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.ColorTransform;

class Meteor extends BasicObject
{
	static public const RADIUS:int = 400;
	
	private var _ballList:Array = null;
	private var _timer:JTimer = null;
	private var _img:Bitmap = null;
	
	public function Fire()
	{
		super();
	}
	
	override protected function init():void
	{
		this._ballList = [];
		
		this._img = new Bitmap(new BitmapData(RADIUS * 2, RADIUS * 2, true, 0));
		this._img.x = -RADIUS;
		this._img.y = -RADIUS;
		this.container.addChild(this._img);
		
		this._timer = new JTimer(this.onTime);
		this._timer.start();
	}
	
	private function get container():Sprite
	{
		return (this.instance) as Sprite;
	}
	
	private function onTime(p_delta:Number):void
	{
		var i:int = 0;
		for (i = 0; i < 5; i++)
		{
			var ball:Object = {};
			var vecSrc:Object = JMath.randSphereSurface();
			if (vecSrc.z < 0)
			{
				continue;
			}
			
			var pos:Vector3D = new Vector3D();
			var vec:Vector3D = new Vector3D(vecSrc.x, vecSrc.y, vecSrc.z);
			vec.multiplyEql(1 + Math.random() * 3);
			ball.pos = pos;
			ball.vec = vec;
			this._ballList.push(ball);
		}
		
		while (this._ballList.length > 400)
		{
			this._ballList.shift();
		}
		
		for (i = 0; i < this._ballList.length; i++)
		{
			ball = this._ballList[i];
			pos = ball.pos;
			vec = ball.vec;
			pos.addEql(vec);
		}
		
		var bmp0:BitmapData = this._img.bitmapData;
		var bmp:BitmapData = new BitmapData(RADIUS * 2, RADIUS * 2, true, 0);
		bmp.lock();
		var ct:ColorTransform = new ColorTransform(0.9, 0.9, 0.9, 0.9);
		bmp.draw(bmp0, null, ct);
		for (i = 0; i < this._ballList.length; i++)
		{
			ball = this._ballList[i];
			pos = ball.pos;
			var r:int = 1;
			for (var x:int = -r; x <= r; x++)
			{
				for (var y:int = -r; y <= r; y++)
				{
					var colorSrc:uint = bmp.getPixel32(pos.x + RADIUS + x, pos.y + RADIUS + y);
					var color:JColor = JColor.createColorByHex(colorSrc);
					var a2:Number = 1 - Math.sqrt(x * x + y * y) / r;
					a2 *= 1 - i / this._ballList.length;
					color.addLight(Math.random() * 0.5 + 0.5, Math.random(), 1, a2);
					bmp.setPixel32(pos.x + RADIUS + x, pos.y + RADIUS + y, color.value);
				}
			}
		}
		bmp.unlock();
		this._img.bitmapData = bmp;
	}

}