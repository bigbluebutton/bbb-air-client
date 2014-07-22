package org.bigbluebutton.core
{
	import org.bigbluebutton.model.IMessageListener;
	import org.bigbluebutton.model.IUserSession;
	
	public class PollService implements IPollService
	{
		[Inject]
		public var userSession: IUserSession;
		
		public var pollMessageSender:PollMessageSender;
		public var pollMessageReceiver:PollMessageReceiver;
		
		public function PollService() {
			
		}
		
		public function setupMessageSenderReceiver():void {
			pollMessageSender = new PollMessageSender(userSession);
			pollMessageReceiver = new PollMessageReceiver(userSession);
			
			userSession.mainConnection.addMessageListener(pollMessageReceiver as IMessageListener);
		}
		
		public function getPolls():void { 
			pollMessageSender.getPolls();
		}
		
		public function respondPoll(pollID:String, responses:Array):void {
			pollMessageSender.respondPoll(pollID, responses);
		}
		
	}
}