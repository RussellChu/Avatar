package com.pj
{
	import com.pj.common.component.BasicContainer;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Russell
	 */
	public class ProjectMP4 extends BasicContainer
	{
		public function ProjectMP4(p_inst:Sprite):void
		{
			super(null, p_inst);
			var video:JVideo = new JVideo("test.mp4", this);
		}
	
	}
}

import com.pj.common.component.BasicObject;
import com.pj.common.component.IContainer;
import flash.events.AsyncErrorEvent;
import flash.events.NetStatusEvent;
import flash.media.Video;
import flash.net.NetConnection;
import flash.net.NetStream;

class JVideo extends BasicObject
{
	private var _ns:NetStream = null;
	
	public function JVideo(p_path:String, p_parent:IContainer):void
	{
		super(new Video(), p_parent);
		
		var nc:NetConnection = new NetConnection();
		nc.connect(null);
		this._ns = new NetStream(nc);
		
		// for onMetaData, onPlayStatus
		this._ns.client = this;
		
		this._ns.addEventListener(NetStatusEvent.NET_STATUS, this.onNetStatusHandle);
		this._ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.onAsyncErrorHandle);
		
		this._ns.play(p_path);
		var vid:Video = this.video;
		vid.attachNetStream(this._ns);
	}
	
	override public function dispose():void
	{
		super.dispose();
	}
	
	private function get video():Video
	{
		return this.instance as Video;
	}
	
	private function onAsyncErrorHandle(p_evt:AsyncErrorEvent):void
	{
		trace("onAsyncErrorHandle >> ", p_evt.toString());
	}
	
	public function onMetaData(p_info:Object):void
	{
		trace("onMetaData: " + p_info);
		for (var key:String in p_info)
		{
			trace(" - " + key + " >> " + p_info[key]);
		}
		
	//	this._ns.seek(80);
	}
	
	private function onNetStatusHandle(p_evt:NetStatusEvent):void
	{
		trace("onNetStatusHandle >> ", p_evt.info.code);
		switch(p_evt.info.code){
			case "NetStream.Play.Start":
			//	this._ns.seek(80);
				break;
			case "NetStream.Buffer.Full":
				break;
			case "NetStream.Buffer.Flush":
				break;
			case "NetStream.Play.Stop":
				break;
			case "NetStream.Play.Complete":
				break;
			case "NetStream.Play.Empty":
				break;
		}
	}
	
	public function onPlayStatus(p_info:Object):void
	{
		trace("onPlayStatus: " + p_info.code);
		switch(p_info.code){
			case "NetStream.Play.Complete":
				break;
		}
	}

}
