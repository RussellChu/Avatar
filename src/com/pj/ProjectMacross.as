package com.pj
{
	import com.pj.common.JColor;
	import com.pj.common.component.BasicContainer;
	import com.pj.common.component.IContainer;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class ProjectMacross extends BasicContainer
	{
		private static const MAP_START_X:int = 0;
		private static const MAP_START_Y:int = 0;
		private static const MAP_RADIUS:int = 48;
		private static const BTN_RADIUS:int = 4;
		
		public function ProjectMacross(p_inst:Sprite = null)
		{
			super(null, p_inst);
		}
		
		override public function dispose():void
		{
			super.dispose();
		}
		
		override protected function init():void
		{
			super.init();
			
			var btnGroup:ButtonHexagonGroup = new ButtonHexagonGroup(this);
			btnGroup.createMap(MAP_START_X, MAP_START_Y, MAP_RADIUS, BTN_RADIUS, new JColor(0.8, 0.8, 0.7, 1).value, new JColor(0.9, 0.9, 0.9, 1).value, new JColor(0.8, 0.8, 0.9, 1).value);
		}
		
		override public function reset():void
		{
			super.reset();
		}
	
	}

}

import com.pj.common.JColor;
import com.pj.common.component.AbstractButton;
import com.pj.common.component.BasicButton;
import com.pj.common.component.BasicContainer;
import com.pj.common.component.IContainer;
import com.pj.common.component.SimpleButton;
import flash.display.BitmapData;

class ButtonHexagon extends BasicButton
{
	
	public function ButtonHexagon(p_title:String, p_width:int, p_height:int, p_bmpDown:BitmapData, p_bmpIdle:BitmapData, p_bmpOver:BitmapData, p_data:Object = null):void
	{
		super(p_title, p_width, p_height, p_bmpDown, p_bmpIdle, p_bmpOver, p_data);
	}
}

class ButtonHexagonGroup extends BasicContainer
{
	private var _bmpDown:BitmapData = null;
	private var _bmpIdle:BitmapData = null;
	private var _bmpOver:BitmapData = null;
	
	private var _mapBtn:Object = null;
	
	public function ButtonHexagonGroup(p_parent:IContainer):void
	{
		super(p_parent);
	}
	
	public override function dispose():void
	{
		if (this._bmpDown)
		{
			this._bmpDown.dispose();
			this._bmpDown = null;
		}
		if (this._bmpIdle)
		{
			this._bmpIdle.dispose();
			this._bmpIdle = null;
		}
		if (this._bmpOver)
		{
			this._bmpOver.dispose();
			this._bmpOver = null;
		}
		super.dispose();
	}
	
	protected override function init():void
	{
		super.init();
	}
	
	public override function reset():void
	{
		super.reset();
	}
	
	public function createMap(p_startX:Number, p_startY:Number, p_mapRadius:int, p_btnRadius:Number, p_colorDown:uint, p_colorIdle:uint, p_colorOver:uint):void
	{
		var w:int = p_btnRadius * 2;
		var h:int = p_btnRadius * 1.732;
		this._bmpDown = new BitmapData(w, h, true, 0);
		this._bmpIdle = new BitmapData(w, h, true, 0);
		this._bmpOver = new BitmapData(w, h, true, 0);
		this._bmpDown.lock();
		this._bmpIdle.lock();
		this._bmpOver.lock();
		
		for (var i:int = 0; i < w; i++)
		{
			for (var j:int = 0; j < h; j++)
			{
				var b0:Boolean = (4 * h * i + 2 * w * j - w * h > 0);
				var b1:Boolean = (-4 * h * i + 2 * w * j - w * h < 0);
				var b2:Boolean = (4 * h * i + 2 * w * j - 5 * w * h < 0);
				var b3:Boolean = (-4 * h * i + 2 * w * j + 3 * w * h > 0);
				if (b0 && b1 && b2 && b3)
				{
					this._bmpDown.setPixel32(i, j, p_colorDown);
					this._bmpIdle.setPixel32(i, j, p_colorIdle);
					this._bmpOver.setPixel32(i, j, p_colorOver);
				}
			}
		}
		this._bmpDown.unlock();
		this._bmpIdle.unlock();
		this._bmpOver.unlock();
		
		this._mapBtn = {};
		var id:int = 0;
		for (var yid:int = 0; yid < p_mapRadius * 2 - 1; yid++) {
			var len:int = p_mapRadius + yid;
			if ( yid >= p_mapRadius ) {
				len = p_mapRadius * 3 - 2 - yid;
			}
			for (var xid:int = 0; xid < len; xid++) {
				var x:int = xid;
				var y:int = yid;
				if ( yid >= p_mapRadius ) {
					x += yid - p_mapRadius + 1;
				}
				var data:Object = { //
					id: id //
					, x: x //
					, y: y //
				};
				var btn:ButtonHexagon = new ButtonHexagon(data.id, w, h, this._bmpDown, this._bmpIdle, this._bmpOver, data);
				this._mapBtn[id] = btn;
				btn.instance.x = p_startX + (xid + p_mapRadius - (len + 1 ) * 0.5) * w;
				btn.instance.y = p_startY + yid * h;
				this.addChild(btn);
				
				id++;
			}
		}
	}

}