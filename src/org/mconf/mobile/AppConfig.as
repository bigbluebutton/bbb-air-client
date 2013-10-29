package org.mconf.mobile
{
	import org.mconf.mobile.core.IJoinService;
	import org.mconf.mobile.core.JoinService;
	import org.mconf.mobile.model.ConferenceParameters;
	import org.mconf.mobile.model.IConferenceParameters;
	import org.mconf.mobile.model.IUserSession;
	import org.mconf.mobile.model.IUserSettings;
	import org.mconf.mobile.model.UserSession;
	import org.mconf.mobile.model.UserSettings;
	
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IInjector;
	
	public class AppConfig implements IConfig
	{
		[Inject]
		public var injector: IInjector;
		
		public function configure(): void
		{
			injector.map(IUserSettings).toSingleton(UserSettings);
			injector.map(IUserSession).toSingleton(UserSession);
			injector.map(IConferenceParameters).toSingleton(ConferenceParameters);
			injector.map(IJoinService).toType(JoinService);
		}
	}
}