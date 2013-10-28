package org.mconf.mobile.view.navigation
{
	import org.mconf.mobile.model.IUserSession;
	import org.mconf.mobile.util.NoTransition;
	import org.mconf.mobile.view.navigation.pages.PagesENUM;
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import spark.components.ViewNavigator;
	import spark.transitions.SlideViewTransition;
	import spark.transitions.ViewTransitionBase;
	import spark.transitions.ViewTransitionDirection;

	public class PagesNavigatorViewMediator extends Mediator
	{
		[Inject]
		public var view: IPagesNavigatorView;
		
		[Inject]
		public var userSession: IUserSession
		
		override public function initialize():void
		{
			Log.getLogger("org.mconf.mobile").info(String(this));
			
			userSession.pageChangedSignal.add(changePage);
			
			var transition:SlideViewTransition = new SlideViewTransition();
			transition.duration = 300;
			transition.direction = ViewTransitionDirection.DOWN;
			view.pushView(PagesENUM.getClassfromName(PagesENUM.LOGIN), null, null, transition);
		}
		
		protected function changePage(pageName:String, pageRemoved:Boolean = false, transition:ViewTransitionBase = null):void
		{			
			if(pageRemoved)
			{
				if(transition != null) {
					var slideRight:SlideViewTransition = new SlideViewTransition();
					slideRight.duration = 300;
					slideRight.direction = ViewTransitionDirection.RIGHT;
					transition = slideRight;
				}
				view.popView();
			}
			else if(pageName != null && pageName != "") 
			{
				if(transition != null) {
					var slideLeft:SlideViewTransition = new SlideViewTransition();
					slideLeft.duration = 300;
					slideLeft.direction = ViewTransitionDirection.LEFT;
					transition = slideLeft;
				}
				view.pushView(PagesENUM.getClassfromName(pageName), null, null, transition);
			}
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			view.dispose();
			view = null;
		}
	}
}