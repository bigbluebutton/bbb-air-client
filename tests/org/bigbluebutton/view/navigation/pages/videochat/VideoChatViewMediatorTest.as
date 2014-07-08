package org.bigbluebutton.view.navigation.pages.videochat
{
	import flash.events.Event;
	
	import mockolate.prepare;
	import mockolate.runner.MockolateRule;
	import mockolate.stub;
	
	import org.bigbluebutton.model.UserList;
	import org.bigbluebutton.model.UserSession;
	import org.bigbluebutton.model.UserUISession;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class VideoChatViewMediatorTest
	{		
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		[Mock]
		public var view:VideoChatView;
		
		[Mock]
		public var userList:UserList;
		
		[Mock]
		public var userSession:UserSession;
		
		[Mock]
		public var userUISession:UserUISession;
		
		[Mock]
		public var userChangeSignal:Signal;  
		
		[Mock]
		public var userAddedSignal:Signal;
		
		[Mock]
		public var userRemovedSignal:Signal;
		
		[Mock]
		public var pageTransitionStartSignal:ISignal;
		
		private static var TIMEOUT:Number = 5000;
		
		protected var instance:VideoChatViewMediator;
		
		[Before(async)]
		public function setUp():void
		{
			Async.proceedOnEvent(this, prepare(VideoChatView, UserSession, UserList, Signal, UserUISession), Event.COMPLETE, TIMEOUT, timeoutHandler)
			instance = new VideoChatViewMediator();
			
			instance.view = this.view;
			instance.userSession = this.userSession;
			instance.userUISession = this.userUISession;
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		} 
		
		[Test]
		public function instantiated_isInstanceOfVideoChatViewMediator():void
		{
			assertTrue("instance is VideoChatViewMediator", instance is VideoChatViewMediator);
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
			stub(instance.userSession.userList).getter("userAddedSignal").returns(this.userAddedSignal);
			stub(instance.userSession.userList).getter("userRemovedSignal").returns(this.userRemovedSignal);
			
			stub(instance.userUISession).getter("pageTransitionStartSignal").returns(this.pageTransitionStartSignal);
			
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
