package org.bigbluebutton.core
{
	import org.bigbluebutton.model.IMessageListener;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.polling.Poll;
	import org.bigbluebutton.model.polling.Question;
	import org.bigbluebutton.model.polling.Responder;
	import org.bigbluebutton.model.polling.Response;
	
	
	public class PollMessageReceiver implements IMessageListener
	{
		public var userSession:IUserSession;
		
		public function PollMessageReceiver(userSession:IUserSession) {
			this.userSession = userSession;
		}
		
		public function onMessage(messageName:String, message:Object):void {
			switch(messageName) {
				case "pollGetPollsReply":
					handleGetPollsReply(message);
					break;
				case "pollCreatedMessage":
					handlePollCreatedMessage(message);
					break;			
				case "pollUpdatedMessage":
					handlePollUpdatedMessage(message);
					break;
				case "pollDestroyedMessage":
					handlePollDestroyedMessage(message);
					break;
				case "pollStartedMessage":
					handlePollStartedMessage(message);
					break;
				case "pollStoppedMessage":
					handlePollStoppedMessage(message);
					break;
				case "pollResultUpdatedMessage":
					handlePollResultUpdatedMessage(message);
					break;
				default:
					break;
			}
		}
		
		private function handleGetPollsReply(m:Object):void {
			var polls:Array = JSON.parse(m.msg) as Array;
			trace("PollMessageReceiver::handleGetPollsReply() -- [" + polls.length + "] polls received from server");
			
			for(var i:int = 0; i < polls.length; i++) {
				userSession.pollModel.createPoll(buildPoll(polls[i]));
			}
		}
		
		private function handlePollCreatedMessage(m:Object):void {
			var poll:Object = JSON.parse(m.msg);
			trace("PollMessageReceiver::handlePollCreatedMessage() -- creating poll [" + poll.title + "]");
			userSession.pollModel.createPoll(buildPoll(poll));
		}
		
		private function handlePollUpdatedMessage(m:Object):void {
			var poll:Object = JSON.parse(m.msg);
			trace("PollMessageReceiver::handlePollUpdatedMessage() -- updating poll [" + poll.title + "]");
			if(userSession.pollModel.hasPoll(poll.id)) {
				userSession.pollModel.updatePoll(buildPoll(poll));
			}
		}
		
		private function handlePollDestroyedMessage(m:Object):void {
			var poll:Object = JSON.parse(m.msg);
			trace("PollMessageReceiver::handlePollDestroyedMessage() -- destroying poll [" + poll.title + "]");
			if(userSession.pollModel.hasPoll(poll.pollID)) {
				userSession.pollModel.destroyPoll(poll.pollID);
			}
		}
		
		private function handlePollStartedMessage(m:Object):void {
			var poll:Object = JSON.parse(m.msg);
			trace("PollMessageReceiver::handlePollStartedMessage() -- starting poll [" + poll.title + "]");
			if(userSession.pollModel.hasPoll(poll.pollID)) {
				userSession.pollModel.startPoll(poll.pollID);
			}
		}
		
		private function handlePollStoppedMessage(m:Object):void {
			var poll:Object = JSON.parse(m.msg);
			trace("PollMessageReceiver::handlePollStoppedMessage() -- stopping poll [" + poll.title + "]"); 
			if(userSession.pollModel.hasPoll(poll.pollID)) {
				userSession.pollModel.stopPoll(poll.pollID);
			}
		}
		
		private function handlePollResultUpdatedMessage(m:Object):void {
			var message:Object = JSON.parse(m.msg);
			
			/*** The format of 'message':
			 * {
			 * 		"response":
			 * 		{
			 * 			"pollID":"pollID-103",
			 * 			"responses":
			 * 				[
			 * 					{
			 * 						"questionID":"q1",
			 * 						"responseIDs":["0","1"]
			 * 					},
			 * 
			 * 					...
			 * 				]
			 * 		},
			 * 
			 * 		"responder":
			 * 		{
			 * 			"userID":"enfjadjc5xnn",
			 * 			"name":"RED"
			 * 		}
			 * }
			 */
			
			var response:Object = message.response;
			
			if(userSession.pollModel.hasPoll(response.pollID)) {
				var responses:Array = response.responses;
				var responder:Responder = buildResponder(message.responder);
				
				for(var i:int = 0; i < responses.length; i++) {
					var individualResponse:Object = responses[i];
					var responseIDs:Array = individualResponse.responseIDs;
					
					for(var j:int = 0; j < responseIDs.length; j++) {
						userSession.pollModel.updateResults(response.pollID, individualResponse.questionID, responseIDs[j], responder);
					}
				}
			}
		}
		
		private function buildPoll(pollObj:Object):Poll {
			trace("PollMessageReceiver::handleGetPollsReply() -- building poll [" + pollObj.title + "]");
			var questions:Array = pollObj.questions;
			var qs:Array = new Array();
			
			for(var i:int = 0; i < questions.length; i++) {
				qs.push(buildQuestion(questions[i]));
			}
			
			return new Poll(pollObj.id, pollObj.title, qs, pollObj.started, pollObj.stopped);
		}
		
		private function buildQuestion(questionObj:Object):Question {
			trace("PollMessageReceiver::buildQuestion() -- building question [" + questionObj.question + "]");
			var responses:Array = questionObj.responses;
			var rs:Array = new Array();
			
			for(var i:int = 0; i < responses.length; i++) {
				rs.push(buildResponse(responses[i]));
			}
			
			return new Question(questionObj.id, questionObj.multiResponse, questionObj.question, rs);
		}
		
		private function buildResponse(responseObj:Object):Response {
			trace("PollMessageReceiver::buildResponse -- building response [" + responseObj.text + "]");
			var responders:Array = responseObj.responders;
			var rs:Array = new Array();
			
			for(var i:int = 0; i < responders.length; i++) {
				rs.push(buildResponder(responders[i]));
			}
			
			return new Response(responseObj.id, responseObj.text, rs);
		}
		
		private function buildResponder(responderObj:Object):Responder {
			trace("PollMessageReceiver::buildResponder -- building responder for userID [" + responderObj.userID + "], name [" + responderObj.name + "]");
			return new Responder(responderObj.userID, responderObj.name);
		}
		
	}
}