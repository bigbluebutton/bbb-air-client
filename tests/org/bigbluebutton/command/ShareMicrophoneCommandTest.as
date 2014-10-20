package org.bigbluebutton.command
{
	import flash.net.NetConnection;
	
	import mockolate.*;
	import mockolate.runner.MockolateRule;
	
	import org.bigbluebutton.core.VoiceConnection;
	import org.bigbluebutton.core.VoiceStreamManager;
	import org.bigbluebutton.model.IConferenceParameters;
	import org.bigbluebutton.model.IUserSession;
	import org.flexunit.asserts.assertTrue;
	import org.hamcrest.assertThat;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class ShareMicrophoneCommandTest
	{	
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		[Mock]
		public var mockUserSession:IUserSession;
		
		[Mock]
		public var mockConferenceParameters:IConferenceParameters;
		
		[Mock]
		public var mockVoiceStreamManager:VoiceStreamManager;
		
		[Mock]
		public var mockVoiceConnection:VoiceConnection;
		
		[Mock]
		public var mockNetConnection:NetConnection;
		
//		[Mock]
		public var mockSuccessConnectedSignal:Signal = new Signal();
		
//		[Mock]
		public var mockUnuccessConnectedSignal:Signal = new Signal();
		
		protected var instance:ShareMicrophoneCommand;
		
		[Before]
		public function setUp():void
		{
			instance = new ShareMicrophoneCommand();
			instance.userSession = mockUserSession;
			instance.conferenceParameters = mockConferenceParameters;
			stub(mockUserSession).getter("voiceConnection").returns(mockVoiceConnection);
			stub(mockVoiceConnection).getter("connection").returns(mockNetConnection);
			stub(mockVoiceConnection).getter("successConnected").returns(mockSuccessConnectedSignal);
			stub(mockVoiceConnection).getter("unsuccessConnected").returns(mockUnuccessConnectedSignal);
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function execute_enabledIsFalse_closeInvokedOnVoiceStreamManager():void
		{
			instance.enabled = false;
			stub(mockUserSession).getter("voiceStreamManager").returns(mockVoiceStreamManager);
			expect(instance.userSession.voiceStreamManager.close()).once();
			instance.execute();
		}
		
		[Test]
		public function execute_voiceConnectionNotEstablished_connectInvokedOnVoiceConnection():void
		{
			instance.enabled = true;
			stub(mockNetConnection).getter("connected").returns(false);
			expect(instance.userSession.voiceConnection.connect(mockConferenceParameters)).once();
			instance.execute();
		}
		
		[Test]
		public function execute_voiceConnectionCallNotActive_CallInvokedOnVoiceConnection():void
		{
			instance.enabled = true;
			stub(mockNetConnection).getter("connected").returns(true);
			stub(mockVoiceConnection).getter("callActive").returns(false);
			expect(instance.userSession.voiceConnection.call()).once();
			instance.execute();
		}
		
		[Test]
		public function execute_voiceConnectionCallAlreadyActive_NoMethodInvokedOnVoiceConnection():void
		{
			instance.enabled = true;
			stub(mockNetConnection).getter("connected").returns(true);
			stub(mockVoiceConnection).getter("callActive").returns(true);
			expect(instance.userSession.voiceConnection.call()).never();
			instance.execute();
			assertThat(instance.userSession.voiceConnection, received().method("call").anyArgs().never());
		}
		
/*		DOES NOT WORK... The problem is because there is a locally constructed object in 'mediaSuccessConnected' method
		(the VoiceStreamManager instance) that has many dependencies needed to work... I will come back to this later and
		try to "Inject" the voice stream manager into the share mic command w/o breaking, so that I can try to mock it.. - Adam
		
		[Test]
		public function execute_onConnectionSuccess_VoiceStreamManagerInitialized():void
		{
			instance.enabled = true;
			stub(mockNetConnection).getter("connected").returns(false);
			stub(mockUserSession).getter("voiceStreamManager").returns(mockVoiceStreamManager);
			stub(mockVoiceConnection).method("connect").args(mockConferenceParameters).calls(mockSuccessConnectedSignal.dispatch, ["ABC", "XYZ", "PQR"]);
			expect(mockVoiceStreamManager.play(mockVoiceConnection.connection, "XYZ")).once();
			expect(mockVoiceStreamManager.publish(mockVoiceConnection.connection, "ABC", "PQR")).once();
			instance.execute();
		}
*/
		
		[Test]
		public function instantiated_isInstanceOfShareCameraCommand():void
		{
			assertTrue("instance is ShareMicrophoneCommand", instance is ShareMicrophoneCommand);
		}
		
		[Test]
		public function instantiated_implementsRobotlegsCommand():void
		{
			assertTrue("instance is robotlegs Command", instance is Command);
		}
	}
}