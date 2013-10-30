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

	public class UsersServiceSO implements IUsersServiceSO
	{
		[Inject]
		public var userSession: IUserSession;
		
		private var _participantsSO:SharedObject;
		private static const SO_NAME:String = "participantsSO";
		
		private var _room:String;
		private var _applicationURI:String;
		
		public function UsersServiceSO() { }
		
		public function connect(uri:String, params:IConferenceParameters):void {
			_applicationURI = uri;
			_room = params.room;
		}
		
		public function disconnect():void {
			if (_participantsSO != null) {
				_participantsSO.close();
			}
		}
		
		public function join():void {
			_participantsSO = SharedObject.getRemote(SO_NAME, _applicationURI + "/" + _room, false);
			_participantsSO.addEventListener(NetStatusEvent.NET_STATUS, onNetStatusEvent);
			_participantsSO.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncErrorEvent);
			_participantsSO.client = this;
			_participantsSO.connect(userSession.netconnection);
			queryForParticipants();
		}
		
		private function onNetStatusEvent(e:NetStatusEvent):void {
			trace(ObjectUtil.toString(e));
		}
		
		private function onAsyncErrorEvent(e:AsyncErrorEvent):void {
			trace(ObjectUtil.toString(e));
		}
		
		private function queryForParticipants():void {
			var nc:NetConnection = userSession.netconnection;
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
			user.externUserID = joinedUser.externUserID;
			user.isLeavingFlag = false;
			
			trace("New user joined [" + user.userID + "," + user.name + "," + user.role + "]");
			
			userSession.userlist.addUser(user);
		}
		
		public function participantLeft(userID:String):void { 			
			var user:User = userSession.userlist.getUser(userID);
			
			trace("Notify others that user [" + user.userID + ", " + user.name + "] is leaving!!!!");
			
			// Flag that the user is leaving the meeting so that apps (such as avatar) doesn't hang
			// around when the user already left.
			if (user) user.isLeavingFlag = true;
			
			userSession.userlist.removeUser(userID);
		}
		
		/**
		 * Callback from the server from many of the bellow nc.call methods
		 */
		public function participantStatusChange(userID:String, status:String, value:Object):void {
			trace("Received status change [" + userID + "," + status + "," + value + "]")			
			var user:User = userSession.userlist.getUser(userID);
			
			if (user)
			switch (status) {
				/* I don't think we need this case because we already have a presenterCallback - Chad
				case "presenter":
					user.presenter = value as Boolean;
					if (user.me) {
						userSession.userlist.me.presenter = value as Boolean;
					}
					break;
				*/
				case "hasStream":
					var streamInfo:Array = String(value).split(/,/); 
					/**
					 * Cannot use this statement as new Boolean(expression)
					 * return true if the expression is a non-empty string not
					 * when the string equals "true". See Boolean class def.
					 * 
					 * hasStream = new Boolean(String(streamInfo[0]));
					 */					
					if (String(streamInfo[0]).toUpperCase() == "TRUE") {
						user.hasStream = true;
					} else {
						user.hasStream = false;
					}
					
					if (user.me) {
						userSession.userlist.me.hasStream = value as Boolean;
					}
					
					var streamNameInfo:Array = String(streamInfo[1]).split(/=/);
					user.streamName = streamNameInfo[1]; 
					
					if (user.hasStream) {
						//Signal for new stream share
					}
					break;
				case "raiseHand":
					user.raiseHand = value as Boolean;
					if (user.me) {
						userSession.userlist.me.raiseHand = value as Boolean;
					}
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
		
		private function sendConnectionFailedEvent(reason:String):void {
			trace("Error in the UsersServiceSO connection");
		}
	}
}