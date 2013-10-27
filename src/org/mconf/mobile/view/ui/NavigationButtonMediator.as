package org.mconf.mobile.view.ui
{
	import org.mconf.mobile.command.NavigateToSignal;
	import org.mconf.mobile.model.IUserSession;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class NavigationButtonMediator extends Mediator
	{
		[Inject]
		public var userSession: IUserSession;
		
		[Inject]
		public var navigateToPageSignal: NavigateToSignal;
				
		[Inject]
		public var view: INavigationButton;
		
		
		override public function initialize():void
		{
			view.navigationSignal.add(navigate);
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			view.dispose();
			
			view = null;
		}
		
		/**
		 * Navigate to the page specified on parameter
		 */
		private function navigate(): void
		{
			navigateToPageSignal.dispatch(view.navigateTo, view.action);
		}
	}
}