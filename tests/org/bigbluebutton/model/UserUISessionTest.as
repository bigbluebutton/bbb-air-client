package org.bigbluebutton.model
{
	import flash.events.EventDispatcher;
	
	import flashx.textLayout.debug.assert;
	
	import mockolate.runner.MockolateRule;
	
	import org.bigbluebutton.view.navigation.pages.TransitionAnimationENUM;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	
	public class UserUISessionTest
	{		
		protected var instance:UserUISession;
		
		/* Event dispatcher for the helper event types, defined in the 'UserListTestHelperEvents' class. They are used
		* to check that signals are dispatched, and with the right arguments, by putting listener methods on the
		* signals that dispatch an event if all goes well. If the signal is not dispatched, the method will not be 
		* invoked, and the test will timeout waiting for the event. If they are called, but with the wrong arguments,
		* then the assertions within the listener method will fail. */
		public var dispatcher:EventDispatcher = new EventDispatcher();
		
		[Before]
		public function setUp():void
		{
			instance = new UserUISession();
			instance.pushPage("page 1", "details 1", TransitionAnimationENUM.APPEAR);
			instance.pushPage("page 2", "details 2", TransitionAnimationENUM.SLIDE_LEFT);
			instance.pushPage("page 3", "details 3", TransitionAnimationENUM.SLIDE_RIGHT);
		}
		
		/* UserUISession::currentPage getter tests */
		
		[Test]
		public function currentPage_returnsCurrentPageName():void
		{
			var currPage:String = instance.currentPage;
			assertThat(currPage, equalTo("page 3"));
		}
		
		[Test]
		public function currentPage_listPagesIsEmpty_returnsNull():void
		{
			instance.popPage();
			instance.popPage();
			instance.popPage();
			
			var currPage:String = instance.currentPage;
			assertThat(currPage, equalTo(null));
		}
		
		/* UserUISession::lastPage getter tests */
		
		[Test]
		public function lastPage_returnsLastPageName():void
		{
			var lastPage:String = instance.lastPage;
			assertThat(lastPage, equalTo("page 2"));
		}
		
		[Test]
		public function lastPage_listPagesHasOnlyOnePage_returnsNull():void
		{
			instance.popPage();
			instance.popPage();
			
			var lastPage:String = instance.lastPage;
			assertThat(lastPage, equalTo(null));
		}
		
		[Test]
		public function lastPage_listPagesIsEmpty_returnsNull():void
		{
			instance.popPage();
			instance.popPage();
			instance.popPage();
			
			var lastPage:String = instance.lastPage;
			assertThat(lastPage, equalTo(null));
		}
		
		/* UserUISession::pushPage tests */
		
		[Test]
		public function pushPage_currentPageIsThatPage():void
		{
			instance.pushPage("new page", "new page details", TransitionAnimationENUM.APPEAR);
			assertThat(instance.currentPage, equalTo("new page"));
			assertThat(instance.lastPage, equalTo("page 3"));
		}
		
		[Test (async)]
		public function pushPage_pageAdded_dispatchesPageChangedSignal():void
		{
			instance.pageChangedSignal.add(pushPageSignalChecker);
			Async.proceedOnEvent(this, dispatcher, UserUISessionTestHelperEvents.PUSH_PAGE_SIGNAL_CORRECT, 5000);
			instance.pushPage("new page", "new page details", TransitionAnimationENUM.SLIDE_LEFT);
		}
		
		private function pushPageSignalChecker(pageName:String, removeView:Boolean, animation:int):void
		{
			assertThat(pageName, equalTo("new page"));
			assertThat(removeView, equalTo(false));
			assertThat(animation, equalTo(TransitionAnimationENUM.SLIDE_LEFT));
			dispatcher.dispatchEvent(new UserUISessionTestHelperEvents(UserUISessionTestHelperEvents.PUSH_PAGE_SIGNAL_CORRECT));
		}
		
		[Test]
		public function pushPage_pageAddedIsCurrentPage_pageNotAddedAgain():void
		{
			instance.pushPage("double page", "double page details");
			instance.pushPage("double page", "double page details");
			assertThat(instance.lastPage, equalTo("page 3"));
		}
		
		/* UserUISession::popPage tests */
		
		[Test]
		public function popPage_removesPageFromPageList():void
		{
			instance.popPage();
			assertThat(instance.currentPage, equalTo("page 2"));
			instance.popPage();
			assertThat(instance.currentPage, equalTo("page 1"));
			instance.popPage();
			assertThat(instance.currentPage, equalTo(null));
		}
		
		[Test (async)]
		public function popPage_removesPage_dispatchesPageChangedSignal():void
		{
			instance.pageChangedSignal.add(popPageSignalChecker);
			Async.proceedOnEvent(this, dispatcher, UserUISessionTestHelperEvents.POP_PAGE_SIGNAL_CORRECT, 5000);
			instance.popPage(TransitionAnimationENUM.SLIDE_LEFT);
		}
		
		private function popPageSignalChecker(pageName:String, removeView:Boolean, animation:int):void
		{
			assertThat(pageName, equalTo("page 2"));
			assertThat(removeView, equalTo(true));
			assertThat(animation, equalTo(TransitionAnimationENUM.SLIDE_LEFT));
			dispatcher.dispatchEvent(new UserUISessionTestHelperEvents(UserUISessionTestHelperEvents.POP_PAGE_SIGNAL_CORRECT));
		}
		
		[Test]
		public function popPage_pageListIsEmpty_doesNothing():void
		{
			instance.popPage();
			instance.popPage();
			instance.popPage();
			assertThat(instance.currentPage, equalTo(null));
			
			instance.popPage();
			assertThat(instance.currentPage, equalTo(null));
		}
		
		/* UserUISession::currentPageDetails (getter) tests */
		
		[Test]
		public function currentPageDetails_returnsDetails():void
		{
			instance.pushPage("new page", "new page details");
			assertThat(instance.currentPageDetails, equalTo("new page details"));
		}
		
		[Test]
		public function currentPageDetails_pageListIsEmpty_returnsNull():void
		{
			instance.popPage();
			instance.popPage();
			instance.popPage();
			assertThat(instance.currentPageDetails, equalTo(null));
		}
		
		/* UserUISession::loading (setter) tests */
		
		[Test (async)]
		public function loading_dispatchedLoadingSignal():void
		{
			instance.loadingSignal.add(loadingSignalChecker);
			Async.proceedOnEvent(this, dispatcher, UserUISessionTestHelperEvents.LOADING_SIGNAL_CORRECT, 5000);
			instance.loading = true;
		}
		
		private function loadingSignalChecker(loading:Boolean):void
		{
			assertThat(loading, equalTo(true));
			dispatcher.dispatchEvent(new UserUISessionTestHelperEvents(UserUISessionTestHelperEvents.LOADING_SIGNAL_CORRECT));
		}
		
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		/*[Test]
		public function instantiated_isInstanceOfUserUISession():void
		{
			assertTrue("instance is UserSession", instance is UserUISession);
		}
		
		[Test]
		public function instantiated_implementsIUserUISession():void
		{
			assertTrue("instance implements IUserUISession interface", instance is IUserUISession);
		}*/
	}
}