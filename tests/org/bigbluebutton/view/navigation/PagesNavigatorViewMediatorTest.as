package org.bigbluebutton.view.navigation
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
	
	public class PagesNavigatorViewMediatorTest
	{		
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		[Mock]
		public var view:PagesNavigatorView;
		
		[Mock]
		public var userUISession:UserUISession;
		
		[Mock]
		public var pageChangedSignal:Signal;
		
		private static var TIMEOUT:Number = 5000;
		
		protected var instance:PagesNavigatorViewMediator;
		
		[Before(async)]
		public function setUp():void
		{
			Async.proceedOnEvent(this, prepare(PagesNavigatorView, Signal, UserUISession), Event.COMPLETE, TIMEOUT, timeoutHandler)
			instance = new PagesNavigatorViewMediator();
			
			instance.view = this.view;
			instance.userUISession = this.userUISession;
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		} 
		
		[Test]
		public function instantiated_isInstanceOfPagesNavigatorViewMediator():void
		{
			assertTrue("instance is PagesNavigatorViewMediator", instance is PagesNavigatorViewMediator);
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
			stub(instance.userUISession).getter("pageChangedSignal").returns(this.pageChangedSignal);
			
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
