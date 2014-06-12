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
		
		private var responder:Responder;
		private var room:String;
		
		public function DeskshareService()
		{	
			responder = new Responder(
				function(result:Object):void
				{
					if(result != null && (result.publishing as Boolean))
					{	
						userSession.deskshareConnection.streamHeight = result.height as Number;
						userSession.deskshareConnection.streamWidth = result.width as Number;
						 
						trace("Desk Share stream is streaming [" + userSession.deskshareConnection.streamWidth + "," + userSession.deskshareConnection.streamHeight + "]"); 
						
						// if we receive result from the server, then somebody is sharing their desktop - dispatch the notification signal
						userSession.deskshareConnection.isStreaming = true;
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