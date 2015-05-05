package org.bigbluebutton.view.ui {
	
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import spark.components.Group;
	import spark.components.VideoDisplay;
	
	public class Video extends Group {
		private static var _connection:NetConnection;
		
		private static var _video:flash.media.Video = null;
		
		private static var _streamPublish:NetStream = null;
		
		private static var _streamSubscribe:NetStream = null;
		
		public function Video() {
			super();
			_video = new flash.media.Video();
			addChild(_video);
			invalidateDisplayList();
		}
		
		protected var _uri:String;
		
		public function set connect(uri:String):void {
			_uri = uri;
			_connection = new NetConnection();
			_connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			_connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			_connection.connect(_uri);
			_connection.client = this;
		}
		
		public function get connect():String {
			return _uri
		}
		
		protected var _streamName:String;
		
		public function set connectStream(streamName:String):void {
			_streamName = streamName;
			_streamSubscribe = new NetStream(_connection);
			_streamSubscribe.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			_streamSubscribe.client = this;
			_video.attachNetStream(_streamSubscribe);
			_streamSubscribe.play(_streamName);
		}
		
		public function get connectStream():String {
			return _uri
		}
		
		public function disconnect():void {
			if (_streamSubscribe != null)
				_streamSubscribe.close();
			if (_streamPublish != null)
				_streamPublish.close();
			if (_connection != null)
				_connection.close();
		}
		
		public function onPlayStatus(playStatus:Object):void {
			trace("+" + playStatus.code);
			switch (playStatus.code) {
				case 'NetStream.Play.Start':
					onPlaybackStart();
					break;
				case 'NetStream.Play.Complete':
					onPlaybackEnd();
					break;
			}
		}
		
		private function netStatusHandler(event:NetStatusEvent):void {
			switch (event.info.code) {
				case "NetConnection.Connect.Success":
					onConnectionSucess();
					break;
				case "NetConnection.Connect.Closed":
					onConnectionDisconnected();
					break;
				case "NetStream.Play.StreamNotFound":
					onConnectionFail();
					break;
				default:
					trace("++" + event.info.code);
					break;
			}
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			onConnectionFail();
		}
		
		private function onPlaybackStart():void {
		}
		
		private function onPlaybackEnd():void {
		}
		
		private function onConnectionSucess():void {
		}
		
		private function onConnectionDisconnected():void {
		}
		
		private function onConnectionFail():void {
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			if (_video) {
				_video.width = this.width;
				_video.height = this.height;
			}
		}
	}
}
