package org.bigbluebutton.view.navigation.pages.login
{
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class LoginPageViewMediator extends Mediator
	{
		[Inject]
		public var view: ILoginPageView;
		
		override public function initialize():void
		{
			Log.getLogger("org.bigbluebutton").info(String(this));
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			view.dispose();
			view = null;
		}
	}
}