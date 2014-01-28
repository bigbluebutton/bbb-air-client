package org.bigbluebutton.view.navigation.pages.videochat
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.NetConnection;
	
	import mx.charts.renderers.WedgeItemRenderer;
	import mx.collections.ArrayCollection;
	import mx.graphics.SolidColor;
	import mx.graphics.SolidColorStroke;
	
	import spark.components.Label;
	import spark.primitives.Rect;
	
	public class VideoChatView extends VideoChatViewBase implements IVideoChatView
	{

		public function VideoChatView():void	
		{
			
		}
		
		private var webcam:WebcamView;
		
		
		override protected function childrenCreated():void
		{
			super.childrenCreated();
		}

		public function dispose():void
		{
			cleanUpVideos();
		}
		
		public function cleanUpVideos():void 
		{			
			if(webcam)
			{
				webcam.close();
				videoGroup.removeElement(webcam);
				webcam = null;
			}
		}

		public function startStream(connection:NetConnection, name:String, streamName:String, userID:String, width:Number, height:Number):void 
		{
			webcam = new WebcamView();
			webcam.percentWidth = 100;
			webcam.percentHeight = 100;
			webcam.startStream(connection, name, streamName, userID, width, height);
			this.videoGroup.addElement(webcam);
			
			invalidateDisplayList();
		}
		
		public function stopStream():void 
		{
			if(webcam)
			{
				webcam.close();
				videoGroup.removeElement(webcam);
				
				invalidateDisplayList();
			}
		}
		
		public function get noVideoMessage():Label
		{
			return noVideoMessage0;
		}
		
//		private function positionVideo(unscaledWidth:Number, unscaledHeight:Number):void {
			//var webcamWidth:Number = videoGroup.width /2;
			//var webcamHeight:Number = webcamWidth/320 * 240;
			
//			trace("Setting webcam dimensions [ " + unscaledWidth + "," + unscaledHeight + " ]");
//			for (var i:Number=0; i < webcamCollection.length; ++i) {
//				var webcam:WebcamView = WebcamView(webcamCollection.getItemAt(i))
				
				/*
				var x:Number, y:Number;
				if (i%2==0) { // place on the left
					x = 0;
					y = i/2 * webcamHeight;
				} else {
					x = webcamWidth;
					y = (i-1)/2 * webcamHeight;
				}
				
				var point:Point = videoGroup.localToGlobal(new Point(x,y));
					
				trace("Positioning webcam for " + webcam.userName + " [ " + webcamWidth + "," + webcamHeight + "," + point.x + "," + point.y + " ] ");
				WebcamView(webcamCollection.getItemAt(i)).setPosition(webcamWidth, webcamHeight, point.x, point.y);
				*/
				
//				webcam.setPosition(unscaledWidth, unscaledHeight, 0, 0);
//			}
//		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			if(webcam)
			{
				//webcam.setSizeRespectingAspectRationBasedOnWidth(unscaledWidth);
			}
		}
	}
}