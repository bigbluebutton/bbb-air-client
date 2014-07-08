package org.bigbluebutton.view.navigation.pages.common
{
	import flash.events.Event;
	
	import mockolate.prepare;
	import mockolate.runner.MockolateRule;
	import mockolate.stub;
	
	import org.bigbluebutton.core.DeskshareConnection;
	import org.bigbluebutton.model.UserSession;
	import org.bigbluebutton.model.UserUISession;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	import org.osflash.signals.Signal;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class MenuButtonsViewMediatorTest
	{		
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		[Mock]
		public var view:MenuButtonsView;
		
		[Mock]
		public var userSession:UserSession;
		
		[Mock]
		public var isStreamingSignal:Signal; 
		
		[Mock]
		public var deskshareConnection:DeskshareConnection;
		
		[Mock]
		public var userUISession:UserUISession;
		
		[Mock]
		public var loadingSignal:Signal;
		
		private static var TIMEOUT:Number = 5000;
		
		protected var instance:MenuButtonsViewMediator;
		
		[Before(async)]
		public function setUp():void
		{
			Async.proceedOnEvent(this, prepare(UserSession, DeskshareConnection, UserUISession, Signal), Event.COMPLETE, TIMEOUT, timeoutHandler)
			instance = new MenuButtonsViewMediator();
			
			instance.userSession = this.userSession;
			instance.view = this.view;
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfMenuButtonsViewMediator():void
		{
			assertTrue("instance is MenuButtonsViewMediator", instance is MenuButtonsViewMediator);
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
			stub(instance.userSession).getter("deskshareConnection").returns(this.deskshareConnection);
			stub(instance.userSession.deskshareConnection).getter("isStreamingSignal").returns(this.isStreamingSignal);
			
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
