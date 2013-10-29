package org.mconf.mobile.view.ui
{
	import mx.core.UIComponent;
	
	import org.mconf.mobile.command.NavigateToSignal;
	import org.mconf.mobile.model.IUserUISession;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class NavigationButtonMediator extends Mediator
	{
		[Inject]
		public var userSession: IUserUISession;
		
		[Inject]
		public var navigateToPageSignal: NavigateToSignal;
				
		[Inject]
		public var view: INavigationButton;
		
		
		override public function initialize():void
		{
			view.navigationSignal.add(navigate);
			
			userSession.pageChangedSignal.add(update);
			
			update(userSession.currentPage);
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			view.dispose();
			
			view.navigationSignal.remove(navigate);
			
			view = null;			
			
			userSession.pageChangedSignal.remove(update);
		}
		
		/**
		 * Navigate to the page specified on parameter
		 */
		private function navigate(): void
		{
			navigateToPageSignal.dispatch(view.navigateTo, view.action);
		}
		
		/**
		 * Update the view when there is a chenge in the model
		 */ 
		private function update(page:String, action:Boolean = false):void
		{
			if(view.navigateTo == page)
			{
				if(containState(view, "selected")) 
				{
					view.currentState = "selected";
				}
			}
			else
			{
				if(containState(view, "unselected"))
				{
					view.currentState = "unselected";
				}
			}
		}
		
		private function containState(view:INavigationButton, stateName:String):Boolean
		{
			var states:Array = view.states;
			for (var i:int = 0; i < states.length; i++)
			{
				if (states[i].name == stateName)
				{
					return true;
				}
			}
			return false;			
		}
	}
}