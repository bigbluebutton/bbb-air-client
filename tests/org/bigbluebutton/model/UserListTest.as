package org.bigbluebutton.model
{
	import flash.events.EventDispatcher;
	
	import mockolate.runner.MockolateRule;
	
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	
	public class UserListTest
	{		
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		public var instance:UserList;
		
		/* Event dispatcher for the helper event types, defined in the 'UserListTestHelperEvents' class. They are used
		 * to check that signals are dispatched, and with the right arguments, by putting listener methods on the
		 * signals that dispatch an event if all goes well. If the signal is not dispatched, the method will not be 
		 * invoked, and the test will timeout waiting for the event. If they are called, but with the wrong arguments,
		 * then the assertions within the listener method will fail. */
		public var dispatcher:EventDispatcher = new EventDispatcher();
		
		[Before]
		public function setUp():void
		{
			instance = new UserList();
		}
		
		/* UserList::addUser tests */
		
		[Test]
		public function addUser_addingNewUser_userIsAddedToList():void
		{
			var newUser:User = createNewUser("123", "ABC");
			instance.addUser(newUser);
			assertThat(instance.hasUser("123"));
		}
				
		[Test]
		public function addUser_userAlreadyInUserList_userNotAddedAgain():void
		{
			var newUser:User = createNewUser("123", "ABC");
			instance.addUser(newUser);
			instance.addUser(newUser);
			instance.addUser(newUser);
			instance.addUser(newUser);
			assertThat(instance.users.length, equalTo(1));
		}
		
		[Test]
		public function addUser_addingMultipleUsers_allUsersAreAddedToList():void
		{
			var user1:User = createNewUser("111", "AAA");
			var user2:User = createNewUser("222", "BBB");
			var user3:User = createNewUser("333", "CCC");
			var user4:User = createNewUser("444", "DDD");
			
			instance.addUser(user1);
			instance.addUser(user2);
			instance.addUser(user3);
			instance.addUser(user4);
			
			assertThat(instance.hasUser("111"));
			assertThat(instance.hasUser("222"));
			assertThat(instance.hasUser("333"));
			assertThat(instance.hasUser("444"));
		}
		
		[Test]
		public function addUser_newuserIsMe_newuserIsAssignedToMe():void
		{
			var newUser:User = createNewUser("123", "MEEE");
			instance.me.userID = "123";
			instance.addUser(newUser);
			
			assertThat(instance.me, equalTo(newUser));
			assertThat(newUser.me, equalTo(true));
		}
		
		[Test (async)]
		public function addUser_addingUserWithStream_dispatchesHasStreamSignal():void
		{
			var newUser:User = createNewUser("123", "ABC");
			newUser.hasStream = true;
			instance.userChangeSignal.add(hasStreamSignalChecker);
			Async.proceedOnEvent(this, dispatcher, UserListTestHelperEvents.HAS_STREAM, 5000);
			instance.addUser(newUser);
		}
		
		private function hasStreamSignalChecker(user:User, change:int):void
		{
			assertThat(user, equalTo(instance.getUserByUserId("123")));
			assertThat(change, equalTo(UserList.HAS_STREAM));
			dispatcher.dispatchEvent(new UserListTestHelperEvents(UserListTestHelperEvents.HAS_STREAM));
		}
		
		[Test (async)]
		public function addUser_addingUserWithPresenterStatus_dispatchesPresenterSignal():void
		{
			var newUser:User = createNewUser("123", "ABC");
			newUser.presenter = true;
			instance.userChangeSignal.add(presenterSignalChecker);
			Async.proceedOnEvent(this, dispatcher, UserListTestHelperEvents.PRESENTER, 5000);
			instance.addUser(newUser);
		}
		
		private function presenterSignalChecker(user:User, change:int):void
		{
			assertThat(user, equalTo(instance.getUserByUserId("123")));
			assertThat(change, equalTo(UserList.PRESENTER));
			dispatcher.dispatchEvent(new UserListTestHelperEvents(UserListTestHelperEvents.PRESENTER));
		}
		
		[Test (async)]
		public function addUser_addingUserWithHandRaised_dispatchesRaiseHandSignal():void
		{
			var newUser:User = createNewUser("123", "ABC");
			newUser.raiseHand = true;
			instance.userChangeSignal.add(handRaisedSignalChecker);
			Async.proceedOnEvent(this, dispatcher, UserListTestHelperEvents.RAISE_HAND, 5000);
			instance.addUser(newUser);
		}
		
		private function handRaisedSignalChecker(user:User, change:int):void
		{
			assertThat(user, equalTo(instance.getUserByUserId("123")));
			assertThat(change, equalTo(UserList.RAISE_HAND));
			dispatcher.dispatchEvent(new UserListTestHelperEvents(UserListTestHelperEvents.RAISE_HAND));
		}
		
		[Test (async)]
		public function addUser_addingUserWithListenOnly_dispatchesListenOnlySignal():void
		{
			var newUser:User = createNewUser("123", "ABC");
			newUser.listenOnly = true;
			instance.userChangeSignal.add(listenOnlySignalChecker);
			Async.proceedOnEvent(this, dispatcher, UserListTestHelperEvents.LISTEN_ONLY, 5000);
			instance.addUser(newUser);
		}
		
		public function listenOnlySignalChecker(user:User, change:int):void
		{
			assertThat(user, equalTo(instance.getUserByUserId("123")));
			assertThat(change, equalTo(UserList.LISTEN_ONLY));
			dispatcher.dispatchEvent(new UserListTestHelperEvents(UserListTestHelperEvents.LISTEN_ONLY));
		}
		
		[Test (async)]
		public function addUser_addingUser_dispatchesUserAddedSignal():void
		{
			var newUser:User = createNewUser("123", "ABC");
			instance.userAddedSignal.add(userAddedSignalChecker);
			Async.proceedOnEvent(this, dispatcher, UserListTestHelperEvents.USER_ADDED, 5000);
			instance.addUser(newUser);
		}
		
		private function userAddedSignalChecker(newUser:User):void
		{
			assertThat(newUser, equalTo(instance.getUser("123")));
			dispatcher.dispatchEvent(new UserListTestHelperEvents(UserListTestHelperEvents.USER_ADDED));
		}
		
		/* UserList::hasUser tests */
		
		[Test]
		public function hasUser_usersInUserList_hasUserReturnsTrue():void
		{
			var newUser1:User = createNewUser("111", "AAA");
			var newUser2:User = createNewUser("222", "BBB");
			var newUser3:User = createNewUser("333", "CCC");
			
			instance.addUser(newUser1);
			instance.addUser(newUser2);
			instance.addUser(newUser3);
			
			assertThat(instance.hasUser("111"), equalTo(true));
			assertThat(instance.hasUser("222"), equalTo(true));
			assertThat(instance.hasUser("333"), equalTo(true));
		}
		
		[Test]
		public function hasUser_userRemoved_hasUserReturnsFalse():void
		{
			var newUser:User = createNewUser("123", "ABC");
			instance.addUser(newUser);
			instance.removeUser("123");
			assertThat(instance.hasUser("123"), equalTo(false));
		}
		
		/* UserList::getUser tests */
		
		[Test]
		public function getUser_userInUserList_referenceToThatUserIsReturned():void
		{
			var newUser:User = createNewUser("123", "ABC");
			instance.addUser(newUser);
			assertThat(instance.getUser("123"), equalTo(newUser));
		}
		
		[Test]
		public function getUser_userRemoved_returnsNull():void
		{
			var newUser:User = createNewUser("123", "ABC");
			instance.addUser(newUser);
			instance.removeUser("123");
			assertThat(instance.getUser("123"), equalTo(null));
		}
		
		/* UserList::getUserByVoiceUserId tests */
		
		[Test]
		public function getUserByVoiceUserId_returnsCorrectUser():void
		{
			var newUser:User = createNewUser("123", "ABC");
			newUser.voiceUserId = "987";
			instance.addUser(newUser);
			assertThat(instance.getUserByVoiceUserId("987"), equalTo(newUser));
		}
		
		[Test]
		public function getUserByVoiceUserId_userRemoved_returnsNull():void
		{
			var newUser:User = createNewUser("123", "ABC");
			newUser.voiceUserId = "987";
			instance.addUser(newUser);
			instance.removeUser("123");
			assertThat(instance.getUserByVoiceUserId("987"), equalTo(null));
		}
		
		/* UserList::removeUser tests */
		
		[Test]
		public function removeUser_userInUserList_removesUser():void
		{
			var newUser:User = createNewUser("123", "ABC");
			instance.addUser(newUser);
			instance.removeUser("123");
			assertThat(instance.users.length, equalTo(0));
			assertThat(instance.getUser("123"), equalTo(null));
		}
		
		[Test (async)]
		public function removeUser_userInUserList_dispatchesUserRemovedSignal():void
		{
			var newUser:User = createNewUser("123", "ABC");
			instance.addUser(newUser);
			instance.userRemovedSignal.add(userRemovedSignalChecker);
			Async.proceedOnEvent(this, dispatcher, UserListTestHelperEvents.USER_REMOVED, 5000);
			instance.removeUser("123");
		}
		
		private function userRemovedSignalChecker(userID:String):void
		{
			assertThat(userID, equalTo("123"));
			dispatcher.dispatchEvent(new UserListTestHelperEvents(UserListTestHelperEvents.USER_REMOVED));
		}
		
		[Test]
		public function removeUser_userRemovedMultipleTimes_doesNothing():void
		{
			var newUser:User = createNewUser("123", "ABC");
			instance.addUser(newUser);
			instance.removeUser("123");
			instance.removeUser("123");
			instance.removeUser("123");
			assertThat(instance.users.length, equalTo(0));
			assertThat(instance.getUser("123"), equalTo(null));
		}
		
		/* UserList::getPresenter tests */
		
		[Test]
		public function getPresenter_presenterExists_returnsReferenceToPresenter():void
		{
			var newUser1:User = createNewUser("111", "AAA");
			var newUser2:User = createNewUser("222", "BBB");
			var newUser3:User = createNewUser("333", "CCC");
			
			newUser1.presenter = true;
			newUser2.presenter = false;
			newUser3.presenter = false;
			
			instance.addUser(newUser1);
			instance.addUser(newUser2);
			instance.addUser(newUser3);
			
			assertThat(instance.getPresenter(), equalTo(newUser1));
		}
		
		[Test]
		public function getPresenter_noPresenter_returnsNull():void
		{
			var newUser1:User = createNewUser("111", "AAA");
			var newUser2:User = createNewUser("222", "BBB");
			var newUser3:User = createNewUser("333", "CCC");
			
			newUser1.presenter = false;
			newUser2.presenter = false;
			newUser3.presenter = false;
			
			instance.addUser(newUser1);
			instance.addUser(newUser2);
			instance.addUser(newUser3);
			
			assertThat(instance.getPresenter(), equalTo(null));
		}
		
		/* UserList::removePresenter tests */
		
		[Test]
		public function removePresenter_presenterExists_presenterStatusSetToFalse():void
		{
			var newUser:User = createNewUser("123", "ABC");
			newUser.presenter = true;
			instance.addUser(newUser);
			instance.removePresenter();
			assertThat(newUser.presenter, equalTo(false));
			assertThat(instance.getPresenter(), equalTo(null));
		}
		
		[Test]
		public function removePresenter_presenterIsMe_myPresenterStatusSetToFalse():void
		{
			var newUser:User = createNewUser("123", "ABC");
			instance.me.userID = "123";
			newUser.presenter = true;
			instance.addUser(newUser);
			instance.removePresenter();
			assertThat(instance.me.presenter, equalTo(false));
		}
		
		[Test (async)]
		public function removePresenter_presenterExists_dispatchesPresenterSignal():void
		{
			var newUser:User = createNewUser("123", "ABC");
			newUser.presenter = true;
			instance.addUser(newUser);
			instance.userChangeSignal.add(removePresenterSignalChecker);
			Async.proceedOnEvent(this, dispatcher, UserListTestHelperEvents.REMOVED_PRESENTER, 5000);
			instance.removePresenter();
		}
		
		private function removePresenterSignalChecker(user:User, change:int):void
		{
			assertThat(user, equalTo(instance.getUserByUserId("123")));
			assertThat(change, equalTo(UserList.PRESENTER));
			dispatcher.dispatchEvent(new UserListTestHelperEvents(UserListTestHelperEvents.REMOVED_PRESENTER));
		}
		
		[Test]
		public function removePresenter_removePresenterInvokedManyTimes_doesntBreak():void
		{
			var newUser:User = createNewUser("123", "ABC");
			newUser.presenter = true;
			instance.addUser(newUser);
			instance.removePresenter();
			instance.removePresenter();
			instance.removePresenter();
			assertThat(instance.me.presenter, equalTo(false));
		}
		
		[Test]
		public function removePresenter_noPresenter_doesntBreak():void
		{
			var newUser:User = createNewUser("123", "ABC");
			newUser.presenter = false;
			instance.addUser(newUser);
			instance.removePresenter();
		}
		
		/* UserList::assignPresenter tests */
		
		[Test]
		public function assignPresenter_assignsPresenter():void
		{
			var newUser:User = createNewUser("123", "ABC");
			instance.addUser(newUser);
			instance.assignPresenter("123");
			assertThat(newUser.presenter, equalTo(true));
		}
		
		[Test (async)]
		public function assignPresenter_dispatchesPresenterSignal():void
		{
			var newUser:User = createNewUser("123", "ABC");
			instance.addUser(newUser);
			instance.userChangeSignal.add(assignPresenterSignalChecker);
			Async.proceedOnEvent(this, dispatcher, UserListTestHelperEvents.ASSIGN_PRESENTER, 5000);
			instance.assignPresenter("123");
		}
		
		private function assignPresenterSignalChecker(user:User, change:int):void
		{
			assertThat(user, equalTo(instance.getUser("123")));
			assertThat(change, equalTo(UserList.PRESENTER));
			dispatcher.dispatchEvent(new UserListTestHelperEvents(UserListTestHelperEvents.ASSIGN_PRESENTER));
		}
		
		[Test]
		public function assignPresenter_oldPresenterIsCleared():void
		{
			var oldPresenter:User = createNewUser("111", "AAA");
			var newPresenter:User = createNewUser("222", "BBB");
			oldPresenter.presenter = true;
			newPresenter.presenter = false;
			
			instance.addUser(oldPresenter);
			instance.addUser(newPresenter);
			instance.assignPresenter("222");
			
			assertThat(oldPresenter.presenter, equalTo(false));
		}
		
		[Test]
		public function assignPresenter_newPresenterIsMe_setsMyPresenterStateToTrue():void
		{
			var newUser:User = createNewUser("123", "ABC");
			newUser.me = true;
			instance.addUser(newUser);
			instance.assignPresenter("123");
			assertThat(instance.me.presenter, equalTo(true));
		}
		
		[Test]
		public function assignPresenter_oldPresenterIsMe_setsMyPresenterStateToFalse():void
		{
			var oldPresenter:User = createNewUser("111", "AAA");
			var newPresenter:User = createNewUser("222", "BBB");
			oldPresenter.presenter = true;
			oldPresenter.me = true;
			newPresenter.presenter = false;
			
			instance.addUser(oldPresenter);
			instance.addUser(newPresenter);
			instance.assignPresenter("222");
			
			assertThat(instance.me.presenter, equalTo(false));
		}
		
		[Test]
		public function assignPresenter_invalidUserID_doesntBreak():void
		{
			var newUser:User = createNewUser("123", "ABC");
			instance.addUser(newUser);
			instance.removeUser("123");
			instance.assignPresenter("123");
			instance.assignPresenter("invalid_id");
		}
		
		/* UserList::userStreamChange tests */
		
		[Test]
		public function userStreamChange_setsHasStreamAndStreamNameProperties():void
		{
			var newUser1:User = createNewUser("111", "AAA");
			newUser1.hasStream = false;
			newUser1.streamName = "";
			
			var newUser2:User = createNewUser("222", "BBB");
			newUser2.hasStream = true;
			newUser1.streamName = "some_stream_name";
			
			instance.addUser(newUser1);
			instance.addUser(newUser2);
			instance.userStreamChange("111", true, "some_other_stream_name");
			instance.userStreamChange("222", false, "");
			
			assertThat(newUser1.hasStream, equalTo(true));
			assertThat(newUser1.streamName, equalTo("some_other_stream_name"));
			assertThat(newUser2.hasStream, equalTo(false));
			assertThat(newUser2.streamName, equalTo(""));
		}
		
		[Test (async)]
		public function userStreamChange_dispatchesHasStreamSignal():void
		{
			var newUser:User = createNewUser("123", "ABC");
			instance.addUser(newUser);
			instance.userChangeSignal.add(streamChangeChecker);
			Async.proceedOnEvent(this, dispatcher, UserListTestHelperEvents.STREAM_CHANGE);
			instance.userStreamChange("123", true, "some_stream_name");
		}
		
		private function streamChangeChecker(user:User, change:int):void
		{
			assertThat(user, equalTo(instance.getUser("123")));
			assertThat(change, equalTo(UserList.HAS_STREAM));
			dispatcher.dispatchEvent(new UserListTestHelperEvents(UserListTestHelperEvents.STREAM_CHANGE));
		}
		
		[Test]
		public function userStreamChange_invalidUserID_doesntBreak():void
		{
			var newUser:User = createNewUser("123", "ABC");
			instance.addUser(newUser);
			instance.removeUser("123");
			instance.userStreamChange("123", true, "some_stream_name");
			instance.userStreamChange("invalid_id", true, "some_stream_name");
		}
		
		/* UserList::raiseHandChange tests */
		
		[Test]
		public function raiseHandChange_setsRaiseHandProperty():void
		{
			var newUser1:User = createNewUser("111", "AAA");
			newUser1.raiseHand = true;
			
			var newUser2:User = createNewUser("222", "BBB");
			newUser2.raiseHand = false;
			
			instance.addUser(newUser1);
			instance.addUser(newUser2);
			instance.raiseHandChange("111", false);
			instance.raiseHandChange("222", true);
			
			assertThat(newUser1.raiseHand, equalTo(false));
			assertThat(newUser2.raiseHand, equalTo(true));
		}
		
		[Test (async)]
		public function raiseHandChange_dispatchesRaiseHandSignal():void
		{
			var newUser:User = createNewUser("123", "ABC");
			instance.addUser(newUser);
			instance.userChangeSignal.add(raiseHandSignalChecker);
			Async.proceedOnEvent(this, dispatcher, UserListTestHelperEvents.RAISE_HAND_CHANGE, 5000);
			instance.raiseHandChange("123", true);
		}
		
		private function raiseHandSignalChecker(user:User, change:int):void
		{
			assertThat(user, equalTo(instance.getUser("123")));
			assertThat(change, equalTo(UserList.RAISE_HAND));
			dispatcher.dispatchEvent(new UserListTestHelperEvents(UserListTestHelperEvents.RAISE_HAND_CHANGE));
		}
		
		[Test]
		public function raiseHandChange_invalidUserID_doesntBreak():void
		{
			var newUser:User = createNewUser("123", "ABC");
			instance.addUser(newUser);
			instance.removeUser("123");
			instance.raiseHandChange("123", true);
			instance.raiseHandChange("invalid_id", true);
		}
		
		/* UserList::userJoinAudio tests */
		
		[Test]
		public function userJoinAudio_setsPropertiesOnUser_1():void
		{
			var newUser:User = createNewUser("123", "ABC");
			instance.addUser(newUser);
			instance.userJoinAudio("123", "voice_id", true, false, false);
			
			assertThat(newUser.voiceJoined, equalTo(true));
			assertThat(newUser.voiceUserId, equalTo("voice_id"));
			assertThat(newUser.muted, equalTo(true));
			assertThat(newUser.talking, equalTo(false));
			assertThat(newUser.locked, equalTo(false));
		}
		
		[Test]
		public function userJoinAudio_setsPropertiesOnUser_2():void
		{
			var newUser:User = createNewUser("123", "ABC");
			instance.addUser(newUser);
			instance.userJoinAudio("123", "voice_id", false, true, false);
			
			assertThat(newUser.voiceJoined, equalTo(true));
			assertThat(newUser.voiceUserId, equalTo("voice_id"));
			assertThat(newUser.muted, equalTo(false));
			assertThat(newUser.talking, equalTo(true));
			assertThat(newUser.locked, equalTo(false));
		}
		
		[Test (async)]
		public function userJoinAudio_dispatchesJoinAudioSignal():void
		{
			var newUser:User = createNewUser("123", "ABC");
			instance.addUser(newUser);
			instance.userChangeSignal.add(joinAudioSignalChecker);
			Async.proceedOnEvent(this, dispatcher, UserListTestHelperEvents.JOIN_AUDIO, 5000);
			instance.userJoinAudio("123", "voice_id", false, false, false);
		}
		
		private function joinAudioSignalChecker(user:User, change:int):void
		{
			assertThat(user, equalTo(instance.getUser("123")));
			assertThat(change, equalTo(UserList.JOIN_AUDIO));
			dispatcher.dispatchEvent(new UserListTestHelperEvents(UserListTestHelperEvents.JOIN_AUDIO));
		}
		
		[Test]
		public function userJoinAudio_invalidUserID_doesntBreak():void
		{
			var newUser:User = createNewUser("123", "ABC");
			instance.addUser(newUser);
			instance.removeUser("123");
			instance.userJoinAudio("123", "voice_id", false, false, false);
			instance.userJoinAudio("invalid_id", "voice_id", false, false, false);
		}
		
		/* UserList::userLeaveAudio tests */
		
		[Test]
		public function userLeaveAudio_setsVoiceJoinedPropertyToFalse():void
		{
			var newUser:User = createNewUser("123", "ABC");
			newUser.voiceJoined = true;
			instance.addUser(newUser);
			instance.userLeaveAudio("123");
			assertThat(newUser.voiceJoined, equalTo(false));
		}
		
		[Test (async)]
		public function userLeaveAudio_dispatchesJoinAudioSignal():void
		{
			var newUser:User = createNewUser("123", "ABC");
			newUser.voiceJoined = true;
			instance.addUser(newUser);
			instance.userChangeSignal.add(leaveAudioSignalChecker);
			Async.proceedOnEvent(this, dispatcher, UserListTestHelperEvents.LEAVE_AUDIO);
			instance.userLeaveAudio("123");
		}
		
		private function leaveAudioSignalChecker(user:User, change:int):void
		{
			assertThat(user, equalTo(instance.getUser("123")));
			assertThat(change, equalTo(UserList.JOIN_AUDIO));
			dispatcher.dispatchEvent(new UserListTestHelperEvents(UserListTestHelperEvents.LEAVE_AUDIO));
		}
		
		[Test]
		public function userLeaveAudio_invalidUserID_doesntBreak():void
		{
			var newUser:User = createNewUser("123", "ABC");
			instance.addUser(newUser);
			instance.removeUser("123");
			instance.userLeaveAudio("123");
			instance.userLeaveAudio("invalid_id");
		}
		
		/* UserList::userMuteChange tests */
		
		[Test]
		public function userMuteChange_setsMuteProperty():void
		{
			var newUser:User = createNewUser("123", "ABC");
			newUser.voiceUserId = "voice_id";
			newUser.muted = true;
			instance.addUser(newUser);
			instance.userMuteChange("voice_id", false);
			assertThat(newUser.muted, equalTo(false));
		}
		
		[Test]
		public function userMuteChange_userMutedWhileTalking_setsTalkingToFalse():void
		{
			var newUser:User = createNewUser("123", "ABC");
			newUser.voiceUserId = "voice_id";
			newUser.muted = false;
			newUser.talking = true;
			instance.addUser(newUser);
			instance.userMuteChange("voice_id", true);
			assertThat(newUser.muted, equalTo(true));
			assertThat(newUser.talking, equalTo(false));
		}
		
		[Test (async)]
		public function userMuteChange_dispatchesMuteSignal():void
		{
			var newUser:User = createNewUser("123", "ABC");
			newUser.voiceUserId = "voice_id";
			instance.addUser(newUser);
			instance.userChangeSignal.add(muteSignalChecker);
			Async.proceedOnEvent(this, dispatcher, UserListTestHelperEvents.MUTE_CHANGE, 5000);
			instance.userMuteChange("voice_id", true);
		}
		
		private function muteSignalChecker(user:User, change:int):void
		{
			assertThat(user, equalTo(instance.getUser("123")));
			assertThat(change, equalTo(UserList.MUTE));
			dispatcher.dispatchEvent(new UserListTestHelperEvents(UserListTestHelperEvents.MUTE_CHANGE));
		}
		
		[Test]
		public function userMuteChange_invalidUserID_doesntBreak():void
		{
			var newUser:User = createNewUser("123", "ABC");
			newUser.voiceUserId = "voice_id";
			instance.addUser(newUser);
			instance.removeUser("123");
			instance.userMuteChange("voice_id", true);
			instance.userMuteChange("invalid_voice_id", true); 
		}
		
		/* UserList::userTalkingChange tests */
		
		[Test]
		public function userTalkingChange_setsTalkingProperty():void
		{
			var newUser:User = createNewUser("123", "ABC");
			newUser.voiceUserId = "voice_id";
			newUser.talking = false;
			instance.addUser(newUser);
			instance.userTalkingChange("voice_id", true);
			assertThat(newUser.talking, equalTo(true));
		}
		
		[Test]
		public function userTalkingChange_invalidUserID_doesntBreak():void
		{
			var newUser:User = createNewUser("123", "ABC");
			newUser.voiceUserId = "voice_id";
			instance.addUser(newUser);
			instance.removeUser("123");
			instance.userTalkingChange("voice_id", true);
			instance.userTalkingChange("invalid_voice_id", true);
		}
		
		/* UserList::listenOnlyChange tests */
		
		[Test]
		public function listenOnlyChange_setsListenOnlyProperty():void
		{
			var newUser1:User = createNewUser("111", "AAA");
			newUser1.listenOnly = true;
			
			var newUser2:User = createNewUser("222", "BBB");
			newUser2.listenOnly = false;
			
			instance.addUser(newUser1);
			instance.addUser(newUser2);
			instance.listenOnlyChange("111", false);
			instance.listenOnlyChange("222", true);
			
			assertThat(newUser1.listenOnly, equalTo(false));
			assertThat(newUser2.listenOnly, equalTo(true));
		}
		
		[Test (async)]
		public function listenOnlyChange_dispatcherListOnlySignal():void
		{
			var newUser:User = createNewUser("123", "ABC");
			instance.addUser(newUser);
			instance.userChangeSignal.add(listenOnlyChangeSignalChecker);
			Async.proceedOnEvent(this, dispatcher, UserListTestHelperEvents.LISTEN_ONLY_CHANGE, 5000);
			instance.listenOnlyChange("123", true);
		}
		
		private function listenOnlyChangeSignalChecker(user:User, change:int):void
		{
			assertThat(user, equalTo(instance.getUser("123")));
			assertThat(change, equalTo(UserList.LISTEN_ONLY));
			dispatcher.dispatchEvent(new UserListTestHelperEvents(UserListTestHelperEvents.LISTEN_ONLY_CHANGE));
		}
		
		[Test]
		public function listenOnlyChange_invalidUserID_doesntBreak():void
		{
			var newUser:User = createNewUser("123", "ABC");
			instance.addUser(newUser);
			instance.removeUser("123");
			instance.listenOnlyChange("123", true);
			instance.listenOnlyChange("invalid_id", true);
		}
		
/*		[Test]
		public function instantiated_isInstanceOfUserList():void
		{
			assertTrue("instance is UserList", instance is UserList);
		}
		
		[Test]
		public function listenerRemoved_numberOfListenersIsNull():void
		{	
			// Arrange
			instance.userChangeSignal.add(listener);
			
			// Act
			instance.userChangeSignal.remove(listener);
			
			// Assert
			assertTrue("view is destroyed when mediator is destroyed", instance.userChangeSignal.numListeners == 0);
		}
		
		[Test]
		public function listenerAdded_numberOfListenersIsNotNull():void
		{	
			// Act
			instance.userChangeSignal.add(listener);
			
			// Assert
			assertTrue("view is destroyed when mediator is destroyed", instance.userChangeSignal.numListeners != 0);
		}
		
		private function listener(e : Event) : void
		{
		}*/
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		/* Helper function to generate fake user instances. Some properties are already defaulted accordingly in the
		 * definition of the User class, but to be consistent, they are all set here. */
		private function createNewUser(userID:String, name:String):User
		{
			var newUser:User = new User();
			
			newUser.userID = userID;
			newUser.name = name;
			
			newUser.hasStream = false;
			newUser.isLeavingFlag = false;
			newUser.listenOnly = false;
			newUser.locked = false;
			newUser.me = false;
			newUser.muted = false;
			newUser.phoneUser = false;
			newUser.presenter = false;
			newUser.raiseHand = false;
			newUser.role = User.VIEWER;
			newUser.streamName = "";
			newUser.talking = false;
			newUser.voiceJoined = false;
			newUser.voiceUserId = "";
			
			return newUser;
		}
	}
}
