package org.bigbluebutton.view.navigation.pages.userdetails
{
	import flash.display.DisplayObject;
	
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.IUserUISession;
	import org.bigbluebutton.model.User;
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
			
			userSession.userlist.userChangeSignal.remove(userChanged);
			userSession.userlist.userRemovedSignal.remove(userRemoved);
			
			user.signal.remove(userChanged);
			
			view.dispose();
			view = null;
		}
	}
}