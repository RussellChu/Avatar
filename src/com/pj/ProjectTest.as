package com.pj
{
	import com.pj.common.JColor;
	import com.pj.common.component.BasicContainer;
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
			var mov:Fire = new Fire();
			this.addChild(mov);
		}
	
	}
}
import com.pj.common.JColor;
import com.pj.common.JTimer;
import com.pj.common.component.BasicObject;
import com.pj.common.math.JMath;
import com.pj.common.math.Vector3D;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

class Fire extends BasicObject
{
	static private const FRAME_NUM:int = 50;
	static private const PART_NUM:int = 100;
	static private const RADIUS:int = 100;
	
	private var _ballList:Array = null;
	private var _bmpList:Array = null;
	private var _timer:JTimer = null;
	private var _frame:int = 0;
	private var _img:Bitmap = null;
	
	public function Fire()
	{
		super();
	}
	
	override protected function init():void
	{
		this._ballList = [];
		this._bmpList = [];
		
		var ball:Object = null;
		var pos:Vector3D = null;
		var vec:Vector3D = null;
		var i:int = 0;
		for (i = 0; i < PART_NUM; i++)
		{
			ball = {};
			var vecSrc:Object = JMath.randSphereSurface();
			pos = new Vector3D();
			vec = new Vector3D(vecSrc.x, vecSrc.y, vecSrc.z);
			vec.multiplyEql(1 + Math.random());
			ball.pos = pos;
			ball.vec = vec;
			this._ballList.push(ball);
		}
		
		for (var j:int = 0; j < FRAME_NUM; j++)
		{
			for (i = 0; i < this._ballList.length; i++)
			{
				ball = this._ballList[i];
				pos = ball.pos;
				vec = ball.vec;
				pos.addEql(vec);
			//	vec.addEql(new Vector3D(0, 0.1, 0));
			}
			var bmp:BitmapData = new BitmapData(RADIUS * 2, RADIUS * 2, true, 0);
			bmp.lock();
			for (i = 0; i < this._ballList.length; i++)
			{
				ball = this._ballList[i];
				pos = ball.pos;
				var len:Number = Math.sqrt(pos.lengthSqr());
				var alpha:Number = 0;
				if (len < RADIUS) {
					alpha = 1 - len / RADIUS;
				}
				alpha *= (1 - j / FRAME_NUM);
				bmp.setPixel32(pos.x + RADIUS, pos.y + RADIUS, new JColor(Math.random(), 0, Math.random(), alpha).value);
			}
			bmp.unlock();
			this._bmpList.push(bmp);
		}
		
		this._img = new Bitmap(this._bmpList[0] as BitmapData);
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
		this._frame = (this._frame + 1) % this._bmpList.length;
		this._img.bitmapData = this._bmpList[this._frame] as BitmapData;
	}

}