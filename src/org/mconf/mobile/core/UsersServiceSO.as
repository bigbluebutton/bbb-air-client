package org.mconf.mobile.core
{
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.net.SharedObject;
	
	import mx.utils.ObjectUtil;
	
	import org.mconf.mobile.model.ConnectionFailedEvent;
	import org.mconf.mobile.model.IConferenceParameters;
	import org.mconf.mobile.model.IUserSession;
	import org.mconf.mobile.model.User;

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
		}
		
		private function queryForParticipants():void {
			var nc:NetConnection = userSession.mainConnection.connection;
			nc.call(
				"participants.getParticipants",// Remote function name
				new Responder(
					// participants - On successful result
					function(result:Object):void { 
						trace("Successfully queried participants: " + result.count); 
						if (result.count > 0) {
							for(var p:Object in result.participants) {
								participantJoined(result.participants[p]);
							}
						}	
//						becomePresenterIfLoneModerator();
					},	
					// status - On error occurred
					function(status:Object):void { 
						trace("Error occurred");
						trace(ObjectUtil.toString(status));
						sendConnectionFailedEvent(ConnectionFailedEvent.UNKNOWN_REASON);
					}
				)//new Responder
			); //_netConnection.call
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
			trace("The Client has be kicked by someone");
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
	}
}