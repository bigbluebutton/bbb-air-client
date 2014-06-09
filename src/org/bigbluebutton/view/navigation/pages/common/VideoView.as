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
		private var _ns:NetStream;
		private var _video:Video;
		private var _streamName:String;
		private var _aspectRatio:Number = 0;
		
		private var _originalVideoWidth:Number;
		private var _originalVideoHeight:Number;
		
		private var _screenWidth:Number;
		private var _screenHeight:Number;
		
		private var _connection:NetConnection;
		private var _userID:String;
		
		private var userName:String;
		
		public function get aspectRatio():Number
		{
			return _aspectRatio;
		}
		
		public function get userID():String
		{
			return _userID;
		}
		
		public function get video():Video
		{
			return _video;
		}
		
		public function set video(value:Video):void
		{
			_video = value;
		}
		
		public function get streamName():String
		{
			return _streamName;
		}
		
		public function set streamName(value:String):void
		{
			_streamName = value;
		}
		
		public function get ns():NetStream
		{
			return _ns;
		}
		
		public function set ns(value:NetStream):void
		{
			_ns = value;
		}
		
		public function set screenWidth(value:Number):void
		{
			_screenWidth = value;
		}
		
		public function get screenWidth():Number
		{
			return _screenWidth;
		}
		
		public function set screenHeight(value:Number):void
		{
			_screenHeight = value;
		}
		
		public function get screenHeight():Number
		{
			return _screenHeight;
		}
		
		public function set originalVideoWidth(value:Number):void
		{
			_originalVideoWidth = value;
		}
		
		public function get originalVideoWidth():Number
		{
			return _originalVideoWidth;
		}
		
		public function set originalVideoHeight(value:Number):void
		{
			_originalVideoHeight = value;
		}
		
		public function get originalVideoHeight():Number
		{
			return _originalVideoHeight;
		}
		
		public function VideoView():void
		{
			_video = new Video();
		}	
		
		public function startStream(connection:NetConnection, name:String, streamName:String, userID:String, width:Number, height:Number, screenHeight:Number=0, screenWidth:Number=0):void
		{
			this.userName = name;
			this._userID = userID;
			this._streamName = streamName;
			this._connection = connection;
			
			_ns = new NetStream(connection);
			_ns.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			_ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
			_ns.client = this;
			_ns.bufferTime = 0;
			_ns.receiveVideo(true);
			_ns.receiveAudio(false);
			
			_video.smoothing = true;
			_video.attachNetStream(_ns);
			
			_originalVideoWidth = width;
			_originalVideoHeight = height;
			
			_screenHeight = screenHeight;
			_screenWidth = screenWidth;
			
			rotateVideo(0, screenHeight, screenWidth);
			
			_ns.play(streamName);
		}
		
		public function resizeVideoRotatedUpsideDown(screenHeight:Number, screenWidth:Number):void
		{
			if (screenHeight < screenWidth) {	
				
				_video.height = screenHeight;
				_video.width = ((_originalVideoWidth  * _video.height) / _originalVideoHeight);
				_video.x = screenWidth/2 + _video.width/2;
				_video.y = screenHeight+50;
				
				if (screenWidth < _video.width) {
					_video.width = screenWidth;
					_video.height = (_video.width/_originalVideoWidth) * _originalVideoHeight;
					
					_video.x = screenWidth;	
					_video.y = screenHeight/2 + _video.height/2 + 50; 
				}				
			}
			else 
			{						
				_video.width = screenWidth;
				_video.height = (_video.width/_originalVideoWidth) * _originalVideoHeight;
				
				_video.x = screenWidth;
				_video.y = (screenHeight/2) + (_video.height/2) + 50;	
				
				if (screenHeight< _video.height) {
					_video.height = screenHeight;
					_video.width = ((_originalVideoWidth  * _video.height) / _originalVideoHeight);
					_video.x = screenWidth/2 + _video.width/2;
					_video.y = screenHeight + 50;
				}	
			}
		}
		
		public function resizeVideoRotatedStraight(screenHeight:Number, screenWidth:Number):void
		{
			// if we have device where screen width less than screen height e.g. phone
			if (screenWidth < screenHeight) {
				
				// make the video width full width of the screen 
				_video.width = screenWidth;
				// calculate height based on a video width, it order to keep the same aspect ratio
				_video.height = (_video.width/_originalVideoWidth) * _originalVideoHeight;
				
				// align to video to the left side of the screen
				_video.x = 0;  
				// place the video at the middle of the screen based on height
				_video.y = screenHeight/2 - _video.height/2;
				
				// if calculated height appeared to be bigger than screen height, recalculuate the video size based on width
				if (screenHeight < _video.height) {	
					// make the video height full height of the screen
					_video.height = screenHeight;
					// calculate width based on a video height, it order to keep the same aspect ratio
					_video.width = ((_originalVideoWidth  * _video.height)/_originalVideoHeight);	
					
					// place the video at the middle of the screen based on width
					_video.x = screenWidth/2 - _video.width/2;
					// place video 50 pixels lower in order to keep space for menu bar
					_video.y = 50;	
				}				
			} 
				// if we have device where screen height less than screen width e.g. tablet
			else {
				// make the video height full height of the screen
				_video.height = screenHeight;
				// calculate width based on a video height, it order to keep the same aspect ratio
				_video.width = ((_originalVideoWidth  * _video.height)/_originalVideoHeight);
				
				// place the video at the middle of the screen based on width
				_video.x = (screenWidth/2) - (_video.width/2);
				// place video 50 pixels lower in order to keep space for menu bar
				_video.y = 50;
				
				// if calculated width appeared to be bigger than screen width, recalculuate the video size based on height
				if (screenWidth < _video.width) {
					// make the video width full width of the screen 
					_video.width = screenWidth;
					// calculate height based on a video width, it order to keep the same aspect ratio
					_video.height = (_video.width/_originalVideoWidth) * _originalVideoHeight;
					// align to video to the left side of the screen
					_video.x = 0;  
					// place the video at the middle of the screen based on height
					_video.y = screenHeight/2 - _video.height/2 + 50;
				}			
			}
		}
		
		public function resizeVideoRotatedLeft(screenHeight:Number, screenWidth:Number):void
		{
			if (screenHeight < screenWidth) 
			{		
				_video.height = screenWidth;
				_video.width = ((_originalVideoWidth * _video.height)/_originalVideoHeight);
				_video.y = (screenHeight/2) + (_video.width/2)+50;
				_video.x = 0;
				
				if (screenWidth < _video.width) 
				{
					_video.width = screenHeight;
					_video.height = (_video.width/_originalVideoWidth) * _originalVideoHeight;
					_video.y = screenHeight+50;
					_video.x = (screenWidth/2) - (_video.height/2);
				}		
			} 
			else {			
				_video.width = screenHeight;
				_video.height = (_video.width/_originalVideoWidth) * _originalVideoHeight;
				_video.y = screenHeight + 50;
				_video.x = (screenWidth/2) - (_video.height/2);
				
				if (screenHeight < _video.height) {
					_video.height = screenWidth;
					_video.width = ((_originalVideoWidth * _video.height)/_originalVideoHeight);
					_video.y = (screenHeight/2) + (_video.width/2);
					_video.x = 0;
				}	
			}	
		}
		
		public function resizeVideoRotatedRight(screenHeight:Number, screenWidth:Number):void
		{
			if (screenHeight < screenWidth) {	
				_video.height = screenWidth;
				_video.width = ((_originalVideoWidth * _video.height)/_originalVideoHeight);
				_video.x = screenWidth;
				_video.y = (screenHeight/2) - (_video.width/2)+50;
				
				if (screenWidth < _video.width) {
					_video.width = screenHeight;
					_video.height = (screenHeight/_originalVideoWidth) * _originalVideoHeight;
					_video.x = (screenWidth/2) + (_video.height/2);
					_video.y = 50;
				}					
			} 
			else 
			{	
				_video.width = screenHeight;
				_video.height = (screenHeight/_originalVideoWidth) * _originalVideoHeight;
				_video.x = (screenWidth/2) + (_video.height/2);
				_video.y = 50;
				
				if (screenHeight < _video.height) {
					_video.height = screenWidth;
					_video.width = ((_originalVideoWidth * _video.height)/_originalVideoHeight);
					_video.x = screenWidth;
					_video.y = (screenHeight/2) - (_video.width/2);
				}		
			}
		}
		
		public function rotateVideo(rotation:Number, screenHeight:Number, screenWidth:Number):void
		{
			if (_video && stage.contains(_video))
			{
				stage.removeChild(_video);
			}
			
			_video = new Video();
			_video.attachNetStream(_ns);
			
			switch(rotation)
			{
				case 0:
					resizeVideoRotatedStraight(screenHeight, screenWidth);
					break;
				case -90:
					resizeVideoRotatedLeft(screenHeight, screenWidth);
					break;
				case 90:
					resizeVideoRotatedRight(screenHeight, screenWidth);
					break;
				case 180:
					resizeVideoRotatedUpsideDown(screenHeight, screenWidth);
					break;	
			}
			
			_video.rotation = rotation;
			this.stage.addChild(_video);
		}
		
		private function onNetStatus(e:NetStatusEvent):void{
			switch(e.info.code){
				case "NetStream.Publish.Start":
					trace("NetStream.Publish.Start for broadcast stream " + _streamName);
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
			if(_video  && this.stage.contains(_video) )
			{
				this.stage.removeChild(_video);
				_video = null;
			}
			
			if(_ns)
			{
				_ns.removeEventListener( NetStatusEvent.NET_STATUS, onNetStatus);
				_ns.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
				_ns.close();
				_ns = null;
			}
		}	
	}
}