package org.bigbluebutton.view.navigation.pages.deskshare
{
	import flash.net.NetConnection;
	
	import org.bigbluebutton.view.navigation.pages.common.VideoView;
	
	import spark.components.Group;
	import spark.components.Label;
	
	public class DeskshareView extends DeskshareViewBase implements IDeskshareView
	{
		private var deskshareCam:VideoView;
		
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
			if (deskshareCam) stopStream();
			
			deskshareCam = new VideoView();
			deskshareCam.percentWidth = 100;
			deskshareCam.percentHeight = 100;
			deskshareCam.startStream(connection, name, streamName, userID, width, height);		
			this.deskshareGroup.addElement(deskshareCam);
		}
		
		/**
		 * Close the video stream and remove video from layout
		 */ 
		public function stopStream():void 
		{
			if(deskshareCam)
			{
				deskshareCam.close();
				
				if(this.deskshareGroup.containsElement(deskshareCam))
				{
					this.deskshareGroup.removeElement(deskshareCam);
				}
				
				deskshareCam = null;
			}
		}
		
		/**
		 * Provide access to the notification message
		 */  
		public function get noDeskshareMessage():Label
		{
			return noDeskshareMessage0;
		}	
	}
}