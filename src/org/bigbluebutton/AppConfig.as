package org.bigbluebutton
{
	import org.bigbluebutton.command.CameraEnableCommand;
	import org.bigbluebutton.command.CameraEnableSignal;
	import org.bigbluebutton.command.ConnectCommand;
	import org.bigbluebutton.command.ConnectSignal;
	import org.bigbluebutton.command.JoinVoiceCommand;
	import org.bigbluebutton.command.JoinVoiceSignal;
	import org.bigbluebutton.command.LoadPresentationCommand;
	import org.bigbluebutton.command.LoadPresentationSignal;
	import org.bigbluebutton.command.LoadSlideCommand;
	import org.bigbluebutton.command.LoadSlideSignal;
	import org.bigbluebutton.core.BigBlueButtonConnection;
	import org.bigbluebutton.core.ChatMessageReceiver;
	import org.bigbluebutton.core.ChatMessageSender;
	import org.bigbluebutton.core.ChatMessageService;
	import org.bigbluebutton.core.IBigBlueButtonConnection;
	import org.bigbluebutton.core.IChatMessageReceiver;
	import org.bigbluebutton.core.IChatMessageSender;
	import org.bigbluebutton.core.IChatMessageService;
	import org.bigbluebutton.core.IListenersServiceSO;
	import org.bigbluebutton.core.ILoginService;
	import org.bigbluebutton.core.IPresentMessageReceiver;
	import org.bigbluebutton.core.IPresentServiceSO;
	import org.bigbluebutton.core.IPresentationService;
	import org.bigbluebutton.core.IUsersService;
	import org.bigbluebutton.core.IUsersServiceSO;
	import org.bigbluebutton.core.IVideoConnection;
	import org.bigbluebutton.core.IVoiceConnection;
	import org.bigbluebutton.core.ListenersServiceSO;
	import org.bigbluebutton.core.LoginService;
	import org.bigbluebutton.core.PresentMessageReceiver;
	import org.bigbluebutton.core.PresentServiceSO;
	import org.bigbluebutton.core.PresentationService;
	import org.bigbluebutton.core.UsersService;
	import org.bigbluebutton.core.UsersServiceSO;
	import org.bigbluebutton.core.VideoConnection;
	import org.bigbluebutton.core.VoiceConnection;
	import org.bigbluebutton.model.ConferenceParameters;
	import org.bigbluebutton.model.IConferenceParameters;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.IUserSettings;
	import org.bigbluebutton.model.IUserUISession;
	import org.bigbluebutton.model.UserSession;
	import org.bigbluebutton.model.UserSettings;
	import org.bigbluebutton.model.UserUISession;
	
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
			injector.map(IListenersServiceSO).toType(ListenersServiceSO);
			injector.map(IUsersService).toSingleton(UsersService);
			injector.map(IBigBlueButtonConnection).toType(BigBlueButtonConnection);
			injector.map(IVoiceConnection).toType(VoiceConnection);
			injector.map(IVideoConnection).toType(VideoConnection);
			injector.map(IChatMessageService).toSingleton(ChatMessageService);
			injector.map(IChatMessageReceiver).toSingleton(ChatMessageReceiver);
			injector.map(IChatMessageSender).toSingleton(ChatMessageSender);
			injector.map(IPresentServiceSO).toType(PresentServiceSO);
			injector.map(IPresentationService).toSingleton(PresentationService);
			injector.map(IPresentMessageReceiver).toSingleton(PresentMessageReceiver);
			
			signalCommandMap.map(ConnectSignal).toCommand(ConnectCommand);
			signalCommandMap.map(JoinVoiceSignal).toCommand(JoinVoiceCommand);
			signalCommandMap.map(CameraEnableSignal).toCommand(CameraEnableCommand);
			signalCommandMap.map(LoadPresentationSignal).toCommand(LoadPresentationCommand);
			signalCommandMap.map(LoadSlideSignal).toCommand(LoadSlideCommand);
		}
	}
}