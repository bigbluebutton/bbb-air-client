package org.mconf.mobile.view.navigation
{
	import org.mconf.mobile.model.IUserSession;
	import org.mconf.mobile.util.NoTransition;
	import org.mconf.mobile.view.navigation.pages.PagesENUM;
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Mediator;

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
			
			view.pushView(PagesENUM.getClassfromName(PagesENUM.LOGIN), null, null, null);
		}
		
		protected function changePage(pageName:String, pageRemoved:Boolean):void
		{			
			if(pageRemoved)
			{
				view.popView();
			}
			else if(pageName != null && pageName != "") 
			{
				view.pushView(PagesENUM.getClassfromName(pageName));
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