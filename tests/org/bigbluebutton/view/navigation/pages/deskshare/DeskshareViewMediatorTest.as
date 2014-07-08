package org.bigbluebutton.view.navigation.pages.deskshare
{
	import flash.events.Event;
	
	import mockolate.prepare;
	import mockolate.runner.MockolateRule;
	import mockolate.stub;
	
	import org.bigbluebutton.core.DeskshareConnection;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.UserSession;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	import org.osflash.signals.Signal;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class DeskshareViewMediatorTest
	{		
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		[Mock]
		public var view:DeskshareView;
		
		[Mock]
		public var userSession:UserSession;
		
		[Mock]
		public var deskshareConnection:DeskshareConnection;
		
		[Mock]
		public var isStreamingSignal:Signal;
		
		[Mock]
		public var mouseLocationChangedSignal:Signal
		
		private static var TIMEOUT:Number = 5000;
		
		protected var instance:DeskshareViewMediator;
		
		[Before(async)]
		public function setUp():void
		{
			Async.proceedOnEvent(this, prepare(DeskshareView, UserSession, Signal, DeskshareConnection), Event.COMPLETE, TIMEOUT, timeoutHandler)
			instance = new DeskshareViewMediator();
			
			instance.userSession = this.userSession;
			instance.view = this.view;
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfDeskshareViewMediator():void
		{
			assertTrue("instance is DeskshareViewMediator", instance is DeskshareViewMediator);
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
			stub(instance.userSession.deskshareConnection).getter("mouseLocationChangedSignal").returns(this.mouseLocationChangedSignal);
			
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