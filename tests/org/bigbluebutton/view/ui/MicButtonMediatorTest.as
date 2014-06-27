package org.bigbluebutton.view.ui
{
	import flash.events.Event;
	
	import mockolate.prepare;
	import mockolate.runner.MockolateRule;
	import mockolate.stub;
	
	import org.bigbluebutton.model.UserList;
	import org.bigbluebutton.model.UserSession;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class MicButtonMediatorTest
	{		
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		[Mock]
		public var view:MicButton;
		
		[Mock]
		public var userSession:UserSession;
		
		[Mock]
		public var userList:UserList;
		
		[Mock]
		public var userChangeSignal:ISignal;
		
		private static var TIMEOUT:Number = 5000;
		
		protected var instance:MicButtonMediator;
		
		[Before(async)]
		public function setUp():void
		{
			Async.proceedOnEvent(this, prepare(MicButton, UserSession, Signal), Event.COMPLETE, TIMEOUT, timeoutHandler)
			instance = new MicButtonMediator();
			
			instance.view = this.view;
			instance.userSession = this.userSession;
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		} 
		
		[Test]
		public function instantiated_isInstanceOfMicButtonMediator():void
		{
			assertTrue("instance is MicButtonMediator", instance is MicButtonMediator);
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
			stub(instance.userSession).getter("userList").returns(this.userList);
			stub(instance.userSession.userList).getter("userChangeSignal").returns(this.userChangeSignal);
			
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