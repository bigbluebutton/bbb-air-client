package org.bigbluebutton.core
{
	public interface IUsersService
	{
		function connectUsers(uri:String):void;
		function connectListeners(uri:String):void;	
		function muteMe():void
		function unmuteMe():void
		function mute(userId:String):void
		function unmute(userId:String):void
		function addStream(userId:String, streamName:String):void
		function removeStream(userId:String, streamName:String):void
	}
}