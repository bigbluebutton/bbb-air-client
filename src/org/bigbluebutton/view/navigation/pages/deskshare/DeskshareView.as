package org.bigbluebutton.view.navigation.pages.deskshare
{
	import flash.display.StageOrientation;
	import flash.net.NetConnection;
	
	import org.bigbluebutton.view.navigation.pages.common.VideoView;
	
	import spark.components.Group;
	import spark.components.Label;
	
	public class DeskshareView extends DeskshareViewBase implements IDeskshareView
	{
		private var deskshareVideoView:VideoView;
		
		/**
		 * Provide access to the group containing video
		 */  
		public function get deskshareGroup():Group
		{		
			return deskshareGroup0;
		}
		
		/**
		 *  Create VideoView with the desktop sharing stream and add it to the layout 
		 */ 
		public function startStream(connection:NetConnection, name:String, streamName:String, userID:String, width:Number, height:Number):void 
		{
			if (deskshareVideoView) stopStream();
			
			deskshareVideoView = new VideoView();
			deskshareVideoView.percentWidth = 100;
			deskshareVideoView.percentHeight = 100;
			this.addElement(deskshareVideoView);
			deskshareVideoView.startStream(connection, name, streamName, userID, width, height, this.deskshareGroup.height, this.deskshareGroup.width);					
		}		
		
		/**
		 * Close the video stream and remove video from layout
		 */ 
		public function stopStream():void 
		{
			if(deskshareVideoView)
			{
				deskshareVideoView.close();
				
				if(this.deskshareGroup.containsElement(deskshareVideoView))
				{
					this.deskshareGroup.removeElement(deskshareVideoView);
				}
				
				deskshareVideoView = null;
			}
		}
		
		/**
		 * Provide access to the notification message
		 */  
		public function get noDeskshareMessage():Label
		{
			return noDeskshareMessage0;
		}	
		
		override public function rotationHandler(rotation:String):void {
			if (deskshareVideoView != null)
			{
				switch (rotation) {
					case StageOrientation.ROTATED_LEFT:
						deskshareVideoView.rotateVideoLeft(-90, this.deskshareGroup.height, this.deskshareGroup.width);
						break;
					case StageOrientation.ROTATED_RIGHT:
						deskshareVideoView.rotateVideoRight(90, this.deskshareGroup.height, this.deskshareGroup.width);
						break;
					case StageOrientation.UPSIDE_DOWN:
						deskshareVideoView.rotateVideoUpsideDown(180, this.deskshareGroup.height, this.deskshareGroup.width);
						break;
					case StageOrientation.DEFAULT:
					case StageOrientation.UNKNOWN:
					default:
						deskshareVideoView.rotateVideo(0,this.deskshareGroup.height, this.deskshareGroup.width);
				}	
			}
		}
	}
}