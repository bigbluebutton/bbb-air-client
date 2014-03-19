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

	public class ListenersServiceSO extends BaseServiceSO implements IListenersServiceSO
	{
		[Inject]
		public var userSession: IUserSession;
		
		private static const SO_NAME:String = "meetMeUsersSO";
		
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
			trace("getRoomMuteState success: is room muted? " + (result as Boolean));
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
			
			userSession.userList.userJoinAudio(externUserID, userId, muted, talking, locked);
		}
		
		public function userMute(userID:Number, mute:Boolean):void {
			trace("userMuted() [" + userID + "," + mute + "]");
			
			userSession.userList.userMuteChange(userID, mute);
		}
		
		public function userLockedMute(userID:Number, locked:Boolean):void {
			trace("userLockedMute() [" + userID + "," + locked + "]");
			
			userSession.userList.userLockedChange(userID, locked);
		}

		public function userTalk(userID:Number, talk:Boolean):void {
			trace("userTalk() [" + userID + "," + talk + "]");
			userSession.userList.userTalkingChange(userID, talk);
		}
		
		public function userLeft(userID:Number):void {
			trace("userLeft Audio() [" + userID + "]");
			
			userSession.userList.userLeaveAudio(userID);
		}
		
		public function ping(message:String):void {
			trace("ping() [" + message + "]");
		}		
	}
}