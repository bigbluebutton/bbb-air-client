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
		
		[Inject]
		public var conferenceParameters: IConferenceParameters;
		
		private static const SO_NAME:String = "participantsSO";
		
		public function UsersServiceSO() {
			super(SO_NAME);
		}
		
		override public function connect(connection:NetConnection, uri:String, params:IConferenceParameters):void {
			super.connect(connection, uri, params);
			
			queryForParticipants();
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
			
			userSession.userList.allUsersAddedSignal.dispatch();
			
			//becomePresenterIfLoneModerator();
		}
		
		private function queryForParticipantsOnUnsucess(status:Object):void
		{
			trace("Error occurred");
			trace(ObjectUtil.toString(status));
			onConnectionFailed(ConnectionFailedEvent.UNKNOWN_REASON);
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
			
			userSession.userList.addUser(user);
			
			participantStatusChange(user.userID, "hasStream", joinedUser.status.hasStream);
			participantStatusChange(user.userID, "presenter", joinedUser.status.presenter);
			participantStatusChange(user.userID, "raiseHand", joinedUser.status.raiseHand);
		}
		
		public function participantLeft(userID:String):void { 			
			trace("Notify others that user [" + userID + "] is leaving!!!!");
			
			userSession.userList.removeUser(userID);
		}
		
		/**
		 * Callback from the server from many of the bellow nc.call methods
		 */
		public function participantStatusChange(userID:String, status:String, value:Object):void {
			trace("Received status change [" + userID + "," + status + "," + value + "]")			
			
			switch (status) {
				case "presenter":
					if (Boolean(value) == true)
						userSession.userList.assignPresenter(userID);
					break;
				case "hasStream":
					var streamInfo:Array = String(value).split(/,/); 
					
					userSession.userList.userStreamChange(userID,
						(String(streamInfo[0]).toUpperCase() == "TRUE" ? true : false),
						String(streamInfo[1]).split(/=/)[1]);
					break;
				case "raiseHand":
					userSession.userList.raiseHandChange(userID, value as Boolean);
					break;
			}
		}
		
		/**
		 * Called by the server to assign a presenter
		 */
		public function assignPresenterCallback(userID:String, name:String, assignedBy:String):void {
			trace("**** assignPresenterCallback [" + userID + "," + name + "," + assignedBy + "]");
			
			userSession.userList.assignPresenter(userID);
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
		
		override protected function onConnectionFailed(reason:String):void {
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
		
		public function raiseHand(userID:String, raise:Boolean):void {
			var nc:NetConnection = userSession.mainConnection.connection;			
			nc.call(
				"participants.setParticipantStatus", // Remote function name
				responder,
				userID,
				"raiseHand",
				raise
			); // _netConnection.call
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
	}
}