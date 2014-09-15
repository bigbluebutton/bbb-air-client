package org.bigbluebutton.command
{
	import flash.events.Event;
	
	import mockolate.nice;
	import mockolate.prepare;
	import mockolate.received;
	import mockolate.runner.MockolateRule;
	import mockolate.stub;
	
	import org.bigbluebutton.core.VideoConnection;
	import org.bigbluebutton.model.UserSession;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class CameraQualityCommandTest
	{		
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		[Mock]
		public var userSession:UserSession;
		
		protected var instance:CameraQualityCommand;
		
		[Before(async)]
		public function setUp():void
		{
			Async.proceedOnEvent(this, prepare(VideoConnection), Event.COMPLETE);
			instance = new CameraQualityCommand();
			instance.userSession = userSession;
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfCameraQualityCommand():void
		{
			assertTrue("instance is CameraQualityCommand", instance is CameraQualityCommand);
		}
		
		[Test]
		public function instantiated_implementsRobotlegsCommand():void
		{
			assertTrue("instance is robotlegs Command", instance is Command);
		}
		
		[Test]
		public function executed_callsSelectCameraQualityMethod():void
		{
			var videoConnection:VideoConnection = nice(VideoConnection);
			stub(userSession).getter("videoConnection").returns(videoConnection);
			instance.execute();
			assertThat(instance.userSession.videoConnection, received().method('selectCameraQuality'));
		}
		
		[Test]
		public function executed_callsSelectCameraQualityMethodWithCorrectArgs():void
		{
			var videoConnection:VideoConnection = nice(VideoConnection);
			instance.cameraQualitySelected = 2;
			instance.userSession = userSession;
			stub(userSession).getter("videoConnection").returns(videoConnection);
			instance.execute();
			assertThat(instance.userSession.videoConnection, received().method('selectCameraQuality').arg(2));
		}

	}
}