package org.mconf.mobile.view.navigation.pages.videochat
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.NetConnection;
	
	import mx.charts.renderers.WedgeItemRenderer;
	import mx.collections.ArrayCollection;
	
	public class VideoChatView extends VideoChatViewBase implements IVideoChatView
	{
		private var webcamCollection:ArrayCollection = new ArrayCollection;
		
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
		}
		
		public function cleanUpVideos():void {
			trace("Cleaning up " + webcamCollection.length + " videos");
			
			for (var i:Number=webcamCollection.length; i > 0; --i) {
				var webcam:WebcamView = WebcamView(webcamCollection.getItemAt(i-1))
				webcam.close();
				videoGroup.removeElement(webcam);
				webcamCollection.removeItemAt(i-1);
			}
		}

		public function startStream(connection:NetConnection, name:String, streamName:String, userID:String, width:Number, height:Number):void {
			var newCam:WebcamView = new WebcamView();
			webcamCollection.addItem(newCam);
			this.videoGroup.addElement(newCam);
			newCam.startStream(connection, name, streamName, userID, width, height);
			
			positionVideos();
		}
		
		public function stopStream(userID:String):void {
			for (var i:Number=0; i < webcamCollection.length; ++i) {
				var webcam:WebcamView = WebcamView(webcamCollection.getItemAt(i))
				if (webcam.userID == userID) {
					webcam.close();
					videoGroup.removeElement(webcam);
					webcamCollection.removeItemAt(i);
					
					positionVideos();
					
					break;
				}
			}
		}
		
		private function positionVideos():void {
			var webcamWidth:Number = videoGroup.width /2;
			var webcamHeight:Number = webcamWidth/320 * 240;
			
			trace("Setting webcam dimensions [ " + webcamWidth + "," + webcamHeight + " ]");
			for (var i:Number=0; i < webcamCollection.length; ++i) {
				var webcam:WebcamView = WebcamView(webcamCollection.getItemAt(i))
				
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
			}
		}
	}
}