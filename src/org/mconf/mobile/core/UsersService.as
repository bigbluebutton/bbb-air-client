package org.mconf.mobile.core
{
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.net.SharedObject;
	
	import mx.utils.ObjectUtil;
	
	import org.mconf.mobile.model.ConferenceParameters;
	import org.mconf.mobile.model.ConnectionFailedEvent;
	import org.mconf.mobile.model.User;

	public class UsersService
	{
		private var _participantsSO:SharedObject;
		private static const SO_NAME:String = "participantsSO";
		
		private var _connectionManager:ConnectionManager;
		private var _room:String;
		private var _applicationURI:String;
		
		public function UsersService(uri:String)
		{
			_applicationURI = uri;
			_connectionManager.uri = uri;
		}
		
		public function connect(params:ConferenceParameters):void {
			_room = params.room;
			_connectionManager.connect(params);
		}
		
		public function disconnect():void {
			if (_participantsSO != null) {
				_participantsSO.close();
			}
		}
		
		public function join(userid:String, room:String):void {
			_participantsSO = SharedObject.getRemote(SO_NAME, _applicationURI + "/" + room, false);
			_participantsSO.addEventListener(NetStatusEvent.NET_STATUS, onNetStatusEvent);
			_participantsSO.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncErrorEvent);
			_participantsSO.client = this;
			_participantsSO.connect(_connectionManager.connection);
			queryForParticipants();
		}
		
		private function onNetStatusEvent(e:NetStatusEvent):void {
			trace(ObjectUtil.toString(e));
		}
		
		private function onAsyncErrorEvent(e:AsyncErrorEvent):void {
			trace(ObjectUtil.toString(e));
		}
		
		private function queryForParticipants():void {
			var nc:NetConnection = _connectionManager.connection;
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
		
		private function participantJoined(joinedUser:Object):void {
			var user:User = new User();
			user.userID = joinedUser.userid;
			user.name = joinedUser.name;
			user.role = joinedUser.role;
			user.externUserID = joinedUser.externUserID;
			user.isLeavingFlag = false;
			
			trace("Joined as [" + user.userID + "," + user.name + "," + user.role + "]");
		}
		
		private function sendConnectionFailedEvent(reason:String):void {
			
		}
	}
}