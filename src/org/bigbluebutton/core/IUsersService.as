package org.bigbluebutton.core
{
	import org.bigbluebutton.model.User;

	public interface IUsersService
	{
		function connectUsers(uri:String):void;
		function connectListeners(uri:String):void;	
		function muteMe():void
		function unmuteMe():void
		function mute(user:User):void
		function unmute(user:User):void
		function addStream(userId:String, streamName:String):void
		function removeStream(userId:String, streamName:String):void
		function raiseHand(userID:String, raise:Boolean):void;
	}
}