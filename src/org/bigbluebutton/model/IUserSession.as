package org.bigbluebutton.model
{
	import flash.net.NetConnection;
	
	import org.bigbluebutton.core.IBigBlueButtonConnection;
	import org.bigbluebutton.core.IDeskshareConnection;
	import org.bigbluebutton.core.IVideoConnection;
	import org.bigbluebutton.core.IVoiceConnection;
	import org.bigbluebutton.core.VideoConnection;
	import org.bigbluebutton.core.VoiceConnection;
	import org.bigbluebutton.core.VoiceStreamManager;
	import org.bigbluebutton.model.chat.ChatMessages;
	import org.bigbluebutton.model.polling.PollModel;
	import org.bigbluebutton.model.presentation.PresentationList;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	

	public interface IUserSession
	{
		function get config():Config;
		function set config(value:Config):void;
		function get userId():String;
		function set userId(value:String):void;		
		function get userList():UserList;
		function get voiceConnection():IVoiceConnection;
		function set voiceConnection(value:IVoiceConnection):void;
		function get mainConnection():IBigBlueButtonConnection;
		function set mainConnection(value:IBigBlueButtonConnection):void;
		function get voiceStreamManager():VoiceStreamManager;
		function set voiceStreamManager(value:VoiceStreamManager):void;
		function get videoConnection():IVideoConnection;
		function set videoConnection(value:IVideoConnection):void;
		function get deskshareConnection():IDeskshareConnection;
		function set deskshareConnection(value:IDeskshareConnection):void;
		function get presentationList():PresentationList;
		function get pollModel():PollModel;
		function get guestSignal():ISignal;
		function get successJoiningMeetingSignal():ISignal;
		function get unsuccessJoiningMeetingSignal():ISignal;
		function get logoutSignal():Signal;
		function get recordingStatusChangedSignal():ISignal;
		function joinMeetingResponse(msg:Object):void;
		function recordingStatusChanged(recording:Boolean):void;
	}
}