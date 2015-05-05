package org.bigbluebutton.view.ui {
	
	import mx.core.FlexGlobals;
	import mx.core.UIComponent;
	import org.bigbluebutton.command.NavigateToSignal;
	import org.bigbluebutton.model.IUserUISession;
	import org.bigbluebutton.view.navigation.pages.PagesENUM;
	import org.bigbluebutton.view.navigation.pages.TransitionAnimationENUM;
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class NavigationButtonMediator extends Mediator {
		
		[Inject]
		public var userSession:IUserUISession;
		
		[Inject]
		public var navigateToPageSignal:NavigateToSignal;
		
		[Inject]
		public var view:INavigationButton;
		
		override public function initialize():void {
			view.navigationSignal.add(navigate);
		}
		
		override public function destroy():void {
			super.destroy();
			view.dispose();
			view.navigationSignal.remove(navigate);
			view = null;
		}
		
		/**
		 * Navigate to the page specified on parameter
		 */
		private function navigate():void {
			navigateToPageSignal.dispatch(view.navigateTo[0], view.pageDetails, view.transitionAnimation);
		}
	}
}
