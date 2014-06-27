package org.bigbluebutton.command
{
	import flash.events.Event;
	
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
		public var videoConnection:VideoConnection;
		
		[Mock]
		public var userSession:UserSession;
		
		private static var TIMEOUT:Number = 5000;
		
		protected var instance:CameraQualityCommand;
		
		[Before(async)]
		public function setUp():void
		{
			Async.proceedOnEvent(this, prepare(VideoConnection), Event.COMPLETE, TIMEOUT, timeoutHandler);
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
			// arrange	
			stub(instance.userSession).getter("videoConnection").returns(videoConnection);
			
			// act
			instance.execute();
			
			// assert
			assertThat(instance.userSession.videoConnection, received().method('selectCameraQuality'));
		}
		
		[Test]
		public function executed_callsSelectCameraQualityMethodWithCorrectArgs():void
		{
			// arrange
			instance.cameraQualitySelected = 2;
			instance.userSession = userSession;
			stub(instance.userSession).getter("videoConnection").returns(videoConnection);
			
			// act
			instance.execute();
			
			// assert
			assertThat(instance.userSession.videoConnection, received().method('selectCameraQuality').arg(2));
		}
		
		protected function timeoutHandler(passThroughData:Object):void
		{
			fail("Timeout occured during setUp() method");
		}
	}
}