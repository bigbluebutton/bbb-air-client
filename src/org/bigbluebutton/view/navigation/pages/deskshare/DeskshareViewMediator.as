package org.bigbluebutton.view.navigation.pages.deskshare
{
	import org.bigbluebutton.model.IConferenceParameters;
	import org.bigbluebutton.model.IUserSession;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class DeskshareViewMediator extends Mediator
	{
		[Inject]
		public var view:IDeskshareView;
		
		[Inject]
		public var userSession:IUserSession;
		
		[Inject]
		public var params:IConferenceParameters;

		public override function initialize():void
		{
			view.noDeskshareMessage.visible = view.noDeskshareMessage.includeInLayout = false;
			
			showDeskshare(userSession.deskshareConnection.streamWidth, userSession.deskshareConnection.streamHeight);
			userSession.deskshareConnection.isStreamingSignal.add(onDeskshareStreamChange);
		}
		
		/**
		 * On Deskshare View initialization - start the video stream
		 */  
		private function showDeskshare(width:Number, height:Number):void
		{
			view.startStream(userSession.deskshareConnection.connection, null, params.room, null, userSession.deskshareConnection.streamWidth, userSession.deskshareConnection.streamHeight);
		}
		
		/**
		 * If desktop sharing stream dropped - show notification message, remove video
		 */  
		public function onDeskshareStreamChange(isDeskshareStreaming:Boolean):void
		{
			view.noDeskshareMessage.visible = view.noDeskshareMessage.includeInLayout = !isDeskshareStreaming;
			
			if (!isDeskshareStreaming)
			{
				 view.stopStream();
			}
		}
		
		/**
		 * Unsibscribe from signal listeners
		 * Stop desktop sharing stream
		 */ 
		override public function destroy():void
		{
			userSession.deskshareConnection.isStreamingSignal.remove(onDeskshareStreamChange);
			view.stopStream();
		}
	}	
}