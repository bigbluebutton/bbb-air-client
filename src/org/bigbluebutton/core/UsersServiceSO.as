package org.bigbluebutton.core
{
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.net.SharedObject;
	
	import mx.utils.ObjectUtil;
	
	import org.bigbluebutton.model.ConnectionFailedEvent;
	import org.bigbluebutton.model.IConferenceParameters;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.User;
	import org.osmf.logging.Log;

	public class UsersServiceSO extends BaseServiceSO implements IUsersServiceSO
	{
		[Inject]
		public var userSession: IUserSession;
		
		private static const SO_NAME:String = "participantsSO";
		
		public function UsersServiceSO() {
			super(SO_NAME);
		}
		
		override public function connect(connection:NetConnection, uri:String, params:IConferenceParameters):void {
			super.connect(connection, uri, params);
			
			queryForParticipants();
			retrieveWaitingGuests();
		}
		
		private function queryForParticipants():void {
			var nc:NetConnection = userSession.mainConnection.connection;
			var restoreFunctionName:String = "participants.getParticipants";
			
			nc.call(
				restoreFunctionName,
				new Responder(queryForParticipantsOnSucess, queryForParticipantsOnUnsucess)
			);
		}
		
		private function queryForParticipantsOnSucess(result:Object):void
		{
			trace("Successfully queried participants: " + result.count); 
			if (result.count > 0) {
				for(var p:Object in result.participants) {
					participantJoined(result.participants[p]);
				}
			}	
			//becomePresenterIfLoneModerator();
		}
		
		private function queryForParticipantsOnUnsucess(status:Object):void
		{
			trace("Error occurred");
			trace(ObjectUtil.toString(status));
			sendConnectionFailedEvent(ConnectionFailedEvent.UNKNOWN_REASON);
		}
		
		public function participantJoined(joinedUser:Object):void {
			var user:User = new User();
			user.userID = joinedUser.userid;
			user.name = joinedUser.name;
			user.role = joinedUser.role;
			if (joinedUser.userid != joinedUser.externUserID) {
				trace("We were wrong, userId[" + joinedUser.userid + "] != externUserID[" + joinedUser.externUserID + "]")
			}
			user.isLeavingFlag = false;
			
			trace("New user joined [" + ObjectUtil.toString(user) + "]");
			trace(ObjectUtil.toString(joinedUser));
			
			userSession.userlist.addUser(user);
			
			participantStatusChange(user.userID, "hasStream", joinedUser.status.hasStream);
			participantStatusChange(user.userID, "presenter", joinedUser.status.presenter);
			participantStatusChange(user.userID, "raiseHand", joinedUser.status.raiseHand);
		}
		
		public function participantLeft(userID:String):void { 			
			trace("Notify others that user [" + userID + "] is leaving!!!!");
			
			userSession.userlist.removeUser(userID);
		}
		
		/**
		 * Callback from the server from many of the bellow nc.call methods
		 */
		public function participantStatusChange(userID:String, status:String, value:Object):void {
			trace("Received status change [" + userID + "," + status + "," + value + "]")			
			
			switch (status) {
				case "presenter":
					if (Boolean(value) == true)
						userSession.userlist.assignPresenter(userID);
					break;
				case "hasStream":
					var streamInfo:Array = String(value).split(/,/); 
					
					userSession.userlist.userStreamChange(userID,
						(String(streamInfo[0]).toUpperCase() == "TRUE" ? true : false),
						String(streamInfo[1]).split(/=/)[1]);
					break;
				case "raiseHand":
					userSession.userlist.raiseHandChange(userID, value as Boolean);
					break;
			}
		}
		
		/**
		 * Called by the server to assign a presenter
		 */
		public function assignPresenterCallback(userID:String, name:String, assignedBy:String):void {
			trace("**** assignPresenterCallback [" + userID + "," + name + "," + assignedBy + "]");
			
			userSession.userlist.assignPresenter(userID);
		}
		
		public function kickUserCallback(userid:String):void {
			trace("The user " + userid + " has been kicked by someone");
		}
		
		/**
		 * Called by the server to tell the client that the meeting has ended.
		 */
		public function logout():void {
			trace("The meeting has ended and a logout should be initiated");
		}
		
		override protected function sendConnectionFailedEvent(reason:String):void {
			trace("Error in the UsersServiceSO connection");
		}
		
		public function addStream(userId:String, streamName:String):void {
			setStream(userId, streamName);
		}
		
		public function removeStream(userId:String, streamName:String):void {
			setStream(userId, streamName);
		}
		
		private function setStream(userId:String, streamName:String):void {
			var nc:NetConnection = userSession.mainConnection.connection;
			var restoreFunctionName:String = "participants.setParticipantStatus";
			
			nc.call(
				restoreFunctionName,
				responder,
				userId,
				"hasStream",
				Boolean(streamName.length > 0).toString() + ",stream=" + streamName
			);
		}
		
		private var responder:Responder = new Responder(
			// On successful result
			function(result:Boolean):void { 	
			},	
			// On error occurred
			function(status:Object):void {
				trace(ObjectUtil.toString(status));
			}
		)		

		/**========================
		 * 
		 * GUEST MANAGEMENT BELOW *
		 * 
		 *========================*/
			
		public function askToEnter(userId:String):void {
			var nc:NetConnection = userSession.mainConnection.connection;
			var restoreFunctionName:String = "participants.askingToEnter";

			nc.call(
				restoreFunctionName,
				responder,
				userId
			);
		}

		// callback from server  
		public function guestEntrance(userId:String, name:String):void {
			Log.getLogger("org.bigbluebutton").info(String(this) + ":guestEntrance() userId: " + userId + " name: " + name);
			
			if (userSession.userlist.me.isModerator()) {
				trace("User " + name + " trying to join");
				allowAllIfNoOtherModerator([userId]);
			}
		}
		
		private function allowAllIfNoOtherModerator(excludeUserIdArray:Array):void {
			//TODO do proper guest handling
			// this is a workaround to allow guests if I'm the only moderator of the session
			if (amITheOnlyModerator(excludeUserIdArray)) {
				responseToAllGuests(true);
			}
		}
		
		private function amITheOnlyModerator(excludeUserIdArray:Array):Boolean {
			for each (var user:User in userSession.userlist.users) {
				// user is moderator
				// user is not in the exclude list
				// user is not me
				if (user.isModerator() && excludeUserIdArray.indexOf(user.userID) == -1 && user.userID != userSession.userlist.me.userID) {
					trace("I'm not the only moderator");
					return false;
				}
			}
			trace("amITheOnlyModerator? " + userSession.userlist.me.isModerator());
			return userSession.userlist.me.isModerator();
		}
		
		public function guestWaitingForModerator(userId:String, info:String):void {
			Log.getLogger("org.bigbluebutton").info(String(this) + ":guestWaitingForModerator() userId: " + userId + " info: " + info);

			if (userSession.userlist.me.isModerator() && userSession.userlist.me.userID == userId) {
				if (info.length > 0) {
					var infoArray:Array = info.split("!1");
					var userIdArray:Array = new Array();
					for each (var userInfo:String in infoArray) {
						if (userInfo.length > 0) {
							var userInfoArray:Array = userInfo.split("!2");
							var userId:String = userInfoArray[0];
							var userName:String = userInfoArray[1];
							
							userIdArray.push(userId);
							//TODO do something with this information
						}
					}
					
					allowAllIfNoOtherModerator(userIdArray);
				}
			}
		}
		
		public function guestResponse(userId:String, allowed:Boolean):void {
			Log.getLogger("org.bigbluebutton").info(String(this) + ":guestResponse() userId: " + userId + " allowed: " + allowed);

			if (userId == userSession.userId) {
				userSession.guestSignal.dispatch(allowed);
			}
		}
		
		public function responseToAllGuests(allowed:Boolean):void {
			Log.getLogger("org.bigbluebutton").info(String(this) + ":responseToAllGuests() allowed: " + allowed);

			var nc:NetConnection = userSession.mainConnection.connection;
			var restoreFunctionName:String = "participants.responseToAllGuests";
			
			nc.call(
				restoreFunctionName,
				responder,
				allowed
			);
		}
		
		public function retrieveWaitingGuests():void {
			Log.getLogger("org.bigbluebutton").info(String(this) + ":retrieveWaitingGuests()");

			var nc:NetConnection = userSession.mainConnection.connection;
			var restoreFunctionName:String = "participants.askingForGuestWaiting";
			
			nc.call(
				restoreFunctionName,
				responder,
				userSession.userlist.me.userID
			);
		}
	}
}