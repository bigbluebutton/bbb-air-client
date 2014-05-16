package org.bigbluebutton.view.navigation.pages.disconnect
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.IUserUISession;
	import org.bigbluebutton.model.UserSession;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class DisconnectPageViewMediator extends Mediator
	{	
		[Inject]
		public var view:IDisconnectPageView;
		
		[Inject] 
		public var userSession:IUserSession;
		
		[Inject]
		public var userUISession:IUserUISession;
			
		override public function initialize():void
		{
			view.exitButton.addEventListener(MouseEvent.CLICK, applicationExit);
			changeConnectionStatus(userUISession.currentPageDetails as int);
		}
		
		/**
		 * Sets the disconnect status based on disconnectionStatusCode recieved from DisconnectUserCommand
		 */ 
		public function changeConnectionStatus(disconnectionStatusCode:int):void
		{
			switch(disconnectionStatusCode)
			{
				case UserSession.CONNECTION_STATUS_MEETING_ENDED:
					view.currentState = DisconnectPageViewBase.CONNECTION_STATUS_MEETING_ENDED;
					break;
				case UserSession.CONNECTION_STATUS_CONNECTION_DROPPED:
					view.currentState = DisconnectPageViewBase.CONNECTION_STATUS_CONNECTION_DROPPED;
					break;
				case UserSession.CONNECTION_STATUS_USER_KICKED_OUT:
					view.currentState = DisconnectPageViewBase.CONNECTION_STATUS_USER_KICKED_OUT;
					break;
				case UserSession.CONNECTION_STATUS_USER_LOGGED_OUT:
					view.currentState = DisconnectPageViewBase.CONNECTION_STATUS_USER_LOGGED_OUT;
					break;
			}	
		}
		
		private function applicationExit(event:Event):void
		{
			trace("DisconnectPageViewMediator.applicationExit - exitting the application!");
			NativeApplication.nativeApplication.exit();
		}
	}
}