package org.bigbluebutton.view.navigation.pages.common
{
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.Timer;
	
	import mx.events.FlexEvent;
	import mx.graphics.SolidColor;
	import mx.graphics.SolidColorStroke;
	import mx.utils.ObjectUtil;
	
	import spark.components.Group;
	import spark.primitives.Rect;

	public class VideoView extends Group
	{
		private var ns:NetStream;
		private var _video:Video;
		private var streamName:String;
		private var _aspectRatio:Number = 0;

		public function get aspectRatio():Number
		{
			return _aspectRatio;
		}

		private var _userID:String;

		public function get userID():String
		{
			return _userID;
		}

		private var userName:String;

		public function VideoView() 
		{
			_video = new Video();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function onAddedToStage(event:Event):void
		{
			this.stage.addChild(_video);
			var point:Point = this.localToGlobal(new Point(0,0));
			_video.x = point.x;
			_video.y = point.y	
			setSizeRespectingAspectRationBasedOnWidth(stage.stageWidth);
		}
		
		public function startStream(connection:NetConnection, name:String, streamName:String, userID:String, width:Number, height:Number):void
		{
			this.userName = name;
			this._userID = userID;
			this.streamName = streamName;
			
			ns = new NetStream(connection);
			ns.addEventListener( NetStatusEvent.NET_STATUS, onNetStatus);
			ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
			ns.client = this;
			ns.bufferTime = 0;
			ns.receiveVideo(true);
			ns.receiveAudio(false);
			
			_video.smoothing = true;
			_video.attachNetStream(ns);
			setAspectRatio(width, height);
			
			ns.play(streamName);
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			//setSizeRespectingAspectRationBasedOnWidth(unscaledWidth);
			//_video.width = unscaledWidth;
			//_video.height = unscaledHeight;
		}
		
		protected function setAspectRatio(width:int,height:int):void {
			_aspectRatio = (width/height);
		}
		
		public function setSizeRespectingAspectRationBasedOnWidth(width0:Number):void {
			if(aspectRatio!=0)
			{
				_video.width = width0;
				_video.height = width0 / aspectRatio;
			}
		}
		
		public function setSizeRespectingAspectRationBasedOnHeight(height0:Number):void {
			if(aspectRatio!=0)
			{
				_video.width = height0;
				_video.height = height0 * aspectRatio;
			}
		}
		
		public function setSize(width0:Number, height0:Number):void {
			_video.width = width0;
			_video.height = height0;
		}
		
		private function onNetStatus(e:NetStatusEvent):void{
			switch(e.info.code){
				case "NetStream.Publish.Start":
					trace("NetStream.Publish.Start for broadcast stream " + streamName);
					break;
				case "NetStream.Play.UnpublishNotify":
					this.close();
					break;
				case "NetStream.Play.Start":
					trace("Netstatus: " + e.info.code);
					break;
				case "NetStream.Play.FileStructureInvalid":
					trace("The MP4's file structure is invalid.");
					break;
				case "NetStream.Play.NoSupportedTrackFound":
					trace("The MP4 doesn't contain any supported tracks");
					break;
			}
		}
		
		private function onAsyncError(e:AsyncErrorEvent):void{
			trace("VideoWindow::asyncerror " + e.toString());
		}
		
		
		public function removeVideo():void
		{
			if(_video && _video.stage)
			{
				_video.stage.removeChild(_video);
			}
		}
		
		public function close():void{
			if(_video && _video.stage)
			{
				_video.stage.removeChild(_video);
			}
			
			if(ns)
			{
				ns.removeEventListener( NetStatusEvent.NET_STATUS, onNetStatus);
				ns.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
				ns.close();
				ns = null;
			}
			
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}	
	}
}