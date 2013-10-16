package org.mconf.mobile.view.navigation.pages.app
{
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class AppPageViewMediator extends Mediator
	{
		[Inject]
		public var view: IAppPageView;
		
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