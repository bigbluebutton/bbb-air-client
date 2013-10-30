package org.mconf.mobile
{
	import org.mconf.mobile.command.ConnectCommand;
	import org.mconf.mobile.command.ConnectSignal;
	import org.mconf.mobile.core.BigBlueButtonConnection;
	import org.mconf.mobile.core.IBigBlueButtonConnection;
	import org.mconf.mobile.core.ILoginService;
	import org.mconf.mobile.core.LoginService;
	import org.mconf.mobile.core.IUsersService;
	import org.mconf.mobile.core.IUsersServiceSO;
	import org.mconf.mobile.core.UsersService;
	import org.mconf.mobile.core.UsersServiceSO;
	import org.mconf.mobile.model.ConferenceParameters;
	import org.mconf.mobile.model.IConferenceParameters;
	import org.mconf.mobile.model.IUserSession;
	import org.mconf.mobile.model.IUserSettings;
	import org.mconf.mobile.model.IUserUISession;
	import org.mconf.mobile.model.UserSession;
	import org.mconf.mobile.model.UserSettings;
	import org.mconf.mobile.model.UserUISession;
	
	import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IInjector;
	
	public class AppConfig implements IConfig
	{
		[Inject]
		public var injector: IInjector;
				
		[Inject]
		public var signalCommandMap: ISignalCommandMap;
		
		public function configure(): void
		{
			injector.map(IUserSettings).toSingleton(UserSettings);
			injector.map(IUserUISession).toSingleton(UserUISession);
			injector.map(IUserSession).toSingleton(UserSession);
			injector.map(IConferenceParameters).toSingleton(ConferenceParameters);
			injector.map(ILoginService).toType(LoginService);
			injector.map(IUsersServiceSO).toType(UsersServiceSO);
			injector.map(IUsersService).toSingleton(UsersService);
			injector.map(IBigBlueButtonConnection).toType(BigBlueButtonConnection);
			
			signalCommandMap.map(ConnectSignal).toCommand(ConnectCommand);
		}
	}
}