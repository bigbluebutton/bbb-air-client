package org.bigbluebutton.view.navigation.pages.videochat
{
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.Timer;
	
	import mx.utils.ObjectUtil;
	
	import spark.components.Group;

	public class WebcamView extends Group
	{
		private var ns:NetStream;
		private var _video:Video;
		private var streamName:String;
		private var aspectRatio:Number;
		public var userID:String;
		public var userName:String;
		static public var PADDING_HORIZONTAL:Number = 5;
		static public var PADDING_VERTICAL:Number = 5;
		
		/*
		private var timer:Timer = new Timer(2000);
		
		private function onHeartbeat(e:Event=null):void {
			trace(ObjectUtil.toString(ns.info));
		}
		*/
		
		public function WebcamView() {
			//timer.addEventListener(TimerEvent.TIMER, onHeartbeat);
			//timer.start();
		}
		
		public function startStream(connection:NetConnection, name:String, streamName:String, userID:String, width:Number, height:Number):void
		{
			ns = new NetStream(connection);
			ns.addEventListener( NetStatusEvent.NET_STATUS, onNetStatus);
			ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
			ns.client = this;
			ns.bufferTime = 0;
			ns.receiveVideo(true);
			ns.receiveAudio(false);
			
			//width = width/2;
			//height = height/2;
			
			_video = new Video(width, height);
			_video.width = width;
			_video.height = height;
			_video.smoothing = true;
			//setAspectRatio(width, height); 
			_video.attachNetStream(ns);
			
			ns.play(streamName);
			this.streamName = streamName;
			
			this.width = _video.width;//+ paddingHorizontal;
			this.height = _video.height;// + paddingVertical;
			
			var point:Point = this.localToGlobal(new Point(0,0));
			this.stage.addChild(_video);
			_video.x = point.x;
			_video.y = point.y;
			
			//_video.z = 1;
			this.userName = name;
			this.userID = userID;
			//trace("Video position [" + _video.getRect(this) + "]");
			//trace("Video position: " + ObjectUtil.toString(_video));
		}
		
		protected function setAspectRatio(width:int,height:int):void {
			aspectRatio = (width/height);
			this.minHeight = Math.floor((this.minWidth - PADDING_HORIZONTAL) / aspectRatio) + PADDING_VERTICAL;
		}
		
		public function setPosition(width:Number, height:Number, x:Number, y:Number):void {
			_video.width = width;
			_video.height = height;
			_video.x = x;
			_video.y = y;
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
		
		public function close():void{
			stage.removeChild(_video);
			ns.close();
			//onCloseEvent();
			//super.close(event);
		}	
	}
}