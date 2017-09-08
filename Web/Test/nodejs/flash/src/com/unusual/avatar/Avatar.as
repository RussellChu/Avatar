package com.unusual.avatar
{
	import com.unusual.utils.IDisposable;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class Avatar implements IDisposable
	{
		private var _assets:AssetsManager = null;
		private var _inst:Sprite = null;
		
		public function Avatar(inst:Sprite)
		{
			this._inst = inst;
			this.init();
		}
		
		private function init():void
		{
			this._assets = new AssetsManager();
		}
		
		public function dispose():void
		{
			if (this._assets)
			{
				this._assets.dispose();
				this._assets = null;
			}
			this._inst = null;
		}
		
		public function clear(body:Boolean):void
		{
			for (var i:int = 0; i < this._inst.numChildren; i++)
			{
				var layer:Sprite = this._inst.getChildAt(i) as Sprite;
				if (body)
				{
					layer.removeChildren();
					layer.addChild(new Sprite());
					layer.addChild(new Sprite());
				}
				else
				{
					var sp:Sprite = layer.getChildAt(1) as Sprite;
					sp.removeChildren();
				}
			}
		}
		
		public function clearLayer(layerCode:int, body:Boolean):void
		{
			var layer:Sprite = this._inst.getChildByName('layer_' + layerCode) as Sprite;
			if (!layer)
			{
				return;
			}
			if (body)
			{
				layer.removeChildren();
				layer.addChild(new Sprite());
				layer.addChild(new Sprite());
			}
			else
			{
				
				var sp:Sprite = layer.getChildAt(1) as Sprite;
				sp.removeChildren();
			}
		}
		
		public function getAssetsData():Object
		{
			return this._assets.getGroup();
		}
		
		public function initLayer(value:int):void
		{
			this._inst.removeChildren();
			for (var i:int = 0; i < value; i++)
			{
				var layer:Sprite = new Sprite();
				layer.name = 'layer_' + i;
				layer.addChild(new Sprite());
				layer.addChild(new Sprite());
				this._inst.addChild(layer);
			}
		}
		
		public function showItem(layerCode:int, itemName:String, posX:int, posY:int, body:Boolean):void
		{
			var layer:Sprite = this._inst.getChildByName('layer_' + layerCode) as Sprite;
			if (!layer)
			{
				return;
			}
			
			var item:MovieClip = this._assets.getSwf(itemName);
			if (!item)
			{
				return;
			}
			
			item.x = posX;
			item.y = posY;
			var sp:Sprite = null;
			if (body)
			{
				sp = layer.getChildAt(0) as Sprite;
			}
			else
			{
				sp = layer.getChildAt(1) as Sprite;
			}
			sp.addChild(item);
		}
	
	}
}