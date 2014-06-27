package org.bigbluebutton.view.navigation.pages.profile
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
	import org.osflash.signals.Signal;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import spark.components.Button;
	import spark.components.RadioButtonGroup;
	
	public class ProfileViewMediatorTest
	{		
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		[Mock]
		public var view:ProfileView;
		
		[Mock]
		public var userList:UserList;
		
		[Mock]
		public var userSession:UserSession;
		
		[Mock]
		public var userChangeSignal:Signal;
		
		[Mock]
		public var shareCameraButton:Button;
		
		[Mock]
		public var shareMicButton:Button;
		
		[Mock]
		public var cameraQualityRadioGroup:RadioButtonGroup;
		
		[Mock]
		public var raiseHandButton:Button;
		
		[Mock]
		public var logoutButton:Button;
		
		private static var TIMEOUT:Number = 5000;
		
		protected var instance:ProfileViewMediator;
		
		[Before(async)]
		public function setUp():void
		{
			Async.proceedOnEvent(this, prepare(ProfileView, UserSession, UserList, Signal, Button, RadioButtonGroup), Event.COMPLETE, TIMEOUT, timeoutHandler)
			instance = new ProfileViewMediator();
			
			instance.view = this.view;
			instance.userSession = this.userSession;
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		} 
		
		[Test]
		public function instantiated_isInstanceOfProfileViewMediator():void
		{
			assertTrue("instance is ProfileViewMediator", instance is ProfileViewMediator);
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
			stub(instance.view).getter("shareCameraButton").returns(this.shareCameraButton);
			stub(instance.view).getter("shareMicButton").returns(this.shareMicButton);
			stub(instance.view).getter("raiseHandButton").returns(this.raiseHandButton);
			stub(instance.view).getter("cameraQualityRadioGroup").returns(this.cameraQualityRadioGroup);
			stub(instance.view).getter("logoutButton").returns(this.logoutButton);
			
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