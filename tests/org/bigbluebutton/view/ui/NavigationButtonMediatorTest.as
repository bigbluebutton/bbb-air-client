package org.bigbluebutton.view.ui
{
	import flash.events.Event;
	
	import mockolate.prepare;
	import mockolate.runner.MockolateRule;
	import mockolate.stub;
	
	import org.bigbluebutton.model.UserList;
	import org.bigbluebutton.model.UserUISession;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	import org.osflash.signals.Signal;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class NavigationButtonMediatorTest
	{		
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		[Mock]
		public var view:NavigationButton;
		
		[Mock]
		public var userSession:UserUISession;		
		
		[Mock]
		public var pageChangedSignal:Signal;
		
		[Mock]
		public var navigationSignal:Signal;
		
		private static var TIMEOUT:Number = 5000;
		
		protected var instance:NavigationButtonMediator;
		
		[Before(async)]
		public function setUp():void
		{
			Async.proceedOnEvent(this, prepare(NavigationButton, UserUISession, UserList, Signal), Event.COMPLETE, TIMEOUT, timeoutHandler)
			instance = new NavigationButtonMediator();
			
			instance.view = this.view;
			instance.userSession = this.userSession;
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		} 
		
		[Test]
		public function instantiated_isInstanceOfNavigationButtonMediator():void
		{
			assertTrue("instance is NavigationButtonMediator", instance is NavigationButtonMediator);
		}
		
		[Test]
		public function instantiated_isRobotlegsMediator():void
		{
			assertTrue("instance is Robotlegs Mediator", instance is Mediator);
		}
		
		[Test]
		public function destroyed_viewIsDestroyed():void
		{	
			// Arrange
			stub(instance.userSession).getter("pageChangedSignal").returns(this.pageChangedSignal);
			stub(instance.view).getter("navigationSignal").returns(this.navigationSignal);
			
			// Act
			instance.destroy();
			
			// Assert
			assertTrue("view is destroyed when mediator is destroyed", instance.view == null);
		}
		
		protected function timeoutHandler(passThroughData:Object):void
		{
			fail("Timeout occured during setUp() method");
		}
	}
}
