package org.mconf.mobile
{
	import org.mconf.mobile.command.ConnectCommand;
	import org.mconf.mobile.command.ConnectSignal;
	import org.mconf.mobile.core.BigBlueButtonConnection;
	import org.mconf.mobile.core.IBigBlueButtonConnection;
	import org.mconf.mobile.core.IJoinService;
	import org.mconf.mobile.core.JoinService;
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
			injector.map(IJoinService).toType(JoinService);
			injector.map(IBigBlueButtonConnection).toType(BigBlueButtonConnection);
			
			signalCommandMap.map(ConnectSignal).toCommand(ConnectCommand);
		}
	}
}