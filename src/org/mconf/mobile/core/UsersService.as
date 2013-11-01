package org.mconf.mobile.core
{
	import org.mconf.mobile.model.IConferenceParameters;
	import org.mconf.mobile.model.IUserSession;

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
		
		public function disconnect():void {
			usersServiceSO.disconnect();
			listenersServiceSO.disconnect();
		}
	}
}