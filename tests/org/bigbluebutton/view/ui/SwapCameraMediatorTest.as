package org.bigbluebutton.view.ui
{
	import flash.events.Event;
	
	import mockolate.prepare;
	import mockolate.runner.MockolateRule;
	
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class SwapCameraMediatorTest
	{		
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		[Mock]
		public var view:SwapCameraButton;
		
		private static var TIMEOUT:Number = 5000;
		
		protected var instance:SwapCameraMediator;
		
		[Before(async)]
		public function setUp():void
		{
			Async.proceedOnEvent(this, prepare(SwapCameraButton), Event.COMPLETE, TIMEOUT, timeoutHandler)
			instance = new SwapCameraMediator();
			
			instance.view = this.view;
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		} 
		
		[Test]
		public function instantiated_isInstanceOfSwapCameraMediator():void
		{
			assertTrue("instance is SwapCameraMediator", instance is SwapCameraMediator);
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