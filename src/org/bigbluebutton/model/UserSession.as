package org.bigbluebutton.model
{
	import flash.media.CameraPosition;
	import flash.net.NetConnection;
	
	import mx.collections.ArrayList;
	
	import org.bigbluebutton.command.MicrophoneMuteSignal;
	import org.bigbluebutton.command.ShareCameraSignal;
	import org.bigbluebutton.core.IBigBlueButtonConnection;
	import org.bigbluebutton.core.IDeskshareConnection;
	import org.bigbluebutton.core.IVideoConnection;
	import org.bigbluebutton.core.IVoiceConnection;
	import org.bigbluebutton.core.VoiceConnection;
	import org.bigbluebutton.core.VoiceStreamManager;
	import org.bigbluebutton.model.LockSettings;
	import org.bigbluebutton.model.chat.ChatMessages;
	import org.bigbluebutton.model.presentation.PresentationList;
	import org.hamcrest.core.throws;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	public class UserSession implements IUserSession
	{
		protected var _config:Config;
		protected var _userId:String;
		protected var _mainConnection:IBigBlueButtonConnection;
		protected var _voiceConnection:IVoiceConnection;
		protected var _voiceStreamManager:VoiceStreamManager;
		protected var _videoConnection:IVideoConnection;
		protected var _deskshareConnection:IDeskshareConnection;
		protected var _userList:UserList;
		protected var _presentationList:PresentationList;
		protected var _recording:Boolean;
		protected var _lockSettings:LockSettings;
		
		protected var _guestSignal:ISignal = new Signal();
		protected var _successJoiningMeetingSignal:ISignal = new Signal();
		protected var _unsuccessJoiningMeetingSignal:ISignal = new Signal();
		protected var _recordingStatusChangedSignal:ISignal = new Signal();
		protected var _logoutSignal:Signal = new Signal();
		protected var _applyViewerLockSettingsSignal:Signal = new Signal();
		protected var _applyPresenterModeratorLockSettingsSignal:Signal = new Signal();
		
		[Inject]
		public var microphoneMuteSignal:MicrophoneMuteSignal;
		
		[Inject]
		public var shareCameraSignal:ShareCameraSignal;

		public function get userList():UserList
		{
			return _userList;
		}

		public function get config():Config
		{
			return _config;
		}
		
		public function set config(value:Config):void
		{
			_config = value;
		}

		public function get userId():String
		{
			return _userId;
		}

		public function set userId(value:String):void
		{
			_userId = value;
			_userList.me.userID = value;
		}

		public function get voiceConnection():IVoiceConnection
		{
			return _voiceConnection;
		}

		public function set voiceConnection(value:IVoiceConnection):void
		{
			_voiceConnection = value;
		}

		public function get mainConnection():IBigBlueButtonConnection
		{
			return _mainConnection;
		}

		public function set mainConnection(value:IBigBlueButtonConnection):void
		{
			_mainConnection = value;  
		}

		public function get voiceStreamManager():VoiceStreamManager
		{
			return _voiceStreamManager;
		}

		public function set voiceStreamManager(value:VoiceStreamManager):void
		{
			_voiceStreamManager = value;
		}

		public function get videoConnection():IVideoConnection
		{
			return _videoConnection;
		}

		public function set videoConnection(value:IVideoConnection):void
		{
			_videoConnection = value;
		}
		
		public function get deskshareConnection():IDeskshareConnection
		{
			return _deskshareConnection;
		}
		
		public function set deskshareConnection(value:IDeskshareConnection):void
		{
			_deskshareConnection = value;
		}

		public function UserSession()
		{
			_userList = new UserList();
			_presentationList = new PresentationList();
		}
		
		public function get presentationList():PresentationList
		{
			return _presentationList
		}
		
		public function get guestSignal():ISignal
		{
			return _guestSignal;
		}
		
		public function get successJoiningMeetingSignal():ISignal
		{
			return _successJoiningMeetingSignal;
		}
		
		public function get unsuccessJoiningMeetingSignal():ISignal
		{
			return _unsuccessJoiningMeetingSignal;
		}
		
		public function joinMeetingResponse(msg:Object):void {
			if(msg.user) {
				_successJoiningMeetingSignal.dispatch();
			}
			else {
				_unsuccessJoiningMeetingSignal.dispatch();
			}
		}
		
		public function get logoutSignal():Signal {
			return _logoutSignal;
		}
		
		public function get recordingStatusChangedSignal():ISignal {
			return _recordingStatusChangedSignal;
		}
		
		public function get applyViewerLockSettingsSignal():ISignal
		{
			return _applyViewerLockSettingsSignal;
		}
		
		public function get applyPresenterModeratorLockSettingsSignal():ISignal
		{
			return _applyPresenterModeratorLockSettingsSignal;
		}
		
		public function recordingStatusChanged(recording:Boolean):void {
			_recording = recording;
			recordingStatusChangedSignal.dispatch(recording);
		}
		
		public function initializeLockSettings():void
		{
			var lock:Object = config.lock;
			
			// If the lock element of config exists, make sure the appropriate lock settings
			// attributes exist. If they don't set the corresponding value of the lock settings to false.
			// If the lock element of config does not exist, use default lock settings with everything
			// set to false...
			
			if(lock != null)
			{
				
				_lockSettings = new LockSettings(
					lock.hasOwnProperty("@disableCamForLockedUsers") ? lock.@disableCam == "true" : false,
					lock.hasOwnProperty("@disableMicForLockedUsers") ? lock.@disableMic == "true" : false,
					lock.hasOwnProperty("@disablePrivateChatForLockedUsers") ? lock.@disablePrivateChat == "true" : false,
					lock.hasOwnProperty("@disablePublicChatForLockedUsers") ? lock.@disablePublicChat == "true" : false,
					lock.hasOwnProperty("@lockLayoutForLockedUsers") ? lock.@lockLayoutForLockedUsers == "true" : false
				);
				
			}
			else
			{
				_lockSettings = new LockSettings(false, false, false, false, false);
			}
			
			userList.applyLockSettingsToUsers(_lockSettings);
			applyMyLockState();
		}
		
		public function set lockSettings(value:LockSettings):void
		{
			_lockSettings = value;
			userList.applyLockSettingsToUsers(_lockSettings);
			applyMyLockState();
		}
		
		public function get lockSettings():LockSettings
		{
			return _lockSettings;
		}
		
		public function applyMyLockState():void
		{
			var me:User = userList.me;
			
			if(!(me.role == User.MODERATOR || me.presenter))
			{
				if(me.disableMyCam && me.hasStream)
				{
					shareCameraSignal.dispatch(false, videoConnection.cameraPosition);
					// shareCameraSignal.dispatch(false, CameraPosition.FRONT);
					// shareCameraSignal.dispatch(false, CameraPosition.BACK);
				}
				if(me.disableMyMic && me.voiceJoined && !me.muted)
				{
					microphoneMuteSignal.dispatch(me);
				}
				applyViewerLockSettingsSignal.dispatch();
			}
			else  // I am a presenter or moderator
			{
				applyPresenterModeratorLockSettingsSignal.dispatch();
			}
		}
		
	}
}