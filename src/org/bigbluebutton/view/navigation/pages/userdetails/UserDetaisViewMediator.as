package org.bigbluebutton.view.navigation.pages.userdetails
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.IUserUISession;
	import org.bigbluebutton.model.User;
	import org.bigbluebutton.view.navigation.pages.PagesENUM;
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class UserDetaisViewMediator extends Mediator
	{
		[Inject]
		public var view: IUserDetaisView;
		
		[Inject]
		public var userSession: IUserSession;
		
		[Inject]
		public var userUISession: IUserUISession;
		
		protected var user:User;
		
		override public function initialize():void
		{
			Log.getLogger("org.bigbluebutton").info(String(this));
			
			user = userUISession.currentPageDetails as User;

			userSession.userlist.userChangeSignal.add(userChanged);
			userSession.userlist.userRemovedSignal.add(userRemoved);
			
			user.signal.add(userChanged);
			
			view.user = user;	
			
			view.showCameraButton.addEventListener(MouseEvent.CLICK, onShowCameraButton);
			view.showPrivateChat.addEventListener(MouseEvent.CLICK, onShowPrivateChatButton);
		}
		
		protected function onShowCameraButton(event:MouseEvent):void
		{
			userUISession.pushPage(PagesENUM.VIDEO_CHAT, user);
		}
		
		protected function onShowPrivateChatButton(event:MouseEvent):void
		{
			userUISession.pushPage(PagesENUM.CHAT, user);
		}
		
		private function userRemoved(userID:String):void
		{
			if(user.userID == userID)
			{
				userUISession.popPage();
			}
		}
		
		private function userChanged(user0:User, property:String = null):void
		{
			if(user.userID == user0.userID)
			{
				view.update();
			}
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			view.showCameraButton.removeEventListener(MouseEvent.CLICK, onShowCameraButton);
			view.showPrivateChat.removeEventListener(MouseEvent.CLICK, onShowPrivateChatButton);
			
			userSession.userlist.userChangeSignal.remove(userChanged);
			userSession.userlist.userRemovedSignal.remove(userRemoved);
			
			user.signal.remove(userChanged);
			
			view.dispose();
			view = null;
		}
	}
}