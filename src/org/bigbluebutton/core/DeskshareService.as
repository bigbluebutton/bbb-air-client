package org.bigbluebutton.core
{
	import flash.net.Responder;
	
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.IConferenceParameters;
	import org.bigbluebutton.model.IMessageListener;
	
	public class DeskshareService implements IDeskshareService
	{	
		[Inject]
		public var userSession:IUserSession;
		
		[Inject]
		public var deskshareServiceSO:IDeskshareServiceSO;
		
		[Inject]
		public var conferenceParams:IConferenceParameters;
		
		[Inject]
		public var presentMessageReceiver : IPresentMessageReceiver;
		
		private var responder:Responder;
		private var width:Number;
		private var height:Number;
		private var room:String;
		
		public function DeskshareService()
		{	
			responder = new Responder(
				function(result:Object):void
				{
					if(result != null && (result.publishing as Boolean))
					{
						this.width = result.width as Number;
						this.height = result.height as Number;
						trace("Desk Share stream is streaming [" + this.width + "," + this.height + "]"); 
						
						// if we receive result from the server, then somebody is sharing their desktop, get the stream width and height and dispatch the notification signal
						userSession.deskshareConnection.streamHeight = this.height;
						userSession.deskshareConnection.streamWidth = this.width;
						userSession.deskshareConnection.isStreaming = true;
						userSession.deskshareConnection.isStreamingSignal.dispatch(userSession.deskshareConnection.isStreaming);
					}
					else
					{
						trace("No deskshare stream being published");
					}
				},
				function(status:Object):void
				{
					trace("Error while trying to call remote method on the server");
				});
			
		}
		
		/**
		 * Request from the server if desktop share stream is publishing
		 */ 
		public function checkIfStreamIsPublishing(room:String):void
		{
			userSession.deskshareConnection.connection.call("deskshare.checkIfStreamIsPublishing", responder, room);
		}
		
		/**
		 * Connect to the Share Object to recieve callbacks from the server
		 */  
		public function connectDeskshareSO():void
		{
			deskshareServiceSO.connect(userSession.deskshareConnection.connection, userSession.deskshareConnection.applicationURI, conferenceParams);
		}
	}
}