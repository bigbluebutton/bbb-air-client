package org.bigbluebutton.view.navigation.pages.profile
{
	import flash.display.DisplayObject;
	
	import org.bigbluebutton.model.IUserSession;
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class ProfileViewMediator extends Mediator
	{
		[Inject]
		public var view: IProfileView;
		
		[Inject]
		public var userSession: IUserSession;
		
		
		override public function initialize():void
		{
			Log.getLogger("org.bigbluebutton").info(String(this));
			
			view.userNameText.text = userSession.userlist.getUser(userSession.userId).name;
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			view.dispose();
			view = null;
		}
	}
}