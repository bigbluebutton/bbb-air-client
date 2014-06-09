package org.bigbluebutton.view.navigation.pages.deskshare
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.URLRequest;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	import spark.components.Group;
	import org.bigbluebutton.view.navigation.pages.common.VideoView;
	
	public class DeskshareVideoView extends VideoView
	{
		private var _mouse:Bitmap;	
		
		public function DeskshareVideoView()
		{
			super();
		}
		
		public override function startStream(connection:NetConnection, name:String, streamName:String, userID:String, width:Number, height:Number, screenHeight:Number=0, screenWidth:Number=0):void
		{
			super.streamName = streamName;
			
			super.ns = new NetStream(connection);
			super.ns.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			super.ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
			super.ns.client = this;
			super.ns.bufferTime = 0;
			super.ns.receiveVideo(true);
			super.ns.receiveAudio(false);
			
			super.video.smoothing = true;
			super.video.attachNetStream(super.ns);
			
			super.originalVideoWidth = width;
			super.originalVideoHeight = height;
			
			super.screenHeight = screenHeight;
			super.screenWidth = screenWidth;
			
			rotateVideo(0, screenHeight, screenWidth);
			
			super.ns.play(streamName);
		}
		
		/**
		 * We can't add image to the stage, need to load the image as a bitmap
		 */  
		public function addMouseToStage():void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			var request:URLRequest = new URLRequest("assets/res/common/cursor.png");
			loader.load(request);
		}
		
		/**
		 * Once cursor bitmap loaded - add it to the stage
		 */  
		private function completeHandler(event:Event):void 
		{
			_mouse = Bitmap(event.target.loader.content);
			this.stage.addChild(_mouse);
		}
		
		/**
		 * Move mouse
		 * Based on provided values from the server need to recalculate position respecting current screen size and rotation
		 */  
		public function moveMouse(originalX:Number, originalY:Number):void
		{
			var reducedScreenPercentage:Number;
			
			// need to wait until mouse bitmap is loaded and added to the stage
			if(_mouse)
			{
				switch(super.video.rotation)
				{	
					// straight
					case 0:	
						
						if(super.video.height == super.screenHeight)
						{
							reducedScreenPercentage = super.originalVideoHeight / super.screenHeight;
						}
						else
						{
							reducedScreenPercentage = super.originalVideoWidth / super.screenWidth;
						}
						
						if (originalY <= 0)
						{
							_mouse.y = super.video.y;
						}
						else if (originalY/reducedScreenPercentage > super.video.height)
						{
							_mouse.y = super.video.y + super.video.height;
						}
						else
						{
							_mouse.y = super.video.y + originalY/reducedScreenPercentage;
						}
						
						if (originalX <= 0)
						{
							_mouse.x = super.video.x;
						}
						else if (originalX/reducedScreenPercentage > super.video.width)
						{
							_mouse.x = super.video.x + super.video.width;
						}
						else
						{
							_mouse.x = super.video.x + originalX/reducedScreenPercentage;
						}
						
						break;
					// left
					case -90:
						
						if(super.video.height == super.screenHeight)
						{
							reducedScreenPercentage = super.originalVideoHeight/super.video.width;
						}
						else
						{
							reducedScreenPercentage = super.originalVideoWidth/super.video.height;
						}
						
						if (originalY <= 0)
						{
							_mouse.x = super.video.x;
						}
						else if (originalY/reducedScreenPercentage > super.video.width)
						{
							_mouse.x = super.video.x +super.video.width;
						}
						else
						{
							_mouse.x = super.video.x + (originalY/reducedScreenPercentage);
						}
						
						if (originalX <= 0)
						{
							_mouse.y = super.video.y;
						}
						else if (originalX/reducedScreenPercentage > super.video.height)
						{
							_mouse.y = super.video.y - super.video.height;
						}
						else 
						{
							_mouse.y = super.video.y - (originalX/reducedScreenPercentage);
						}
						
						break;
					// right
					case 90:
						if(video.height == super.screenHeight)
						{
							reducedScreenPercentage = super.originalVideoHeight/super.video.width;
						}
						else
						{
							reducedScreenPercentage = super.originalVideoWidth/super.video.height;
						}
						
						if (originalY <= 0)
						{
							_mouse.x = super.video.x;
						}
						else if (originalY/reducedScreenPercentage > super.video.width)
						{
							_mouse.x = super.video.x - super.video.width;
						}
						else
						{
							_mouse.x = super.video.x - (originalY/reducedScreenPercentage);
						}
						
						if (originalX <= 0)
						{
							_mouse.y = super.video.y;
						}
						else if (originalX/reducedScreenPercentage > super.video.height)
						{
							_mouse.y = super.video.y + super.video.height;
						}
						else 
						{
							_mouse.y = super.video.y + (originalX/reducedScreenPercentage);
						}
						
						break;
					// upside down
					case 180:
						
						if(super.video.height == super.screenHeight)
						{
							reducedScreenPercentage  = super.originalVideoHeight / super.screenHeight;
						}
						else
						{
							reducedScreenPercentage  = super.originalVideoWidth / super.screenWidth;
						}
						
						if (originalY <= 0)
						{
							_mouse.y = super.video.y;
						}
						else if (originalY/reducedScreenPercentage > super.video.height)
						{
							_mouse.y = super.video.y - super.video.height;
						}
						else
						{
							_mouse.y = super.video.y - originalY/reducedScreenPercentage;
						}
						
						if (originalX <= 0)
						{
							_mouse.x = super.video.x;
						}
						else if (originalX/reducedScreenPercentage > super.video.width)
						{
							_mouse.x = super.video.x - super.video.width;
						}
						else
						{
							_mouse.x = super.video.x - originalX/reducedScreenPercentage;
						}
						break;					
				}
				
				_mouse.rotation = super.video.rotation;	
			}
		}
		
		public override function rotateVideo(rotation:Number, screenHeight:Number, screenWidth:Number):void
		{
			if (_mouse && stage.contains(_mouse))
			{
				stage.removeChild(_mouse);
			}
			
			if (super.video && stage.contains(super.video))
			{
				stage.removeChild(super.video);
			}
			
			super.video = new Video();
			super.video.attachNetStream(ns);
			
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
			
			super.video.rotation = rotation;
			this.stage.addChild(super.video);
			
			if (_mouse)
			{
				this.stage.addChild(_mouse);
			}
		}
		
		private function onNetStatus(e:NetStatusEvent):void{
			switch(e.info.code){
				case "NetStream.Publish.Start":
					trace("NetStream.Publish.Start for broadcast stream " + super.streamName);
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
		
		public override function close():void{
			if(super.video && this.stage.contains(super.video) )
			{
				this.stage.removeChild(video);
				super.video = null;
			}
			
			if(super.ns)
			{
				super.ns.removeEventListener( NetStatusEvent.NET_STATUS, onNetStatus);
				super.ns.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
				super.ns.close();
				super.ns = null;
			}
			
			if(_mouse && this.stage.contains(_mouse))
			{
				this.stage.removeChild(_mouse);
				_mouse = null;
			}
		}	
	}
}