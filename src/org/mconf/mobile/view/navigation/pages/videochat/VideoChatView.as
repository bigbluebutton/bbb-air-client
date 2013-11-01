package org.mconf.mobile.view.navigation.pages.videochat
{
	import flash.events.MouseEvent;
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
			
		}

		public function startStream(connection:NetConnection, name:String, streamName:String, userID:String, width:Number, height:Number):void {
			var newCam:WebcamView = new WebcamView();
			webcamCollection.addItem(newCam);
			this.videoGroup.addElement(newCam);
			newCam.startStream(connection, name, streamName, userID, width, height);
		}
	}
}