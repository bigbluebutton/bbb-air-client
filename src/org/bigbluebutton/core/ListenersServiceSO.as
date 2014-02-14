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
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class ListenersServiceSO extends BaseServiceSO implements IListenersServiceSO
	{
		[Inject]
		public var userSession: IUserSession;
		
		private static const SO_NAME:String = "meetMeUsersSO";
		private var _muteStateSignal:ISignal = new Signal();
		
		public function ListenersServiceSO() {
			super(SO_NAME);
		}
		
		override public function connect(connection:NetConnection, uri:String, params:IConferenceParameters):void {
			super.connect(connection, uri, params);
			
			// Query the server if there are already listeners in the conference.
			getCurrentUsers();
			getRoomMuteState();
		}
		
		private function getCurrentUsers():void {
			var nc:NetConnection = userSession.mainConnection.connection;
			var restoreFunctionName:String = "voice.getMeetMeUsers";
			
			nc.call(restoreFunctionName,
					new Responder(getCurrentUsersOnSucess, getCurrentUsersOnUnsucess)
			);
		}
		
		private function getCurrentUsersOnSucess(result:Object):void
		{
			trace("Successfully queried listeners: " + result.count); 
			if (result.count > 0) {
				for(var p:Object in result.participants) {
					participantJoined(result.participants[p]);
				}
			}	
		}
		
		private function getCurrentUsersOnUnsucess(status:Object):void
		{
			trace("Error occurred");
			trace(ObjectUtil.toString(status));
			onConnectionFailed(ConnectionFailedEvent.UNKNOWN_REASON);
		}
		
		private function getRoomMuteState():void {
			var nc:NetConnection = userSession.mainConnection.connection;
			var restoreFunctionName:String = "voice.isRoomMuted";
			
			nc.call(restoreFunctionName,
					new Responder(getRoomMuteStateOnSucess, getRoomMuteStateOnUnsucess)
			);
		}

		private function getRoomMuteStateOnSucess(result:Object):void
		{
			_muteStateSignal.dispatch(result as Boolean);
		}
		
		private function getRoomMuteStateOnUnsucess(status:Object):void
		{
			trace("Error occurred");
			trace(ObjectUtil.toString(status));
			onConnectionFailed(ConnectionFailedEvent.UNKNOWN_REASON);
		}
		
		
		private function participantJoined(joinedUser:Object):void {
			var userId:Number = joinedUser.participant;
			var cidName:String = joinedUser.name;
			var cidNum:String = joinedUser.name;
			var muted:Boolean = joinedUser.muted; 
			var talking:Boolean = joinedUser.talking;
			var locked:Boolean = joinedUser.locked;
			
			userJoin(userId, cidName, cidNum, muted, talking, locked);
		}

		public function get muteStateSignal():ISignal
		{
			return _muteStateSignal;
		}

		public function set muteStateSignal(value:ISignal):void
		{
			_muteStateSignal = value;
		}

		public function muteUnmuteUser(userId:Number, mute:Boolean):void {
			var nc:NetConnection = userSession.mainConnection.connection;
			var restoreFunctionName:String = "voice.muteUnmuteUser";
			
			nc.call(restoreFunctionName,
					new Responder(muteUnmuteUserOnSucess, muteUnmuteUserOnUnsucess),
					userId,
					mute
			);
		}
		
		private function muteUnmuteUserOnSucess(result:Object):void
		{
			trace("Successfully mute/unmute");// + userId);
		}
		
		private function muteUnmuteUserOnUnsucess(status:Object):void
		{
			trace("Error occurred");
			trace(ObjectUtil.toString(status));
		}
		
		//TODO: server calling this when muting or unmuting multiple users 
		public function muteStateCallback(param0:Object = null, param1:Object = null, param2:Object = null, param3:Object = null, param4:Object = null):void
		{
			trace("muteStateCallback")
		}
			
		/**
		 * Callback from the server from many of the bellow nc.call methods
		 */
		
		public function userJoin(userId:Number, cidName:String, cidNum:String, muted:Boolean, talking:Boolean, locked:Boolean):void {
			trace("New listener joined ["
				+ "userId:" + userId + "," 
				+ "cidName:" + cidName + "," 
				+ "cidNum:" + cidNum + "," 
				+ "muted:" + muted + "," 
				+ "talking:" + talking + "," 
				+ "locked:" + locked + "]");

			var pattern:RegExp = /(.*)-bbbID-(.*)$/;
			var result:Object = pattern.exec(cidName);
			var externUserID:String = result[1] as String;
			
			var user:User = userSession.userList.getUser(externUserID);
			user.voiceUserId = userId;
			user.voiceJoined = true;
			user.muted = muted;
			user.talking = talking;
			user.locked = locked;
		}
		
		public function userMute(userID:Number, mute:Boolean):void {
			trace("userMuted() [" + userID + "," + mute + "]");
			var user:User = userSession.userList.getUserByVoiceUserId(userID);
			user.muted = mute;
		}
		
		public function userLockedMute(userID:Number, locked:Boolean):void {
			trace("userLockedMute() [" + userID + "," + locked + "]");
			var user:User = userSession.userList.getUserByVoiceUserId(userID);
			user.locked = locked;
		}

		public function userTalk(userID:Number, talk:Boolean):void {
//			trace("userTalk() [" + userID + "," + talk + "]");
			var user:User = userSession.userList.getUserByVoiceUserId(userID);
			user.talking = talk;
		}
		
		public function userLeft(userID:Number):void {
			trace("userLeft() [" + userID + "]");
			var user:User = userSession.userList.getUserByVoiceUserId(userID);
			if(user)
			{
				user.voiceJoined = false;
			}
			else
			{
				trace("--------------------------------------------------------------------------------");
				trace("WARNING - ListenersServiceSO.userLeft(userID: "+userID+") - userID not found");
				trace("--------------------------------------------------------------------------------");
			}
		}
		
		public function ping(message:String):void {
			trace("ping() [" + message + "]");
		}		
	}
}