package org.bigbluebutton.view.navigation.pages.pollresults
{
	import mx.core.FlexGlobals;
	import mx.resources.ResourceManager;
	
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.IUserUISession;
	import org.bigbluebutton.model.polling.PollModel;
	import org.bigbluebutton.model.polling.Question;
	import org.bigbluebutton.model.polling.Response;
	import org.bigbluebutton.view.navigation.pages.PagesENUM;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import spark.components.Group;
	
	public class PollResultsViewMediator extends Mediator
	{
		[Inject]
		public var userSession:IUserSession;
		
		[Inject]
		public var userUISession: IUserUISession;
		
		[Inject]
		public var view:IPollResultsView;
		
		private var id:String;
		
		override public function initialize():void {
			id = userUISession.currentPageDetails.id;
			
			userSession.pollModel.responseToPollSignal.add(handleResponseToPoll);
			userSession.pollModel.pollsChangedSignal.add(handlePollModelChanged);
			
			FlexGlobals.topLevelApplication.pageName.text = ResourceManager.getInstance().getString('resources', 'pollResults.title');
			
			addPollResults();
		}
		
		private function addPollResults():void {
			var questions:Array = userSession.pollModel.getPoll(id).questions;
			
			for(var i:int = 0; i < questions.length; i++) {
				var question:Question = questions[i];
				var responseListView:ResponseListView = new ResponseListView();
				
				responseListView.initialize();
				responseListView.id = question.id;
				responseListView.question.text = question.question;
				
				var responses:Array = question.responses;
				
				for(var j:int = 0; j < responses.length; j++) {
					var response:Response = responses[j];
					var responseView:ResponseView = new ResponseView();
					
					responseView.initialize();
					responseView.id = response.id;
					responseView.response.text = response.response;
					responseView.numberOfResponses.text = response.numResponses.toString();
					
					responseListView.responsesList.addElement(responseView);
				}
				view.resultsList.addElement(responseListView);
			}
		}
		
		private function handleResponseToPoll(pollID:String, questionID:String, responseID:String): void {
			if(id == pollID) {
				var responseListView:ResponseListView = getResponseListView(questionID);
				if(responseListView) {
					var responsesList:Group = responseListView.responsesList;
					for(var i:int = 0; i < responsesList.numElements; i++) {
						var responseView:ResponseView = responsesList.getElementAt(i) as ResponseView;
						if(responseView && responseID == responseView.id) {
							var temp:Number = Number(responseView.numberOfResponses.text);
							temp++;
							responseView.numberOfResponses.text = temp.toString();
						}
					}
				}
			}
		}
		
		private function getResponseListView(questionID:String):ResponseListView {
			var resultsList:Group = view.resultsList;
			for(var i:int = 0; i < resultsList.numElements; i++) {
				var responseListView:ResponseListView = resultsList.getElementAt(i) as ResponseListView;
				if(responseListView && questionID == responseListView.id) {
					return responseListView;
				}
			}
			return null;
		}
		
		private function handlePollModelChanged(change:int, pollID:String):void {
			if(change == PollModel.POLL_DESTROYED && id == pollID) {
				userUISession.pushPage(PagesENUM.POLLS_LIST);
			}
		}
		
		override public function destroy():void {
			super.destroy();
			
			userSession.pollModel.responseToPollSignal.remove(handleResponseToPoll);
			userSession.pollModel.pollsChangedSignal.remove(handlePollModelChanged);
			
			view.dispose();
			view = null;
		}
		
	}
}