package org.mconf.mobile
{
	import org.mconf.mobile.model.IUserSettings;
	import org.mconf.mobile.model.UserSettings;
	import org.mconf.mobile.view.navigation.pages.app.IMainNavigatorView;
	import org.mconf.mobile.view.navigation.pages.app.TopView;
	import org.mconf.mobile.view.ui.IMicButton;
	import org.mconf.mobile.view.ui.MicButton;
	
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IInjector;
	
	public class AppConfig implements IConfig
	{
		[Inject]
		public var injector: IInjector;
		
		public function configure(): void
		{
			injector.map(IUserSettings).toSingleton(UserSettings);
			//injector.map(ITodoCollection).toSingleton(TodoCollection);
			//injector.map(IPopup).toSingleton(Popup);
		}
	}
}