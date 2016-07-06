package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	public class Main extends Sprite
	{
		public function Main():void
		{
			new ProjectWorld(this);
			//trace("Hello World!");
			//loader = new Loader();
			//loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void
			//{
			////	loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this);
			//var mc:MovieClip = loader.content as MovieClip;
			//addChild(mc);
			//});
			//loader.load(new URLRequest("basket_x000a_p78.swf"));
		}
	}
}

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.TimerEvent;
import flash.utils.Timer;

interface IDisposable
{
	function dispose():void
}

interface IContainer
{
	function addChild(p_child:BasicObject):BasicObject
}

class Helper
{
	public static function dispose(p_obj:Object):Boolean
	{
		if (!p_obj)
		{
			return false;
		}
		if (p_obj is IDisposable)
		{
			(p_obj as IDisposable).dispose();
			return true;
		}
		if (p_obj is Vector.<*>)
		{
			for each (var item:Object in p_obj)
			{
				dispose(item);
			}
			return true;
		}
		return false;
	}
}

class Vector3D
{
	public var x:Number = 0;
	public var y:Number = 0;
	public var z:Number = 0;
	
	public function Vector3D(p_x:Number = 0, p_y:Number = 0, p_z:Number = 0):void
	{
		this.x = p_x;
		this.y = p_y;
		this.z = p_z;
	}
	
	public function clone():Vector3D
	{
		return new Vector3D(this.x, this.y, this.z);
	}
	
	public function clone4(p_w:Number = 0):Vector4D
	{
		return new Vector4D(this.x, this.y, this.z, p_w);
	}
	
	public function cloneFrom(p_vtr:Vector3D):Vector3D
	{
		this.x = p_vtr.x;
		this.y = p_vtr.y;
		this.z = p_vtr.z;
		return this;
	}
	
	public function lengthStr():Number
	{
		return this.x * this.x + this.y * this.y + this.z * this.z;
	}
	
	public function normal():Vector3D
	{
		var result:Vector3D = new Vector3D();
		var lenStr:Number = this.lengthStr();
		if (lenStr > 0)
		{
			var factor:Number = 1 / Math.sqrt(lenStr);
			result.x = this.x * factor;
			result.y = this.y * factor;
			result.z = this.z * factor;
		}
		return result;
	}
	
	public function add(p_vtr:Vector3D):Vector3D
	{
		return new Vector3D(this.x + p_vtr.x, this.y + p_vtr.y, this.z + p_vtr.z);
	}
	
	public function minus(p_vtr:Vector3D):Vector3D
	{
		return new Vector3D(this.x - p_vtr.x, this.y - p_vtr.y, this.z - p_vtr.z);
	}
	
	public function multiply(p_value:Number):Vector3D
	{
		return new Vector3D(this.x * p_value, this.y * p_value, this.z * p_value);
	}
	
	public function divide(p_value:Number):Vector3D
	{
		var invM:Number = 0;
		if (p_value != 0)
		{
			invM = 1 / p_value;
		}
		return this.multiply(invM);
	}
	
	public function addEql(p_vtr:Vector3D):Vector3D
	{
		return this.cloneFrom(this.add(p_vtr));
	}
	
	public function minusEql(p_vtr:Vector3D):Vector3D
	{
		return this.cloneFrom(this.minus(p_vtr));
	}
	
	public function multiplyEql(p_value:Number):Vector3D
	{
		return this.cloneFrom(this.multiply(p_value));
	}
	
	public function divideEql(p_value:Number):Vector3D
	{
		return this.cloneFrom(this.divide(p_value));
	}
	
	public function dot(p_vtr:Vector3D):Number
	{
		return this.x * p_vtr.x + this.y * p_vtr.y + this.z * p_vtr.z;
	}
	
	public function cross(p_vtr:Vector3D):Vector3D
	{
		var result:Vector3D = new Vector3D();
		result.x = this.y * p_vtr.z - this.z * p_vtr.y;
		result.y = this.z * p_vtr.x - this.x * p_vtr.z;
		result.z = this.x * p_vtr.y - this.y * p_vtr.x;
		return result;
	}

}

class Vector4D
{
	public var x:Number = 0;
	public var y:Number = 0;
	public var z:Number = 0;
	public var w:Number = 0;
	
	public function Vector4D(p_x:Number = 0, p_y:Number = 0, p_z:Number = 0, p_w:Number = 0):void
	{
		this.x = p_x;
		this.y = p_y;
		this.z = p_z;
		this.w = p_w;
	}
	
	public function clone():Vector4D
	{
		return new Vector4D(this.x, this.y, this.z, this.w);
	}
	
	public function clone3():Vector3D
	{
		var invW:Number = 0;
		if (this.w != 0)
		{
			invW = 1 / this.w;
		}
		return new Vector3D(this.x * invW, this.y * invW, this.z * invW);
	}
	
	public function multiply(p_value:Number):Vector4D
	{
		return new Vector4D(this.x * p_value, this.y * p_value, this.z * p_value, this.w * p_value);
	}
	
	public function divide(p_value:Number):Vector4D
	{
		var invM:Number = 0;
		if (p_value != 0)
		{
			invM = 1 / p_value;
		}
		return this.multiply(invM);
	}

}

class Matrix4D
{
	public var e:Array = null;
	
	public function Matrix4D():void
	{
		this.e = [];
		this.e.push([0, 0, 0, 0]);
		this.e.push([0, 0, 0, 0]);
		this.e.push([0, 0, 0, 0]);
		this.e.push([0, 0, 0, 0]);
	}
	
	public function cloneFrom(p_mx:Matrix4D):Matrix4D
	{
		for (var i:int = 0; i <= 3; i++)
		{
			for (var j:int = 0; j <= 3; j++)
			{
				this.e[i][j] = p_mx.e[i][j];
			}
		}
		return this;
	}
	
	public function setIdentity():Matrix4D
	{
		this.e = [];
		this.e.push([1, 0, 0, 0]);
		this.e.push([0, 1, 0, 0]);
		this.e.push([0, 0, 1, 0]);
		this.e.push([0, 0, 0, 1]);
		return this;
	}
	
	public function setRandom():Matrix4D
	{
		for (var i:int = 0; i <= 3; i++)
		{
			for (var j:int = 0; j <= 3; j++)
			{
				this.e[i][j] = Math.random();
			}
		}
		return this;
	}
	
	public function setRotateX(p_theta:Number):Matrix4D
	{
		var c:Number = Math.cos(p_theta);
		var s:Number = Math.sin(p_theta);
		this.e = [];
		this.e.push([1, 0, 0, 0]);
		this.e.push([0, c, -s, 0]);
		this.e.push([0, s, c, 0]);
		this.e.push([0, 0, 0, 1]);
		return this;
	}
	
	public function setRotateY(p_theta:Number):Matrix4D
	{
		var c:Number = Math.cos(p_theta);
		var s:Number = Math.sin(p_theta);
		this.e = [];
		this.e.push([c, 0, s, 0]);
		this.e.push([0, 1, 0, 0]);
		this.e.push([-s, 0, c, 0]);
		this.e.push([0, 0, 0, 1]);
		return this;
	}
	
	public function setRotateZ(p_theta:Number):Matrix4D
	{
		var c:Number = Math.cos(p_theta);
		var s:Number = Math.sin(p_theta);
		this.e = [];
		this.e.push([c, -s, 0, 0]);
		this.e.push([s, c, 0, 0]);
		this.e.push([0, 0, 1, 0]);
		this.e.push([0, 0, 0, 1]);
		return this;
	}
	
	public function setTranslate(p_vtr:Vector3D):Matrix4D
	{
		this.e = [];
		this.e.push([1, 0, 0, p_vtr.x]);
		this.e.push([0, 1, 0, p_vtr.y]);
		this.e.push([0, 0, 1, p_vtr.z]);
		this.e.push([0, 0, 0, 1]);
		return this;
	}
	
	public function product(p_mx:Matrix4D):Matrix4D
	{
		var result:Matrix4D = new Matrix4D();
		for (var i:int = 0; i <= 3; i++)
		{
			for (var j:int = 0; j <= 3; j++)
			{
				result.e[i][j] = this.e[0][j] * p_mx.e[i][0] + this.e[1][j] * p_mx.e[i][1] + this.e[2][j] * p_mx.e[i][2] + this.e[3][j] * p_mx.e[i][3];
			}
		}
		return result;
	}
	
	public function productEqual(p_mx:Matrix4D):Matrix4D
	{
		return this.cloneFrom(this.product(p_mx));
	}
	
	public function inverse3x3():Matrix4D
	{
		var result:Matrix4D = new Matrix4D();
		var det:Number = 0;
		var i:int = 0;
		var j:int = 0;
		for (i = 0; i <= 2; i++)
		{
			det += this.e[0][i] * (this.e[1][(i + 1) % 3] * this.e[2][(i + 2) % 3] - this.e[1][(i + 2) % 3] * this.e[2][(i + 1) % 3]);
		}
		if (det == 0)
		{
			return result;
		}
		var invDet:Number = 1 / det;
		for (i = 0; i <= 2; i++)
		{
			for (j = 0; j <= 2; j++)
			{
				result.e[j][i] = ((this.e[(i + 1) % 3][(j + 1) % 3] * this.e[(i + 2) % 3][(j + 2) % 3]) - (this.e[(i + 1) % 3][(j + 2) % 3] * this.e[(i + 2) % 3][(j + 1) % 3])) * invDet;
			}
		}
		result.e[3][3] = 1;
		return result;
	}
	
	/*
	 *  (x,y,z,w) * M -> (x',y',z',w')
	 */
	public function transform(p_vtr:Vector4D):Vector4D
	{
		var vtr:Vector4D = new Vector4D();
		vtr.x = p_vtr.x * this.e[0][0] + p_vtr.y * this.e[0][1] + p_vtr.z * this.e[0][2] + p_vtr.w * this.e[0][3];
		vtr.y = p_vtr.x * this.e[1][0] + p_vtr.y * this.e[1][1] + p_vtr.z * this.e[1][2] + p_vtr.w * this.e[1][3];
		vtr.z = p_vtr.x * this.e[2][0] + p_vtr.y * this.e[2][1] + p_vtr.z * this.e[2][2] + p_vtr.w * this.e[2][3];
		vtr.w = p_vtr.x * this.e[3][0] + p_vtr.y * this.e[3][1] + p_vtr.z * this.e[3][2] + p_vtr.w * this.e[3][3];
		return vtr;
	}
	
	public function printSelf():void
	{
		trace("print");
		var str:String = "";
		str = "" + this.e[0][0] + ", " + this.e[1][0] + ", " + this.e[2][0] + ", " + this.e[3][0];
		trace(str);
		str = "" + this.e[0][1] + ", " + this.e[1][1] + ", " + this.e[2][1] + ", " + this.e[3][1];
		trace(str);
		str = "" + this.e[0][2] + ", " + this.e[1][2] + ", " + this.e[2][2] + ", " + this.e[3][2];
		trace(str);
		str = "" + this.e[0][3] + ", " + this.e[1][3] + ", " + this.e[2][3] + ", " + this.e[3][3];
		trace(str);
	}

}

class Camera3D
{
	private var _target:Vector3D = null;
	private var _pos:Vector3D = null;
	private var _up:Vector3D = null;
	private var _planeDepth:Number = 0; // dist between near plane and far plane
	private var _planeDist:Number = 0; // near plane
	private var _planeWidth:Number = 0; // near plane radius
	private var _screenWidth:Number = 0; // screen radius
	
	public function Camera3D(p_pos:Vector3D = null, p_target:Vector3D = null, p_up:Vector3D = null):void
	{
		this._pos = p_pos;
		this._target = p_target;
		this._up = p_up;
		if (!this._pos)
		{
			this._pos = new Vector3D();
		}
		if (!this._target)
		{
			this._target = new Vector3D();
		}
		if (!this._up)
		{
			this._up = new Vector3D();
		}
	}
	
	public function move(p_pos:Vector3D):void
	{
		this._pos.addEql(p_pos);
		this._target.addEql(p_pos);
	}
	
	public function rotateByX(p_theta:Number):void
	{
		this._pos = new Matrix4D().setRotateX(p_theta).transform(this._pos.minus(this._target).clone4(1)).clone3().add(this._target);
	}
	
	public function rotateByY(p_theta:Number):void
	{
		this._pos = new Matrix4D().setRotateY(p_theta).transform(this._pos.minus(this._target).clone4(1)).clone3().add(this._target);
	}
	
	public function rotateByZ(p_theta:Number):void
	{
		this._pos = new Matrix4D().setRotateZ(p_theta).transform(this._pos.minus(this._target).clone4(1)).clone3().add(this._target);
	}
	
	public function setDefault():void
	{
		this._pos = new Vector3D(0, 0, 0);
		this._target = new Vector3D(0, 0, 1);
		this._up = new Vector3D(0, 1, 0);
		
		this._planeDepth = 1;
		this._planeDist = 1;
		this._planeWidth = 1;
		this._screenWidth = 1;
	}
	
	public function setProject(p_depth:Number, p_dist:Number, p_camWidth:Number, p_projWidth:Number):void
	{
		this._planeDepth = p_depth;
		this._planeDist = p_dist;
		this._planeWidth = p_camWidth;
		this._screenWidth = p_projWidth;
	}
	
	public function set position(p_vtr:Vector3D):void
	{
		this._pos = p_vtr;
	}
	
	public function set target(p_vtr:Vector3D):void
	{
		this._target = p_vtr;
	}
	
	public function set up(p_vtr:Vector3D):void
	{
		this._up = p_vtr;
	}
	
	public function getTransform():Matrix4D
	{
		var front:Vector3D = this._target.minus(this._pos);
		var left:Vector3D = this._up.cross(front);
		var top:Vector3D = front.cross(left);
		var u:Vector3D = left.normal();
		var v:Vector3D = top.normal();
		var w:Vector3D = front.normal();
		
		var mxA:Matrix4D = new Matrix4D();
		mxA.e[0][0] = u.x;
		mxA.e[1][0] = u.y;
		mxA.e[2][0] = u.z;
		mxA.e[0][1] = v.x;
		mxA.e[1][1] = v.y;
		mxA.e[2][1] = v.z;
		mxA.e[0][2] = w.x;
		mxA.e[1][2] = w.y;
		mxA.e[2][2] = w.z;
		mxA.e[3][3] = 1;
		
		var mxB:Matrix4D = new Matrix4D();
		mxB.setIdentity();
		mxB.e[0][3] = -this._pos.x;
		mxB.e[1][3] = -this._pos.y;
		mxB.e[2][3] = -this._pos.z;
		
		var mx:Matrix4D = mxB.product(mxA.inverse3x3());
		var mxPlane:Matrix4D = new Matrix4D();
		if (this._planeWidth > 0)
		{
			mxPlane.e[0][0] = this._screenWidth / this._planeWidth;
		}
		mxPlane.e[1][1] = mxPlane.e[0][0];
		if (this._planeDepth > 0)
		{
			mxPlane.e[2][2] = 1 / this._planeDepth;
		}
		if (this._planeDist > 0)
		{
			mxPlane.e[3][2] = 1 / this._planeDist;
		}
		if (this._planeDepth > 0)
		{
			mxPlane.e[2][3] = -this._planeDist / this._planeDepth;
		}
		return mx.product(mxPlane);
	}
}

class BasicObject implements IDisposable
{
	private var _instance:DisplayObject = null;
	
	public function BasicObject(p_inst:DisplayObject = null, p_parent:IContainer = null):void
	{
		if (p_inst)
		{
			this._instance = p_inst;
		}
		else
		{
			this._instance = new Sprite() as DisplayObject;
		}
		if (p_parent)
		{
			p_parent.addChild(this);
		}
	}
	
	public function dispose():void
	{
		Helper.dispose(this._instance);
		this._instance = null;
	}
	
	public function get instance():DisplayObject
	{
		return this._instance;
	}
}

class BasicContainer extends BasicObject implements IContainer
{
	protected var _child:Vector.<BasicObject> = null;
	
	public function BasicContainer(p_parent:BasicContainer, p_inst:Sprite = null):void
	{
		super(p_inst, p_parent);
		this._child = new Vector.<BasicObject>();
	}
	
	override public function dispose():void
	{
		Helper.dispose(this._child);
		this._child = null;
		super.dispose();
	}
	
	protected function get container():Sprite
	{
		return this.instance as Sprite;
	}
	
	public function addChild(p_child:BasicObject):BasicObject
	{
		this._child.push(p_child);
		this.container.addChild(p_child.instance);
		return p_child;
	}
}

class StandObject extends BasicObject
{
	private var _sp:Sprite = null;
	
	public function StandObject(p_inst:BasicObject):void
	{
		super(new Sprite());
		this._sp = new Sprite();
		this._sp.addChild(p_inst.instance);
	}
	
	override public function dispose():void
	{
		this._sp = null;
		super.dispose();
	}
	
	public function get stand():Sprite
	{
		return this._sp;
	}
}

class World3DObj extends StandObject
{
	private var _pos:Vector3D = null;
	private var _project:Vector4D = null;
	
	public function World3DObj(p_inst:BasicObject):void
	{
		super(p_inst);
		this._pos = new Vector3D();
		this._project = new Vector4D();
	}
	
	override public function dispose():void
	{
		this._pos = null;
		this._project = null;
		super.dispose();
	}
	
	public function get pos():Vector3D
	{
		return this._pos;
	}
	
	public function get project():Vector4D
	{
		return this._project;
	}
	
	public function updateProject(p_m:Matrix4D):void
	{
		this._project = p_m.transform(this._pos.clone4(1));
	}

}

class World3D extends BasicObject implements IContainer
{
	private var _camera:Camera3D = null;
	private var _center:Vector3D = null;
	private var _child:Vector.<World3DObj> = null;
	
	public function World3D(p_parent:BasicContainer):void
	{
		super(new Sprite(), p_parent);
		this._camera = new Camera3D();
		this._camera.setDefault();
		this._center = new Vector3D();
		this._child = new Vector.<World3DObj>();
	}
	
	override public function dispose():void
	{
		Helper.dispose(this._camera);
		Helper.dispose(this._child);
		this._camera = null;
		this._center = null;
		this._child = null;
		super.dispose();
	}
	
	public function addChild(p_child:BasicObject):BasicObject
	{
		var obj3D:World3DObj = new World3DObj(p_child);
		this._child.push(obj3D);
		this.container.addChild(obj3D.stand);
		return obj3D;
	}
	
	public function get camera():Camera3D
	{
		return this._camera;
	}
	
	protected function get container():Sprite
	{
		return this.instance as Sprite;
	}
	
	private function loopChild(p_func:Function):void
	{
		if (p_func.length != 1)
		{
			return;
		}
		for each (var child:World3DObj in this._child)
		{
			p_func(child);
		}
	}
	
	public function refresh():void
	{
		var self:World3D = this;
		
		this.loopChild(function(p_child:World3DObj):void
		{
			p_child.updateProject(self._camera.getTransform());
		});
		
		this._child.sort(function(p_obj0:World3DObj, p_obj1:World3DObj):int
		{
			if (p_obj0.project.z > p_obj1.project.z)
			{
				return 1;
			}
			if (p_obj0.project.z < p_obj1.project.z)
			{
				return -1;
			}
			return 0;
		});
		
		this.loopChild(function(p_child:World3DObj):void
		{
			var posX:Number = p_child.project.x;
			var posY:Number = p_child.project.y;
			var posZ:Number = p_child.project.z;
			var posW:Number = p_child.project.w;
			if (posW <= 0)
			{
				if (p_child.stand.visible)
				{
					p_child.stand.visible = false;
					container.removeChild(p_child.stand);
				}
				return;
			}
			if (posZ < 0 || posZ >= 1)
			{
				if (p_child.stand.visible)
				{
					p_child.stand.visible = false;
					container.removeChild(p_child.stand);
				}
				return;
			}
			posX /= posW;
			posY /= posW;
			p_child.stand.x = self._center.x + posX;
			p_child.stand.y = self._center.y - posY;
			p_child.stand.alpha = 1 - posZ;
			p_child.stand.visible = true;
			container.addChildAt(p_child.stand, 0);
		});
	}
	
	public function setCenter(p_x:Number, p_y:Number):void
	{
		this._center.x = p_x;
		this._center.y = p_y;
	}

}

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
					bmpData.setPixel32(i + p_radius, j + p_radius, 0xffff0000);
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

class ProjectWorld extends BasicContainer
{
	private static const CIRCLE_AMOUNT:int = 100;
	private static const CIRCLE_COLOR:int = 0xffff0000;
	private static const CIRCLE_RADIUS:int = 5;
	
	private var _timer:Timer = null;
	private var _world:World3D = null;
	
	public function ProjectWorld(p_inst:Sprite):void
	{
		super(null, p_inst);
		
		this._timer = new Timer(20);
		this._timer.addEventListener(TimerEvent.TIMER, this.onTime);
		
		this._world = new World3D(this);
		this._world.setCenter(300, 300);
		this._world.camera.position = new Vector3D(0, 0, -400);
		this._world.camera.target = new Vector3D(0, 0, 0);
		this._world.camera.up = new Vector3D(0, 1, 0);
		this._world.camera.setProject(600, 50, 200, 200);
		this.createCircle();
		
		this._timer.start();
		
		var slider:Slider = new Slider(this, 100, 100);
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
			var item:CircleItem = new CircleItem(CIRCLE_RADIUS, CIRCLE_COLOR);
			var item3D:World3DObj = this._world.addChild(item) as World3DObj;
			item3D.pos.x = (Math.random() * 2 - 1) * 200;
			item3D.pos.y = (Math.random() * 2 - 1) * 200;
			item3D.pos.z = (Math.random() * 2 - 1) * 200;
			
			var ratio:Number = 0;
			if (i % 3 > 0)
			{
				if (Math.abs(item3D.pos.x) > Math.abs(item3D.pos.y) && Math.abs(item3D.pos.x) > Math.abs(item3D.pos.z))
				{
					ratio = 200 / Math.abs(item3D.pos.x);
				}
				if (Math.abs(item3D.pos.y) > Math.abs(item3D.pos.z) && Math.abs(item3D.pos.y) > Math.abs(item3D.pos.x))
				{
					ratio = 200 / Math.abs(item3D.pos.y);
				}
				if (Math.abs(item3D.pos.z) > Math.abs(item3D.pos.x) && Math.abs(item3D.pos.z) > Math.abs(item3D.pos.y))
				{
					ratio = 200 / Math.abs(item3D.pos.z);
				}
			}
			else
			{
				ratio = 150 / Math.sqrt(item3D.pos.lengthStr());
			}
			item3D.pos.x *= ratio;
			item3D.pos.y *= ratio;
			item3D.pos.z *= ratio;
			this._world.addChild(item3D);
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
