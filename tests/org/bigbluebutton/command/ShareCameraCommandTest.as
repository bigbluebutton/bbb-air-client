package org.bigbluebutton.command
{
	import flash.events.Event;
	
	import mockolate.mock;
	import mockolate.nice;
	import mockolate.prepare;
	import mockolate.received;
	import mockolate.runner.MockolateRule;
	import mockolate.stub;
	
	import org.bigbluebutton.core.IUsersService;
	import org.bigbluebutton.core.VideoConnection;
	import org.bigbluebutton.model.IUserSession;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	
	import robotlegs.bender.bundles.mvcs.Command;

	public class ShareCameraCommandTest
	{
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		[Mock]
		public var mockUserSession:IUserSession;
		
		[Mock]
		public var mockUserService:IUsersService;
		
		protected var instance:ShareCameraCommand;
		
		[Before (async)]
		public function setUp():void
		{
			instance = new ShareCameraCommand();
			instance.userSession = mockUserSession;
			instance.usersService = mockUserService;
			Async.proceedOnEvent(this, prepare(VideoConnection), Event.COMPLETE);
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function execute_enabledIsFalse_removeStreamInvokedOnUserService():void
		{
			instance.enabled = false;
			var mockVideoConnection:VideoConnection = nice(VideoConnection);
			mock(mockUserSession).getter("videoConnection").returns(mockVideoConnection);
			instance.execute();
			assertThat(instance.usersService, received().method("removeStream"));
		}
		
		[Test]
		public function execute_enabledIsFalse_stopPublishingInvokedOnVideoConnection():void
		{
			instance.enabled = false;
			var mockVideoConnection:VideoConnection = nice(VideoConnection);
			stub(mockUserSession).getter("videoConnection").returns(mockVideoConnection);
			instance.execute();
			assertThat(instance.userSession.videoConnection, received().method("stopPublishing"));
		}
		
		[Test]
		public function execute_enabledIsTrue_cameraPositionIsSetForVideoConnection():void
		{
			instance.enabled = true;
			instance.position = "some camera position";
			var mockVideoConnection:VideoConnection = nice(VideoConnection);
			stub(mockUserSession).getter("videoConnection").returns(mockVideoConnection);
			mock(mockVideoConnection).setter("cameraPosition").arg("some camera position").atLeast(1);
			instance.execute();
		}
		
		/* Mockolate does not allow the mocking and stubbing of static methods. Camera objects are got via
		 * the 'Camera.getCamera()' method, which is static. Therefore, I am not sure how to properly have
		 * this return null/'my-fake-camera' for the following three tests... - Adam */
		[Test]
		public function execute_cameraIsNull_startPublishingIsNotInvoked():void
		{
			
		}
		
		[Test]
		public function execute_enabledIsTrue_addStreamInvokedOnUserService():void
		{
			
		}
			
		[Test]
		public function execute_enabledIsTrue_startPublishingInvokedOnVideoConnection():void
		{
			
		}
			
		[Test]
		public function instantiated_isInstanceOfShareCameraCommand():void
		{
			assertTrue("instance is ShareCameraCommand", instance is ShareCameraCommand);
		}
		
		[Test]
		public function instantiated_implementsRobotlegsCommand():void
		{
			assertTrue("instance is robotlegs Command", instance is Command);
		}
	}
}