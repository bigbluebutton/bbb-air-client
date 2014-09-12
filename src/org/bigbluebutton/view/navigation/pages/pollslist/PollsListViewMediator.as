package org.bigbluebutton.view.navigation.pages.pollslist
{
	import mx.collections.ArrayCollection;
	import mx.core.FlexGlobals;
	import mx.resources.ResourceManager;
	
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.IUserUISession;
	import org.bigbluebutton.model.polling.PollModel;
	import org.bigbluebutton.view.navigation.pages.PagesENUM;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import spark.components.List;
	import spark.events.IndexChangeEvent;
	
	
	public class PollsListViewMediator extends Mediator
	{
		[Inject]
		public var userSession:IUserSession;
		
		[Inject]
		public var userUISession: IUserUISession;
		
		[Inject]
		public var view:IPollsListView;
		
		private var pollsList:List;
		
		private var dataProvider:ArrayCollection = new ArrayCollection();
		
		override public function initialize():void {
			dataProvider = userSession.pollModel.Polls;
			
			pollsList = view.list;
			pollsList.dataProvider = dataProvider;
			
			userSession.pollModel.pollsChangedSignal.add(handlePollModelChanged);
			pollsList.addEventListener(IndexChangeEvent.CHANGE, onIndexChangeHandler);
			
			FlexGlobals.topLevelApplication.pageName.text = ResourceManager.getInstance().getString('resources', 'pollsList.title');
		}
		
		private function onIndexChangeHandler(event:IndexChangeEvent):void {
			var item:Object = dataProvider.getItemAt(event.newIndex);
			if(item) {
				if(!item.started) {
					return;
				}
				else if(item.stopped || item.hasResponded) {
					userUISession.pushPage(PagesENUM.POLL_RESULTS, item)
				}
				else {
					userUISession.pushPage(PagesENUM.TAKE_POLL, item);
				}
			}
		}
		
		private function handlePollModelChanged(change:int, pollID:String):void {
			switch(change) {
				case PollModel.POLL_CREATED:
				case PollModel.POLL_DESTROYED:
				case PollModel.POLL_STARTED:
				case PollModel.POLL_STOPPED:
				case PollModel.I_RESPONDED_TO_POLL:
					dataProvider.refresh();
					break;
				default:
					break;
			}
		}
		
		override public function destroy():void {
			super.destroy();
			
			pollsList.removeEventListener(IndexChangeEvent.CHANGE, onIndexChangeHandler);
			userSession.pollModel.pollsChangedSignal.remove(handlePollModelChanged);
			
			view.dispose();
			view = null;
		}
		
	}
}