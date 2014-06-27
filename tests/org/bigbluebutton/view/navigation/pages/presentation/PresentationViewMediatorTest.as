package org.bigbluebutton.view.navigation.pages.presentation
{
	import flash.events.Event;
	
	import mockolate.prepare;
	import mockolate.runner.MockolateRule;
	import mockolate.stub;
	
	import org.bigbluebutton.model.UserSession;
	import org.bigbluebutton.model.presentation.PresentationList;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	import org.osflash.signals.Signal;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class PresentationViewMediatorTest
	{		
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		[Mock]
		public var view:PresentationView;
		
		[Mock]
		public var presentationList:PresentationList;
		
		[Mock]
		public var userSession:UserSession;
		
		[Mock]
		public var presentationChangeSignal:Signal;
		
		private static var TIMEOUT:Number = 5000;
		
		protected var instance:PresentationViewMediator;
		
		[Before(async)]
		public function setUp():void
		{
			Async.proceedOnEvent(this, prepare(PresentationView, UserSession, PresentationList, Signal), Event.COMPLETE, TIMEOUT, timeoutHandler)
			instance = new PresentationViewMediator();
			
			instance.view = this.view;
			instance.userSession = this.userSession;
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		} 
		
		[Test]
		public function instantiated_isInstanceOfPresentationViewMediator():void
		{
			assertTrue("instance is PresentationViewMediator", instance is PresentationViewMediator);
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
			stub(instance.userSession).getter("presentationList").returns(this.presentationList);
			stub(instance.userSession.presentationList).getter("presentationChangeSignal").returns(this.presentationChangeSignal);
			
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