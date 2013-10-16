package org.mconf.mobile.view.navigation.pages.app
{
	import flash.display.DisplayObject;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class TopViewMediator extends Mediator
	{
		[Inject]
		public var view: ITopView;
		
		override public function initialize():void
		{

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