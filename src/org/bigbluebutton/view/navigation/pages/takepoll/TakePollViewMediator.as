package org.bigbluebutton.view.navigation.pages.takepoll
{	
	
	import flash.events.MouseEvent;
	
	import mx.core.FlexGlobals;
	import mx.resources.ResourceManager;
	
	import org.bigbluebutton.core.IPollService;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.IUserUISession;
	import org.bigbluebutton.model.polling.Poll;
	import org.bigbluebutton.model.polling.PollModel;
	import org.bigbluebutton.model.polling.Question;
	import org.bigbluebutton.model.polling.Responses;
	import org.bigbluebutton.view.navigation.pages.PagesENUM;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import spark.components.CheckBox;
	import spark.components.Group;
	import spark.components.RadioButton;
	
	
	public class TakePollViewMediator extends Mediator
	{
		[Inject]
		public var userSession:IUserSession;
		
		[Inject]
		public var userUISession: IUserUISession;
		
		[Inject]
		public var pollService:IPollService;
		
		[Inject]
		public var view:ITakePollView;
		
		private var id:String;
		private var questionViewGroup:Group;
		
		override public function initialize():void {			
			id = userUISession.currentPageDetails.id
			questionViewGroup = view.questionViews;
			
			userSession.pollModel.pollsChangedSignal.add(handlePollModelChanged);
			view.submitButton.addEventListener(MouseEvent.CLICK, onSubmit);
			
			FlexGlobals.topLevelApplication.pageName.text = ResourceManager.getInstance().getString('resources', 'takePoll.title');
			
			addPollToView(userSession.pollModel.getPoll(id));			
		}
		
		private function addPollToView(poll:Poll):void {
			var questions:Array = poll.questions;
			
			for(var i:int = 0; i < questions.length; i++) {
				var question:Question = questions[i];
				addQuestionToView(question.id, question.question, question.multiResponse, question.responses);
			}
		}
		
		private function addQuestionToView(questionID:String, questionText:String, multiResponse:Boolean, responses:Array):void {
			var qv:QuestionView = new QuestionView();
			
			qv.initialize();
			qv.id = questionID;
			qv.question.text = questionText;
			qv.multiResponse = multiResponse;
			
			if(multiResponse) {
				for(var i:int = 0; i < responses.length; i++) {
					qv.responses.addElement(buildCheckBoxFromResponse(responses[i]));
				}
			}
			else {
				for(var j:int = 0; j < responses.length; j++) {
					qv.responses.addElement(buildRadioButtonFromResponse(responses[j]));
				}
			}
			
			questionViewGroup.addElement(qv);
		}
		
		private function buildCheckBoxFromResponse(response:Object):CheckBox {
			var checkBox:CheckBox = new CheckBox();
			checkBox.id = response.id;
			checkBox.label = response.response;
			checkBox.percentWidth = 100;
			return checkBox;
		}
		
		private function buildRadioButtonFromResponse(response:Object):RadioButton {
			var radioButton:RadioButton = new RadioButton();
			radioButton.id = response.id;
			radioButton.label = response.response;
			radioButton.percentWidth = 100;
			return radioButton;
		}
		
		private function onSubmit(event:MouseEvent):void {
			var questionResponseArray:Array = new Array();
			
			for(var i:int = 0; i < questionViewGroup.numElements; i++) {
				var q:QuestionView = questionViewGroup.getElementAt(i) as QuestionView;
				
				if(q) {
					if(q.multiResponse) {
						var cb_responses:Array = getCheckBoxResponses(q.responses);
						if(cb_responses.length == 0) { // User did not respond
							view.errorMessage.visible = true;
							return;
						}
						questionResponseArray.push(new Responses(q.id, cb_responses));
					}
					else {
						var rb_responses:Array = getRadioButtonResponses(q.responses);
						if(rb_responses.length == 0) { // User did not respond
							view.errorMessage.visible = true;
							return;
						}
						questionResponseArray.push(new Responses(q.id, rb_responses));
					}
				}
			}
			
			view.submitButton.enabled = false;
			pollService.respondPoll(id, questionResponseArray);
			userSession.pollModel.userHasResponded(id);
		}
		
		private function getCheckBoxResponses(groupOfCheckBoxes:Group):Array {
			var responses:Array = new Array();
			
			for(var j:int = 0; j < groupOfCheckBoxes.numElements; j++) {
				var cb:CheckBox = groupOfCheckBoxes.getElementAt(j) as CheckBox;
				if(cb && cb.selected) {
					responses.push(cb.id);
				}
			}
			
			return responses;
		}
		
		private function getRadioButtonResponses(groupOfRadioButton:Group):Array {
			var responses:Array = new Array();
			
			for(var i:int = 0; i < groupOfRadioButton.numElements; i++) {
				var rb:RadioButton = groupOfRadioButton.getElementAt(i) as RadioButton;
				if(rb && rb.selected) {
					responses.push(rb.id);
				}
			}
			
			return responses;
		}
		
		private function handlePollModelChanged(change:int, pollID:String):void {
			switch(change) {
				case PollModel.POLL_DESTROYED:
					handlePollDestroyed(pollID);
					break;
				case PollModel.POLL_STOPPED:
					handlePollStopped(pollID);
					break;
				case PollModel.POLL_UPDATED:
					handlePollUpdated(pollID);
					break;
				case PollModel.I_RESPONDED_TO_POLL:
					handleIRespondedToPoll(pollID);
					break;
				default:
					break;
			}
		}
		
		private function handlePollDestroyed(pollID:String):void {
			if(id == pollID) {
				userUISession.popPage();
			}
		}
		
		private function handlePollStopped(pollID:String):void {
			if(id == pollID) {
				userUISession.popPage();
			}			
		}
		
		private function handlePollUpdated(pollID:String):void {
			if(id == pollID) {
				questionViewGroup.removeAllElements();
				addPollToView(userSession.pollModel.getPoll(pollID));
			}			
		}
		
		private function handleIRespondedToPoll(pollID:String):void {
			if(id == pollID) {
				userUISession.pushPage(PagesENUM.POLL_RESULTS, {id: id});
			}			
		}
		
		override public function destroy():void {
			super.destroy();
			
			userSession.pollModel.pollsChangedSignal.remove(handlePollModelChanged);
			view.submitButton.removeEventListener(MouseEvent.CLICK, onSubmit);
			
			view.dispose();
			view = null;
		}
		
	}
}