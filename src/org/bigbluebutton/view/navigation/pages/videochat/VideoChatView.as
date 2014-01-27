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
		
		//		private var webcamCollection:ArrayCollection = new ArrayCollection;
		
		private var webcam:WebcamView;
		
		
		override protected function childrenCreated():void
		{
			super.childrenCreated();
			trace("The VideoChatView children have been created");
			//this.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		public function onClick(e:MouseEvent):void
		{
			//buttonTestSignal.dispatch();
		}

		public function dispose():void
		{
			trace("Cleaning the VideoChatView");
			cleanUpVideos();
		}
		
		public function cleanUpVideos():void {
//			trace("Cleaning up " + webcamCollection.length + " videos");
			
//			for (var i:Number=webcamCollection.length; i > 0; --i) {
//				var webcam:WebcamView = WebcamView(webcamCollection.getItemAt(i-1));
//				webcam.close();
//				videoGroup.removeElement(webcam);
//				webcamCollection.removeItemAt(i-1);
//			}
			
			if(webcam)
			{
				webcam.close();
				videoGroup.removeElement(webcam);
				webcam = null;
			}
		}

		public function startStream(connection:NetConnection, name:String, streamName:String, userID:String, width:Number, height:Number):void {
//			var newCam:WebcamView = new WebcamView();
//			webcamCollection.addItem(newCam);
//			this.videoGroup.addElement(newCam);
//			newCam.startStream(connection, name, streamName, userID, width, height);
			
			webcam = new WebcamView();
			webcam.percentWidth = 100;
			webcam.percentHeight = 100;
			this.videoGroup.addElement(webcam);
			webcam.startStream(connection, name, streamName, userID, width, height);
			
			invalidateDisplayList();
		}
		
		public function stopStream():void {//userID:String):void {
			/*			
			for (var i:Number=0; i < webcamCollection.length; ++i) {
				var webcam:WebcamView = WebcamView(webcamCollection.getItemAt(i))
				if (webcam.userID == userID) {
					webcam.close();
					videoGroup.removeElement(webcam);
					webcamCollection.removeItemAt(i);
					
					invalidateDisplayList();
					
					break;
				}
			}
			*/
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
		
		private function positionVideos(unscaledWidth:Number, unscaledHeight:Number):void {
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
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			if(webcam)
			{
				webcam.setSizeRespectingAspectRationBasedOnWidth(unscaledWidth);
			}
		}
	}
}