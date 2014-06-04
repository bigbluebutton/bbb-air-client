package org.bigbluebutton.view.navigation.pages.common
{
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.geom.Point;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	import spark.components.Group;
	
	public class VideoView extends Group
	{
		private var ns:NetStream;
		private var _video:Video;
		private var streamName:String;
		private var _aspectRatio:Number = 0;
		
		private var _originalVideoWidth:Number;
		private var _originalVideoHeight:Number;
		
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
		
		public function VideoView() 
		{
			_video = new Video();
		}	
		
		public function startStream(connection:NetConnection, name:String, streamName:String, userID:String, width:Number, height:Number, screenHeight:Number=0, screenWidth:Number=0):void
		{
			this.userName = name;
			this._userID = userID;
			this.streamName = streamName;
			this._connection = connection;
			
			ns = new NetStream(connection);
			ns.addEventListener( NetStatusEvent.NET_STATUS, onNetStatus);
			ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
			ns.client = this;
			ns.bufferTime = 0;
			ns.receiveVideo(true);
			ns.receiveAudio(false);
			
			_video.smoothing = true;
			_video.attachNetStream(ns);
			
			_originalVideoWidth = width;
			_originalVideoHeight = height;
			
			rotateVideo(0, screenHeight, screenWidth);
			
			ns.play(streamName);
		}
		
		public function rotateVideoLeft(rotation:Number, screenHeight:Number, screenWidth:Number):void
		{	
			this.stage.removeChild(_video);
			
			_video = null;		
			_video = new Video();
			_video.attachNetStream(ns);
			
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
					_video.y = screenHeight;
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
			
			_video.rotation = rotation;	
			this.stage.addChild(_video);
		}
		
		public function rotateVideoRight(rotation:Number, screenHeight:Number, screenWidth:Number):void
		{
			this.stage.removeChild(_video);
			
			_video = null;			
			_video = new Video();
			_video.attachNetStream(ns);	
			
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
			
			_video.rotation = rotation;
			this.stage.addChild(_video);
		}
		
		public function rotateVideo(rotation:Number, screenHeight:Number, screenWidth:Number):void
		{	
			if (this.stage.contains(_video))
			{
				this.stage.removeChild(_video);
			}
			
			_video = null;		
			_video = new Video();
			_video.attachNetStream(ns);
			
			if (screenWidth < screenHeight) {
				
				_video.width = screenWidth;
				_video.height = (_video.width/_originalVideoWidth) * _originalVideoHeight;
				
				_video.x = 0;  
				_video.y = screenHeight/2 - _video.height/2;
				
				if (screenHeight < _video.height) {			
					_video.height = screenHeight;
					_video.width = ((_originalVideoWidth  * _video.height)/_originalVideoHeight);	
					_video.x =  screenWidth/2 - _video.width/2;
					_video.y = 50;	
				}				
			} else {
				
				_video.height = screenHeight;
				_video.width = ((_originalVideoWidth  * _video.height)/_originalVideoHeight);
				
				_video.x = (screenWidth/2) - (_video.width/2);
				_video.y = 50;
				
				if (screenWidth < _video.width) {
					_video.width = screenWidth;
					_video.height = (_video.width/_originalVideoWidth) * _originalVideoHeight;
					_video.x = 0;
					_video.y = (screenHeight/2) - (_video.height/2) +50;
				}			
			}
			
			_video.rotation = rotation;
			this.stage.addChild(_video);
		}
		
		public function rotateVideoUpsideDown(rotation:Number, screenHeight:Number, screenWidth:Number):void
		{
			this.stage.removeChild(_video);
			
			_video = null;		
			_video = new Video();
			_video.attachNetStream(ns);
			
			if (screenHeight < screenWidth) {	
				
				_video.height = screenHeight;
				_video.width = ((_originalVideoWidth  * _video.height)/_originalVideoHeight);
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
				_video.y = (screenHeight/2) + (_video.height/2)  +50;	
				
				if (screenHeight< _video.height) {
					_video.height = screenHeight;
					_video.width = ((_originalVideoWidth  * _video.height)/_originalVideoHeight);
					
					_video.x = screenWidth/2 + _video.width/2;
					_video.y = screenHeight+50;	
				}	
			}	
			
			_video.rotation = rotation;		
			this.stage.addChild(_video);
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
		
		public function get video():Video
		{
			return _video;
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
		}	
	}
}