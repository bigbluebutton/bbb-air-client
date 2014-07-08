package org.bigbluebutton.view.navigation.pages.disconnect
{
	import flash.events.Event;
	
	import mockolate.prepare;
	import mockolate.runner.MockolateRule;
	
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class DisconnectPageViewMediatorTest
	{		
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		[Mock]
		public var view:DisconnectPageView;
		
		private static var TIMEOUT:Number = 5000;
		
		protected var instance:DisconnectPageViewMediator;
		
		[Before(async)]
		public function setUp():void
		{
			Async.proceedOnEvent(this, prepare(DisconnectPageView), Event.COMPLETE, TIMEOUT, timeoutHandler)
			instance = new DisconnectPageViewMediator();
			
			instance.view = this.view;
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfDisconnectPageViewMediator():void
		{
			assertTrue("instance is DisconnectPageViewMediator", instance is DisconnectPageViewMediator);
		}
		
		[Test]
		public function instantiated_isRobotlegsMediator():void
		{
			assertTrue("instance is Robotlegs Mediator", instance is Mediator);
		}
		
		[Test]
		public function destroyed_viewIsDestroyed():void
		{		
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
