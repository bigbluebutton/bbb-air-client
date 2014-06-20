package org.bigbluebutton.view.navigation.pages.userdetails
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import mx.core.FlexGlobals;
	import mx.resources.ResourceManager;
	import mx.states.Transition;
	
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.IUserUISession;
	import org.bigbluebutton.model.User;
	import org.bigbluebutton.view.navigation.pages.PagesENUM;
	import org.bigbluebutton.view.navigation.pages.TransitionAnimationENUM;
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
		
		protected var _user:User;
		
		override public function initialize():void
		{
			Log.getLogger("org.bigbluebutton").info(String(this));
			
			_user = userUISession.currentPageDetails as User;

			userSession.userList.userChangeSignal.add(userChanged);
			userSession.userList.userRemovedSignal.add(userRemoved);
			
			view.user = _user;	
			
			view.showCameraButton.addEventListener(MouseEvent.CLICK, onShowCameraButton);
			view.showPrivateChat.addEventListener(MouseEvent.CLICK, onShowPrivateChatButton);
			FlexGlobals.topLevelApplication.pageTitle0.text = ResourceManager.getInstance().getString('resources', 'userDetail.title');
		}
		
		protected function onShowCameraButton(event:MouseEvent):void
		{
			userUISession.pushPage(PagesENUM.VIDEO_CHAT, _user, TransitionAnimationENUM.APPEAR);
		}
		
		protected function onShowPrivateChatButton(event:MouseEvent):void
		{
			userUISession.pushPage(PagesENUM.CHAT, _user, TransitionAnimationENUM.APPEAR);
		}
		
		private function userRemoved(userID:String):void
		{
			if(_user.userID == userID)
			{
				userUISession.popPage();
			}
		}
		
		private function userChanged(user:User, type:int):void
		{
			if(_user.userID == user.userID)
			{
				view.update();
			}
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			view.showCameraButton.removeEventListener(MouseEvent.CLICK, onShowCameraButton);
			view.showPrivateChat.removeEventListener(MouseEvent.CLICK, onShowPrivateChatButton);
			
			userSession.userList.userChangeSignal.remove(userChanged);
			userSession.userList.userRemovedSignal.remove(userRemoved);
			
			view.dispose();
			view = null;
		}
	}
}