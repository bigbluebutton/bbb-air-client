package org.bigbluebutton.view.ui.loading
{
	import flash.events.Event;
	
	import mockolate.prepare;
	import mockolate.runner.MockolateRule;
	import mockolate.stub;
	
	import org.bigbluebutton.model.UserUISession;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	import org.osflash.signals.Signal;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class LoadingScreenMediatorTest
	{		
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		[Mock]
		public var view:LoadingScreen;
		
		[Mock]
		public var userUISession:UserUISession;
		
		[Mock]
		public var loadingSignal:Signal;
		
		private static var TIMEOUT:Number = 5000;
		
		protected var instance:LoadingScreenMediator;
		
		[Before(async)]
		public function setUp():void
		{
			Async.proceedOnEvent(this, prepare(LoadingScreen, UserUISession, Signal), Event.COMPLETE, TIMEOUT, timeoutHandler)
			instance = new LoadingScreenMediator();
			
			instance.view = this.view;
			instance.userUISettings = this.userUISession;
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		} 
		
		[Test]
		public function instantiated_isInstanceOfLoadingScreenMediator():void
		{
			assertTrue("instance is LoadingScreenMediator", instance is LoadingScreenMediator);
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
			stub(instance.userUISettings).getter("loadingSignal").returns(this.loadingSignal);
			
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