package org.bigbluebutton.view.navigation.pages.common
{
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	import spark.components.Group;
	
	public class VideoView extends Group
	{
		protected var ns:NetStream;
		protected var video:Video;
		protected var streamName:String;
		protected var aspectRatio:Number = 0;
		
		protected var originalVideoWidth:Number;
		protected var originalVideoHeight:Number;
		
		protected var screenWidth:Number;
		protected var screenHeight:Number;
		
		protected var topMenuBarHeight:Number;
		protected var bottomMenuBarHeight:Number;
		
		protected var connection:NetConnection;
		
		public var userID:String;
		public var userName:String;
		
		public function VideoView():void
		{
			video = new Video();
		}	
		
		public function startStream(connection:NetConnection, name:String, streamName:String, userID:String, width0:Number, height0:Number, screenHeight0:Number=0, screenWidth0:Number=0, topMenuBarHeight0:Number=0, bottomMenuBarHeight0:Number=0):void
		{
			initializeScreenSizeValues(screenHeight0, screenWidth0, topMenuBarHeight0, bottomMenuBarHeight0, width0, height0);
			
			this.userName = name;
			this.userID = userID;
			this.streamName = streamName;
			this.connection = connection;
			
			initNetStream(connection);
		}
		
		public function initNetStream(connection:NetConnection):void
		{
			ns = new NetStream(connection);
			ns.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
			ns.client = {};
			ns.bufferTime = 0;
			ns.receiveVideo(true);
			ns.receiveAudio(false);
			
			video.smoothing = true;
			video.attachNetStream(ns);
			
			ns.play(streamName);
		}
		
		public function initializeScreenSizeValues(screenHeight0:Number, screenWidth0:Number, topMenuBarHeight0:Number, bottomMenuBarHeight0:Number, originalVideoWidth0:Number, originalVideoHeight0:Number):void
		{
			this.screenHeight = screenHeight0;
			this.screenWidth = screenWidth0;
			this.topMenuBarHeight = topMenuBarHeight0;
			this.bottomMenuBarHeight = bottomMenuBarHeight0;
			this.originalVideoWidth = originalVideoWidth0;
			this.originalVideoHeight = originalVideoHeight0;
		}
		
		public function resizeForPortrait():void
		{
			// if we have device where screen width less than screen height e.g. phone
			if (screenWidth < screenHeight) {
				
				// make the video width full width of the screen 
				video.width = screenWidth;
				// calculate height based on a video width, it order to keep the same aspect ratio
				video.height = (video.width/originalVideoWidth) * originalVideoHeight;
				
				// if calculated height appeared to be bigger than screen height, recalculuate the video size based on width
				if (screenHeight < video.height) {	
					// make the video height full height of the screen
					video.height = screenHeight;
					// calculate width based on a video height, it order to keep the same aspect ratio
					video.width = ((originalVideoWidth  * video.height) / originalVideoHeight);	
				}				
			} 
				// if we have device where screen height less than screen width e.g. tablet
			else {
				// make the video height full height of the screen
				video.height = screenHeight;
				// calculate width based on a video height, it order to keep the same aspect ratio
				video.width = ((originalVideoWidth  * video.height)/originalVideoHeight);
				
				// if calculated width appeared to be bigger than screen width, recalculuate the video size based on height
				if (screenWidth < video.width) {
					// make the video width full width of the screen 
					video.width = screenWidth;
					// calculate height based on a video width, it order to keep the same aspect ratio
					video.height = (video.width/originalVideoWidth) * originalVideoHeight;
				}
			}
		}
		
		public function resizeForLandscape():void
		{
			if (screenHeight < screenWidth)
			{
				video.height = screenWidth;
				video.width = ((originalVideoWidth * video.height)/originalVideoHeight);
				
				if (screenWidth < video.width)
				{
					video.width = screenHeight;
					video.height = (video.width/originalVideoWidth) * originalVideoHeight;
				}
			}
			else {
				video.width = screenHeight;
				video.height = (video.width/originalVideoWidth) * originalVideoHeight;
				
				if (screenHeight < video.height) {
					video.height = screenWidth;
					video.width = ((originalVideoWidth * video.height)/originalVideoHeight);
				}
			}
		}
		
		public function rotateVideo(rotation:Number):void
		{
			if (video && stage.contains(video))
			{
				stage.removeChild(video);
			}
			
			video = new Video();
			video.attachNetStream(ns);
			
			switch(rotation)
			{
				case 0:
					resizeForPortrait();
					video.x = screenWidth/2 - video.width/2;
					video.y = screenHeight/2 - video.height/2 + topMenuBarHeight;
					break;
				case -90:
					resizeForLandscape();
					video.x = (screenWidth/2) - (video.height/2);
					video.y = (screenHeight/2) + (video.width/2) + topMenuBarHeight;
					break;
				case 90:
					resizeForLandscape();
					video.x = (screenWidth/2) + (video.height/2);
					video.y = (screenHeight/2) - (video.width/2) + topMenuBarHeight;
					break;
				case 180:
					resizeForPortrait();
					video.x = screenWidth/2 + video.width/2;
					video.y = (screenHeight/2) + (video.height/2) + topMenuBarHeight
					break; 
			}
			
			video.rotation = rotation;
			this.stage.addChild(video);
		}
		
		protected function onNetStatus(e:NetStatusEvent):void{
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
		
		protected function onAsyncError(e:AsyncErrorEvent):void{
			trace("VideoWindow::asyncerror " + e.toString());
		}
		
		public function close():void{
			if(video  && this.stage.contains(video) )
			{
				this.stage.removeChild(video);
				video = null;
			}
			
			if(ns)
			{
				ns.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
				ns.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
				ns.close();
				ns = null;
			}
		}
	}
}