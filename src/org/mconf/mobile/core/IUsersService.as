package org.mconf.mobile.core
{
	public interface IUsersService
	{
		function connectUsers(uri:String):void;
		function connectListeners(uri:String):void;	
		function muteMe():void
		function unmuteMe():void
		function mute(userId:String):void
		function unmute(userId:String):void
	}
}