package org.mconf.mobile.view.ui
{
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	import spark.components.Group;
	import spark.components.VideoDisplay;
	
	public class Video extends Group
	{
		private static var _connection:NetConnection;
		private static var _video:flash.media.Video = null;
		private static var _streamPublish:NetStream = null;
		private static var _streamSubscribe:NetStream = null;
		
		public function Video()
		{
			super();
		}
		
		public function connect(uri:String) {
			_connection = new NetConnection();
			_connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			_connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			
			_connection.connect(uri);
			_connection.client = this;
		}
		
		public function connectStream(streamName:String):void {
			_streamSubscribe = new NetStream(_connection);
			_streamSubscribe.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			_streamSubscribe.client = this;
			
			_video.attachNetStream(_streamSubscribe);
			
			_streamSubscribe.play(streamName );//+ "_enc");
		}
		
		public function disconnect() {
			if(_streamSubscribe!=null)
				_streamSubscribe.close();
			
			if(_streamPublish!=null)
				_streamPublish.close();
			
			if(_connection != null)
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
		
		private function onPlaybackStart():void
		{
			
		}

		private function onPlaybackEnd():void
		{
			
		}
		
		private function onPlaybackEnd():void
		{
			
		}
		
		private function onConnectionSucess():void
		{
			
		}
		
		private function onConnectionDisconnected():void
		{
			
		}
		
		private function onConnectionFail():void
		{
			
		}
	}
}