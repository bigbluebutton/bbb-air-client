package org.bigbluebutton.view.navigation.pages.audiosettings
{
	import flash.events.MouseEvent;
	
	import mx.core.FlexGlobals;
	import mx.events.ItemClickEvent;
	import mx.resources.ResourceManager;
	
	import org.bigbluebutton.command.ShareMicrophoneSignal;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.User;
	import org.bigbluebutton.model.UserList;
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Mediator;

	public class AudioSettingsViewMediator extends Mediator
	{
		[Inject]
		public var view: IAudioSettingsView;
		
		[Inject]
		public var userSession: IUserSession;
		
		[Inject]
		public var shareMicrophoneSignal: ShareMicrophoneSignal;
		
		override public function initialize():void
		{
			Log.getLogger("org.bigbluebutton").info(String(this));
			userSession.userList.userChangeSignal.add(userChangeHandler);
			
			var userMe:User = userSession.userList.me;
			view.shareMicButton.addEventListener(MouseEvent.CLICK, onShareMicClick);
			view.listenOnlyButton.addEventListener(MouseEvent.CLICK, onListenOnlyClick);
			FlexGlobals.topLevelApplication.pageName.text = ResourceManager.getInstance().getString('resources', 'audioSettings.title');
			if(userMe.voiceJoined)
			{
				view.listenOnlyButton.visible = false;
				view.shareMicButton.visible=true;
				view.shareMicButton.label = ResourceManager.getInstance().getString('resources', userMe.voiceJoined ? 'audioSettings.shareMicrophone.off' : 'audioSettings.shareMicrophone.on');
			}
			else if(userMe.listenOnly)
			{
				view.listenOnlyButton.visible = true;
				view.shareMicButton.visible=false;
				view.listenOnlyButton.label = ResourceManager.getInstance().getString('resources', userMe.listenOnly ? 'audioSettings.listenOnly.off' : 'audioSettings.listenOnly.on');
			}
			else
			{
				view.listenOnlyButton.visible = true;
				view.shareMicButton.visible=true;
			}
		}
		
		private function onShareMicClick(event:MouseEvent):void
		{
			var audioOptions:Object = new Object();
			audioOptions.shareMic = userSession.userList.me.voiceJoined = !userSession.userList.me.voiceJoined;
			audioOptions.listenOnly = userSession.userList.me.listenOnly = false;
			shareMicrophoneSignal.dispatch(audioOptions);
			view.listenOnlyButton.visible = !userSession.userList.me.voiceJoined;

		}
		
		private function onListenOnlyClick(event:MouseEvent):void
		{
			var audioOptions:Object = new Object();
			audioOptions.listenOnly = userSession.userList.me.listenOnly = !userSession.userList.me.listenOnly;
			audioOptions.shareMic = userSession.userList.me.voiceJoined = false;
			shareMicrophoneSignal.dispatch(audioOptions);
			view.shareMicButton.visible = !userSession.userList.me.listenOnly;
		}
		
		private function userChangeHandler(user:User, type:int):void
		{
			if (user.me && type == UserList.JOIN_AUDIO) 
			{
				view.shareMicButton.label = ResourceManager.getInstance().getString('resources', user.voiceJoined ? 'audioSettings.shareMicrophone.off' : 'audioSettings.shareMicrophone.on');
			}
			else if(user.me && type == UserList.LISTEN_ONLY)
			{
				view.listenOnlyButton.label = ResourceManager.getInstance().getString('resources', user.listenOnly ? 'audioSettings.listenOnly.off' : 'audioSettings.listenOnly.on');
			}
		}	
		
		override public function destroy():void
		{
			super.destroy();
			view.shareMicButton.removeEventListener(MouseEvent.CLICK, onShareMicClick);
			view.listenOnlyButton.removeEventListener(MouseEvent.CLICK, onListenOnlyClick);
		}
	}
}