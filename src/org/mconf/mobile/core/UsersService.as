package org.mconf.mobile.core
{
	import org.mconf.mobile.model.ConferenceParameters;
	import org.mconf.mobile.model.IConferenceParameters;

	public class UsersService implements IUsersService
	{
		[Inject]
		public var usersServiceSO: IUsersServiceSO;
		
		[Inject]
		public var conferenceParameters: IConferenceParameters;
		
		public function UsersService()
		{
		}
		
		public function connect(uri:String):void {
			usersServiceSO.connect(uri, conferenceParameters);
			usersServiceSO.join();
		}
	}
}