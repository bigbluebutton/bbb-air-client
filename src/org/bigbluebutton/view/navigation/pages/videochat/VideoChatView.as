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
		private var webcam:WebcamView;

		public function VideoChatView():void	
		{
			
		}		
		
		override protected function childrenCreated():void
		{
			super.childrenCreated();
		}

		public function startStream(connection:NetConnection, name:String, streamName:String, userID:String, width:Number, height:Number):void 
		{
			if (webcam) stopStream();
			
			webcam = new WebcamView();
			webcam.percentWidth = 100;
			webcam.percentHeight = 100;
			webcam.startStream(connection, name, streamName, userID, width, height);		
			this.videoGroup.addElement(webcam);
			
			//invalidateDisplayList();
		}
				
		public function stopStream():void 
		{
			if(webcam)
			{
				webcam.close();
				
				if(this.videoGroup.containsElement(webcam))
				{
					this.videoGroup.removeElement(webcam);
				}
				
				webcam = null;
			}
		}
		
		
		public function dispose():void
		{
			stopStream();
		}
		
		public function get noVideoMessage():Label
		{
			return noVideoMessage0;
		}
		
		public function getDisplayedUserID():String {
			if (webcam != null) {
				return webcam.userID;
			} else {
				return null;
			}
		}
	}
}