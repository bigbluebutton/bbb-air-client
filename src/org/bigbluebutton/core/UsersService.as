package org.bigbluebutton.core
{
	import org.bigbluebutton.model.IConferenceParameters;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.User;

	public class UsersService implements IUsersService
	{
		[Inject]
		public var usersServiceSO: IUsersServiceSO;
		
		[Inject]
		public var listenersServiceSO: IListenersServiceSO;

		[Inject]
		public var conferenceParameters: IConferenceParameters;
		
		[Inject]
		public var userSession: IUserSession;

		public function UsersService()
		{
		}
		
		public function connectUsers(uri:String):void {
			usersServiceSO.connect(userSession.mainConnection.connection, uri, conferenceParameters);
		}
		
		public function connectListeners(uri:String):void {
			listenersServiceSO.connect(userSession.mainConnection.connection, uri, conferenceParameters);
		}
		
		public function muteMe():void {
			mute(userSession.userlist.me.userID);
		}
		
		public function unmuteMe():void {
			unmute(userSession.userlist.me.userID);
		}
		
		public function mute(userId:String):void {
			muteUnmute(userId, true);
		}
		
		public function unmute(userId:String):void {
			muteUnmute(userId, false);
		}
		
		private function muteUnmute(userId:String, mute:Boolean):void {
			var user:User = userSession.userlist.getUser(userId);
			if (user.voiceJoined) {
				listenersServiceSO.muteUnmuteUser(user.voiceUserId, mute);
			}
		}
		
		public function disconnect():void {
			usersServiceSO.disconnect();
			listenersServiceSO.disconnect();
		}
	}
}