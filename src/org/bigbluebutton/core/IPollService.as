package org.bigbluebutton.core
{
	import org.bigbluebutton.model.polling.Responses;
	
	public interface IPollService
	{
		function setupMessageSenderReceiver():void;
		function getPolls():void;
		function respondPoll(pollID:String, responses:Array):void;
	}
}