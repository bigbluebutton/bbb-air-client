package org.mconf.mobile.view.navigation.pages.login
{
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class LoginPageViewMediator extends Mediator
	{
		[Inject]
		public var view: ILoginPageView;
		
		override public function initialize():void
		{
			Log.getLogger("org.mconf.mobile").info(String(this));
		}
		
		protected function test():void
		{
			
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			view.dispose();
			view = null;
		}
	}
}