package org.bigbluebutton.view.navigation.pages.profile
{
	import flash.display.DisplayObject;
	
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class ProfileViewMediator extends Mediator
	{
		[Inject]
		public var view: IProfileView;
		
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