package org.bigbluebutton.command
{
	import flash.events.Event;
	
	import mockolate.arg;
	import mockolate.expect;
	import mockolate.expectArg;
	import mockolate.mock;
	import mockolate.nice;
	import mockolate.prepare;
	import mockolate.received;
	import mockolate.record;
	import mockolate.runner.MockolateRule;
	import mockolate.strict;
	import mockolate.stub;
	
	import org.bigbluebutton.core.IBigBlueButtonConnection;
	import org.bigbluebutton.core.IChatMessageService;
	import org.bigbluebutton.core.IDeskshareConnection;
	import org.bigbluebutton.core.IPresentationService;
	import org.bigbluebutton.core.IUsersService;
	import org.bigbluebutton.core.IVideoConnection;
	import org.bigbluebutton.core.IVoiceConnection;
	import org.bigbluebutton.model.Config;
	import org.bigbluebutton.model.IConferenceParameters;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.IUserUISession;
	import org.bigbluebutton.model.UserList;
	import org.bigbluebutton.view.navigation.pages.PagesENUM;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.anything;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.instanceOf;
	import org.osflash.signals.Signal;
	
	import robotlegs.bender.bundles.mvcs.Command;

	public class ConnectCommandTest
	{		
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		[Mock]
		public var mockConnection:IBigBlueButtonConnection;
		
		[Mock]
		public var mockConferenceParameters:IConferenceParameters;
		
		[Mock]
		public var mockUserSession:IUserSession;
		
		[Mock]
		public var mockUsersService:IUsersService;
		
		[Mock]
		public var mockUserUISession:IUserUISession;
		
		[Mock]
		public var mockUserList:UserList;
		
		[Mock]
		public var mockChatService:IChatMessageService;
		
		[Mock]
		public var mockPresentationService:IPresentationService;
		
		[Mock]
		public var mockVideoConnection:IVideoConnection;
		
		[Mock]
		public var mockVoiceConnection:IVoiceConnection;
		
		[Mock]
		public var mockDeskshareConnection:IDeskshareConnection;
		
		[Mock]
		public var fakeUIUnsuccessConnectedSignal:Signal;
		
		[Mock]
		public var mockConfig:Config;
		
		/* Returned by the mockConfig 'getConfigFor', to imitate the real config XML */
		public var fakeXML:XML = <fakeModules>
									<video uri="VIDEO_MODULE_URI" />
									<voice uri="PHONE_MODULE_URI" />
									<deskshare uri="DESKSHARE_MODULE_URI" />
								</fakeModules>;
			
		/* The fake signals that need to be dispatched. There may be a better way to 'fake' signals, 
		 * but I don't know how to mock them with Mockolate (I need them to dispatch real signals). */
		public var mockSuccessConnected:Signal = new Signal();
		public var mockUnsuccessConnected:Signal = new Signal();
		
		public var mockSuccessJoiningMeetingSignal:Signal = new Signal();
		public var mockUnsuccessJoiningMeetingSignal:Signal = new Signal;
		
		public var mockVideoConnectionSuccessConnected:Signal = new Signal();
		public var mockVideoConnectionUnsuccessConnected:Signal = new Signal();
		
		public var mockUserListAllUsersAddedSignal:Signal = new Signal();
		
		protected var instance:ConnectCommand;
		
		[Before (async)]
		public function setUp():void
		{
			instance = new ConnectCommand();
			
			instance.connection = mockConnection;
			instance.userSession = mockUserSession;
			instance.userUISession = mockUserUISession;
			instance.conferenceParameters = mockConferenceParameters;
			instance.usersService = mockUsersService;
			instance.chatService = mockChatService;
			instance.presentationService = mockPresentationService;
			instance.videoConnection = mockVideoConnection;
			instance.voiceConnection = mockVoiceConnection;
			instance.deskshareConnection = mockDeskshareConnection;
			
			stub(mockUserSession).getter("successJoiningMeetingSignal").returns(mockSuccessJoiningMeetingSignal);
			stub(mockUserSession).getter("unsuccessJoiningMeetingSignal").returns(mockUnsuccessJoiningMeetingSignal);
			stub(mockUserSession).getter("config").returns(mockConfig);
			stub(mockUserSession).getter("userList").returns(mockUserList);

			stub(mockUserList).getter("allUsersAddedSignal").returns(mockUserListAllUsersAddedSignal);
			
			stub(mockConnection).getter("successConnected").returns(mockSuccessConnected);
			stub(mockConnection).getter("unsuccessConnected").returns(mockUnsuccessConnected);

			stub(mockVideoConnection).getter("successConnected").returns(mockVideoConnectionSuccessConnected);
			stub(mockVideoConnection).getter("unsuccessConnected").returns(mockVideoConnectionUnsuccessConnected);
			
			stub(mockConferenceParameters).getter("room").returns("ROOM");
			
			stub(mockConfig).method("getConfigFor").args("VideoConfModule").returns(new XML(fakeXML.video.toXMLString()));
			stub(mockConfig).method("getConfigFor").args("PhoneModule").returns(new XML(fakeXML.voice.toXMLString()));
			stub(mockConfig).method("getConfigFor").args("DeskShareModule").returns(new XML(fakeXML.deskshare.toXMLString()));
		}
		
		[Test]
		public function execute_connect_connectInvokedOnConnectionWithConference():void
		{
			expect(mockConnection.connect(mockConferenceParameters));
			instance.execute();
		}
		
		[Test]
		public function execute_successConnected_userSessionAndServiceInitialized():void
		{
			stub(mockConnection).method("connect").args(mockConferenceParameters).calls(mockSuccessConnected.dispatch);
			expect(mockUserSession.mainConnection = mockConnection);
			expect(mockUserSession.userId = mockConnection.userId);
			expect(mockUsersService.setupMessageSenderReceiver());
			expect(mockUsersService.sendJoinMeetingMessage());
			instance.execute();
		}
		
		[Test]
		public function execute_successConnected_connectedSignalsRemoved():void
		{
			stub(mockConnection).method("connect").args(mockConferenceParameters).calls(mockSuccessConnected.dispatch);
			expect(mockSuccessConnected.remove);
			expect(mockUnsuccessConnected.remove);
			instance.execute();
		}
		
		[Test]
		public function execute_successJoined_MessageSendersAndReceiversSetup():void
		{
			stub(mockConnection).method("connect").args(mockConferenceParameters).calls(mockSuccessConnected.dispatch);
			stub(mockUsersService).method("sendJoinMeetingMessage").calls(mockSuccessJoiningMeetingSignal.dispatch);
			expect(mockChatService.setupMessageSenderReceiver);
			expect(mockPresentationService.setupMessageSenderReceiver);
			instance.execute();
		}
		
		[Test]
		public function execute_successJoined_connectionURIsSet():void
		{
			stub(mockConnection).method("connect").args(mockConferenceParameters).calls(mockSuccessConnected.dispatch);
			stub(mockUsersService).method("sendJoinMeetingMessage").calls(mockSuccessJoiningMeetingSignal.dispatch);
			
			expect(mockVideoConnection.uri = arg("VIDEO_MODULE_URI" + "/" + "ROOM"));
			expect(mockVoiceConnection.uri = arg("PHONE_MODULE_URI"));
			expect(mockDeskshareConnection.applicationURI = arg("DESKSHARE_MODULE_URI"));
			expect(mockDeskshareConnection.room = arg("ROOM"));
			
			instance.execute();
		}
		
		[Test]
		public function execute_successJoined_connectInvokedOnVideoAndDeskshareConnection():void
		{
			stub(mockConnection).method("connect").args(mockConferenceParameters).calls(mockSuccessConnected.dispatch);
			stub(mockUsersService).method("sendJoinMeetingMessage").calls(mockSuccessJoiningMeetingSignal.dispatch);
			expect(mockVideoConnection.connect());
			expect(mockDeskshareConnection.connect());
			instance.execute();
		}
			
		[Test]
		public function execute_successJoined_connectionsAssignedToUserSession():void
		{
			stub(mockConnection).method("connect").args(mockConferenceParameters).calls(mockSuccessConnected.dispatch);
			stub(mockUsersService).method("sendJoinMeetingMessage").calls(mockSuccessJoiningMeetingSignal.dispatch);
			expect(mockUserSession.videoConnection = arg(mockVideoConnection));
			expect(mockUserSession.voiceConnection = arg(mockVoiceConnection));
			expect(mockUserSession.deskshareConnection = arg(mockDeskshareConnection));
			instance.execute();
		}
		
		[Test]
		public function execute_successJoined_queryServerForUserChatPresentationInfo():void
		{
			stub(mockConnection).method("connect").args(mockConferenceParameters).calls(mockSuccessConnected.dispatch);
			stub(mockUsersService).method("sendJoinMeetingMessage").calls(mockSuccessJoiningMeetingSignal.dispatch);
			expect(mockChatService.getPublicChatMessages);
			expect(mockPresentationService.getPresentationInfo);
			expect(mockUsersService.queryForParticipants);
			expect(mockUsersService.queryForRecordingStatus);
			instance.execute();
		}
		
		[Test]
		public function execute_allUsersSuccessfullyAdded_userUISessionStarted():void
		{
			stub(mockConnection).method("connect").args(mockConferenceParameters).calls(mockSuccessConnected.dispatch);
			stub(mockUsersService).method("sendJoinMeetingMessage").calls(mockSuccessJoiningMeetingSignal.dispatch);
			stub(mockUsersService).method("queryForParticipants").calls(mockUserListAllUsersAddedSignal.dispatch);
			expect(mockUserUISession.loading = arg(false));
			expect(mockUserUISession.pushPage(PagesENUM.PARTICIPANTS));
			instance.execute();
		}
		
		[Test]
		public function execute_unsuccessConnecting_userUISessionUnsuccessDispatched():void
		{
			stub(mockConnection).method("connect").args(mockConferenceParameters).calls(mockUnsuccessConnected.dispatch, ["REASON"]);
			expect(mockUserUISession.loading = arg(false));
			expect(mockUserUISession.unsuccessJoined).returns(fakeUIUnsuccessConnectedSignal);
			expect(fakeUIUnsuccessConnectedSignal.dispatch("connectionFailed"));
			instance.execute();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}	
		
	}
}