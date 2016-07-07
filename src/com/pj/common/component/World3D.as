package com.pj.common.component
{
	import com.pj.common.Helper;
	import com.pj.common.j3d.Camera3D;
	import com.pj.common.math.Matrix4D;
	import com.pj.common.math.Vector3D;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class World3D extends BasicObject implements com.pj.common.component.IContainer
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
			var mx:Matrix4D = this._camera.getTransform();
			this.loopChild(function(p_child:World3DObj):void
			{
				p_child.updateProject(mx);
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
						self.container.removeChild(p_child.stand);
					}
					return;
				}
				if (posZ < 0 || posZ >= 1)
				{
					if (p_child.stand.visible)
					{
						p_child.stand.visible = false;
						self.container.removeChild(p_child.stand);
					}
					return;
				}
				var invW:Number = 1 / posW;
				posX *= invW;
				posY *= invW;
				p_child.stand.x = self._center.x + posX;
				p_child.stand.y = self._center.y - posY;
				p_child.stand.alpha = 1 - posZ;
				p_child.stand.scaleX = invW;
				p_child.stand.scaleY = invW;
				p_child.stand.visible = true;
				self.container.addChildAt(p_child.stand, 0);
			});
		}
		
		public function setCenter(p_x:Number, p_y:Number):void
		{
			this._center.x = p_x;
			this._center.y = p_y;
		}
	
	}
}