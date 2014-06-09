package org.bigbluebutton.core
{
	import flash.net.NetConnection;
	
	import org.bigbluebutton.model.IConferenceParameters;
	import org.bigbluebutton.model.IUserSession;
	
	public class DeskshareServiceSO extends BaseServiceSO implements IDeskshareServiceSO 
	{		
		[Inject]
		public var userSession:IUserSession;
		
		private static const SO_NAME:String = "-deskSO";
		
		public function DeskshareServiceSO()
		{
			super(SO_NAME);	
		}
		
		/**
		 * Connect to the Deskshare Shared Object
		 */ 
		override public function connect(connection:NetConnection, uri:String, params:IConferenceParameters):void
		{
			super.connect(connection, uri, params);
		}
		
		/**
		 * Invoked on the server once the clients' applet has started sharing and the server has started a video stream 
		 * 
		 */		
		public function appletStarted(videoWidth:Number, videoHeight:Number):void
		{
			trace("Deskshare Applet started sharing.");		
		}
		
		/**
		 * Called by the server when a notification is received to start viewing the broadcast stream.
		 * This method is called on successful execution of sendStartViewingNotification()
		 * 
		 */		
		public function startViewing(videoWidth:Number, videoHeight:Number):void
		{
			trace("DeskShare-startViewing.");
			userSession.deskshareConnection.streamWidth = videoWidth;
			userSession.deskshareConnection.streamHeight = videoHeight;
			userSession.deskshareConnection.isStreaming = true;
			userSession.deskshareConnection.isStreamingSignal.dispatch(userSession.deskshareConnection.isStreaming);
			
		}
		
		/**
		 * Called by the server to notify clients that the deskshare stream has stopped.
		 */
		public function deskshareStreamStopped():void 
		{
			trace("DeskShare-deskshareStreamStopped.");
			userSession.deskshareConnection.isStreaming = false;
			userSession.deskshareConnection.isStreamingSignal.dispatch(userSession.deskshareConnection.isStreaming);	
		}
		
		/**
		 * Called by the server to notify clients that mouse location has changed
		 */
		public function mouseLocationCallback(x:Number, y:Number):void 
		{	
			userSession.deskshareConnection.mouseLocationChangedSignal.dispatch(x, y);
		}
	}
}