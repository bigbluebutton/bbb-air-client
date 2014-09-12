package org.bigbluebutton.core
{
	import org.bigbluebutton.model.IUserSession;
	
	public class PollMessageSender
	{
		public var userSession:IUserSession;
		
		// The default callbacks of userSession.mainconnection.sendMessage
		private var defaultSuccessResponse:Function = function(result:String):void { trace(result); };
		private var defaultFailureResponse:Function = function(status:String):void { trace(status); };
		
		public function PollMessageSender(userSession:IUserSession) {
			this.userSession = userSession;
		}
		
		public function getPolls():void {
			trace("PollMessageSender::getPolls() -- Sending [poll.getPolls] message to server");
			userSession.mainConnection.sendMessage("poll.getPolls", defaultSuccessResponse, defaultFailureResponse);
		}
		
		public function respondPoll(pollID:String, responses:Array):void {
			var messageObject:Object = new Object();
			messageObject["pollID"] = pollID;			
			messageObject["questions"] = responses;
			
			var message:String = JSON.stringify(messageObject);
			trace("PollMessageSender::getPolls() -- Sending [poll.respondPoll] message to server with message: " + message);
			
			userSession.mainConnection.sendMessage("poll.respondPoll", defaultSuccessResponse, defaultFailureResponse, message);
		}
	}
}