package org.bigbluebutton.view.navigation.pages.common
{	
	import org.bigbluebutton.command.CheckDeskshareStreamSignal;
	import org.bigbluebutton.model.IUserSession;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class MenuButtonsViewMediator extends Mediator
	{
		[Inject]
		public var userSession:IUserSession
		
		[Inject]
		public var view:MenuButtonsView;
		
		[Inject] 
		public var checkDeskshareSignal:CheckDeskshareStreamSignal;
		
		public override function initialize():void
		{			
			//  On application startup check if somebody sharing their desktop  
			if (!userSession.deskshareConnection.streamCheckedOnStartup)
			{
				checkDeskshareSignal.dispatch();
				userSession.deskshareConnection.streamCheckedOnStartup = true;
			}
			
			userSession.deskshareConnection.isStreamingSignal.add(onDeskshareStreamChange);
			onDeskshareStreamChange(userSession.deskshareConnection.isStreaming);
		}
		
		/**
		 * If we recieve signal that deskshare stream is on - include Deskshare button to the layout
		 */ 
		public function onDeskshareStreamChange(isDeskshareStreaming:Boolean):void
		{
			view.menuDeskshareButton.visible = view.menuDeskshareButton.includeInLayout = isDeskshareStreaming;
		}
		
		/**
		 * Unsubscribe from listening for Deskshare Streaming Signal
		 */
		public override function destroy():void
		{
			userSession.deskshareConnection.isStreamingSignal.remove(onDeskshareStreamChange);
		}
	}
}