package org.bigbluebutton.command
{
	import org.flexunit.asserts.assertTrue;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import org.bigbluebutton.core.IUsersService;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.User;
	
	import mockolate.runner.MockolateRule;
	import mockolate.mock;
	import mockolate.nice;
	import mockolate.stub;
	import mockolate.expect;
	import mockolate.expecting;
	import mockolate.received;
	
	import org.hamcrest.assertThat;
	
	public class MicrophoneMuteCommandTest
	{		
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		[Mock]
		public var user:User;
		
		[Mock]
		public var userSession:IUserSession;
		
		[Mock]
		public var userService:IUsersService;
		
		protected var instance:MicrophoneMuteCommand;
		
		[Before]
		public function setUp():void
		{
			instance = new MicrophoneMuteCommand();
			instance.user = user;
			instance.userSession = userSession;
			instance.userService = userService;
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfMicrophoneMuteCommand():void
		{
			assertTrue("instance is MicrophoneMuteCommand", instance is MicrophoneMuteCommand);
		}
		
		[Test]
		public function instantiated_implementsRobotlegsCommand():void
		{
			assertTrue("instance is robotlegs Command", instance is Command);
		}
		
		[Test]
		public function execute_whenUserIsNull_userServiceMethodsNotInvoked():void
		{
			/* Since we are mocking user, then setting it to null here, should it be automatically mocked at all? 
			 * (with the "[Mock]" meta tag? Or instantiated and mocked manually for each test, with the
			 * "var user:user = nice(User);" syntax? I don't know the 'standard' way... - Adam */
			instance.user = null;
			mock(userService).method("mute").never();
			instance.execute();
		}

		[Test]
		public function execute_whenUserIsMuted_userServiceUnmuteMethodIsInvoked():void
		{
			stub(user).getter("muted").returns(true);
			mock(userService).method("unmute").args(user);
			instance.execute();
			assertThat(userService, received().method("unmute"));
		}
		
		[Test]
		public function execute_whenUserIsNotMuted_userServiceMuteMethodIsInvoked():void
		{
			stub(user).getter("muted").returns(false);
			mock(userService).method("mute").args(user);
			instance.execute();
			assertThat(userService, received().method("mute"));
		}
	}
}
