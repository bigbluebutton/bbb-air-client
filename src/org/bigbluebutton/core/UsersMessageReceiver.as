package org.bigbluebutton.core
{
	import org.bigbluebutton.core.IUsersMessageReceiver;
	import org.bigbluebutton.model.IMessageListener;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.User;
	import org.osflash.signals.Signal;
	
	public class UsersMessageReceiver implements IUsersMessageReceiver, IMessageListener
	{
		[Inject]
		public var userSession: IUserSession;
		
		public function UsersMessageReceiver() {
			
		}
		
		public function onMessage(messageName:String, message:Object):void {
			switch(messageName) {
				case "voiceUserTalking":
					handleVoiceUserTalking(message);
					break;
				case "participantJoined":
					handleParticipantJoined(message);
					break;
				case "participantLeft":
					handleParticipantLeft(message);
					break;
				case "userJoinedVoice":
					handleUserJoinedVoice(message);
					break;
				case "userLeftVoice":
					handleUserLeftVoice(message);
					break;
				case "userSharedWebcam":
					handleUserSharedWebcam(message);
					break;
				case "userUnsharedWebcam":
					handleUserUnsharedWebcam(message);
					break;
				case "user_listening_only":
					handleUserListeningOnly(message);
					break;
				case "assignPresenterCallback":
					handleAssignPresenterCallback(message);
					break;
				case "voiceUserMuted":
					handleVoiceUserMuted(message);
					break;
				case "userRaisedHand":
					handleUserRaisedHand(message);
					break;
				case "userLoweredHand":
					handleUserLoweredHand(message);
					break;
				case "recordingStatusChanged":
					handleRecordingStatusChanged(message);
					break;
				case "joinMeetingReply":
					handleJoinedMeeting(message);
					break;
				case "getUsersReply":
					handleGetUsersReply(message);
					break;
				case "getRecordingStatusReply":
					handleGetRecordingStatusReply(message);
					break;
				case "meetingHasEnded":
					handleMeetingHasEnded(message);
					break;
				case "meetingEnded":
					handleLogout(message);
					break;
				default:
					break;
			}
		}
		
		private function handleVoiceUserTalking(m:Object):void {
			var msg:Object = JSON.parse(m.msg);
			trace("UsersMessageReceiver::handleVoiceUserTalking() -- user [" + + msg.voiceUserId + "," + msg.talking + "] ");			
			userSession.userList.userTalkingChange(msg.voiceUserId, msg.talking);
		}
		
		private function handleGetUsersReply(m:Object):void {
			var msg:Object = JSON.parse(m.msg);
			
			for(var i:int; i < msg.users.length; i++) {
				var u:Object = msg.users[i];
				var user:User = new User;
				
				user.hasStream = u.hasStream;
				user.streamName = u.webcamStream;
				user.locked = u.locked;
				user.name = u.name;
				user.phoneUser = u.phoneUser;
				user.presenter = u.presenter;
				user.raiseHand = u.raiseHand;
				user.role = u.role;
				user.userID = u.userId;
				user.voiceJoined = u.voiceUser.joined;
				user.voiceUserId = u.voiceUser.userId;
				user.isLeavingFlag = false;
				
				userSession.userList.addUser(user);
				
				// The following properties are 'special', in that they have view changes associated with them.
				// The UserList changes the model accordingly, then dispatches a signal to the views.
				
				if(user.hasStream) {
					userSession.userList.userStreamChange(user.userID, user.hasStream, user.streamName);
				}				
				if(user.presenter) {
					userSession.userList.assignPresenter(user.userID);
				}
				if(user.raiseHand) {
					userSession.userList.raiseHandChange(user.userID, user.raiseHand);
				}
			}
			userSession.userList.allUsersAddedSignal.dispatch();
		}
		
		private function handleParticipantJoined(m:Object):void {
			var msg:Object = JSON.parse(m.msg);
			var newUser:Object = msg.user;
			var user:User = new User;
			
			user.hasStream = newUser.hasStream;
			user.streamName = newUser.webcamStream;
			user.locked = newUser.locked;
			user.name = newUser.name;
			user.phoneUser = newUser.phoneUser;
			user.presenter = newUser.presenter;
			user.raiseHand = newUser.raiseHand;
			user.role = newUser.role;
			user.userID = newUser.userId;
			user.voiceJoined = newUser.voiceUser.joined;
			user.voiceUserId = newUser.voiceUser.userId;
			user.isLeavingFlag = false;
			
			userSession.userList.addUser(user);
			
			// The following properties are 'special', in that they have view changes associated with them.
			// The UserList changes the model appropriately, then dispatches a signal to the views.
			
			if(user.hasStream) {
				userSession.userList.userStreamChange(user.userID, user.hasStream, user.streamName);
			}				
			if(user.presenter) {
				userSession.userList.assignPresenter(user.userID);
			}
			if(user.raiseHand) {
				userSession.userList.raiseHandChange(user.userID, user.raiseHand);
			}
		}
		
		private function handleParticipantLeft(m:Object):void {
			var msg:Object = JSON.parse(m.msg);
			trace("UsersMessageReceiver::handleParticipantLeft() -- user [" + msg.user.userId + "] has left the meeting");
			userSession.userList.removeUser(msg.user.userId);
		}

		private function handleAssignPresenterCallback(m:Object):void {
			var msg:Object = JSON.parse(m.msg);
			trace("UsersMessageReceiver::handleAssignPresenterCallback() -- user [" + msg.newPresenterID + "] is now the presenter");
			userSession.userList.assignPresenter(msg.newPresenterID);
		}
		
		private function handleUserJoinedVoice(m:Object):void {
			var msg:Object = JSON.parse(m.msg);
			var voiceUser:Object = msg.user.voiceUser;
			trace("UsersMessageReceiver::handleUserJoinedVoice() -- user [" + msg.user.externUserID + "] has joined voice with voiceId [" + voiceUser.userId + "]");
			userSession.userList.userJoinAudio(msg.user.externUserID, voiceUser.userId, voiceUser.muted, voiceUser.talking, voiceUser.locked);
		}
		
		private function handleUserLeftVoice(m:Object):void {
			var msg:Object = JSON.parse(m.msg);
			trace("UsersMessageReceiver::handleUserLeftVoice() -- user [" + msg.user.userId + "] has left voice");
			userSession.userList.userLeaveAudio(msg.user.userId);
		}
		
		private function handleUserSharedWebcam(m:Object):void {
			var msg:Object = JSON.parse(m.msg);
			trace("UsersMessageReceiver::handleUserSharedWebcam() -- user [" + msg.userId + "] has shared their webcam with stream [" + msg.webcamStream + "]");
			userSession.userList.userStreamChange(msg.userId, true, msg.webcamStream); 
		}
		
		private function handleUserUnsharedWebcam(m:Object):void {
			var msg:Object = JSON.parse(m.msg);
			trace("UsersMessageReceiver::handleUserUnsharedWebcam() -- user [" + msg.userId + "] has unshared their webcam");
			userSession.userList.userStreamChange(msg.userId, false, "");
		}
		
		private function handleUserListeningOnly(m:Object):void {
			// This is commented out because, at the time of writing, there is no listenOnly property
			// of the User class, and I'm not sure the correct way to handle it... - Adam

			/*
			var msg:Object = JSON.parse(m.msg);
			userSession.userList.getUser(msg.userId).listenOnly = msg.listenOnly;
			*/
		}
		
		private function handleVoiceUserMuted(m:Object):void {
			var msg:Object = JSON.parse(m.msg);
			trace("UsersMessageReceiver::handleVoiceUserMuted() -- user [" + msg.voiceUserId + ", muted: " + msg.muted + "]");
			userSession.userList.userMuteChange(msg.voiceUserId, msg.muted);
		}
		
		private function handleUserRaisedHand(m:Object):void {
			var msg:Object = JSON.parse(m.msg);
			trace("UsersMessageReceiver::handleUserRaisedHand() -- user [" + msg.userId + "]'s hand was raised");
			userSession.userList.raiseHandChange(msg.userId, true);
		}
		
		private function handleUserLoweredHand(m:Object):void {
			var msg:Object = JSON.parse(m.msg);
			trace("UsersMessageReceiver::handleUserLoweredHand() -- user [" + msg.userId + "]'s hand was lowered");
			userSession.userList.raiseHandChange(msg.userId, false);
		}
		private function handleMeetingHasEnded(m:Object):void {
			var msg:Object = JSON.parse(m.msg);
			trace("UsersMessageReceiver::handleMeetingHasEnded() -- meeting has ended");
		}

		private function handleLogout(m:Object):void {
			var msg:Object = JSON.parse(m.msg);
			trace("UsersMessageReceiver::handleLogout() -- logging out!");
			userSession.logoutSignal.dispatch();
		}
		
		private function handleJoinedMeeting(m:Object):void {
			var msg:Object = JSON.parse(m.msg);
			trace("UsersMessageReceiver::handleJoinedMeeting()");
			userSession.joinMeetingResponse(msg);
		}
		
		private function handleRecordingStatusChanged(m:Object):void {
			var msg:Object = JSON.parse(m.msg);
			trace("UsersMessageReceiver::handleRecordingStatusChanged() -- recording status changed");
		}
		
		private function handleGetRecordingStatusReply(m:Object):void {
			trace("UsersMessageReceiver::handleGetRecordingStatusReply() -- recording status");
			var msg:Object = JSON.parse(m.msg);
		}
	}
}