package org.bigbluebutton.view.navigation.pages.common
{	
	import mx.core.FlexGlobals;
	
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.IUserUISession;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class MenuButtonsViewMediator extends Mediator
	{
		[Inject]
		public var userSession:IUserSession;
		
		[Inject]
		public var userUISession: IUserUISession;
		
		[Inject]
		public var view:MenuButtonsView;
		
		public override function initialize():void
		{	
			userUISession.loadingSignal.add(loadingFinished);
			
		}
		private function loadingFinished(loading:Boolean):void
		{
			if (!loading)
			{
				userUISession.loadingSignal.remove(loadingFinished);
				view.menuDeskshareButton.visible = view.menuDeskshareButton.includeInLayout = userSession.deskshareConnection.isStreaming;
				userSession.deskshareConnection.isStreamingSignal.add(onDeskshareStreamChange);
				userSession.pollModel.pollsChangedSignal.add(onPollChange);
			}
		}
		
		public function onPollChange(change:int, pollID:String):void
		{
			view.menuPollsButton.visible = view.menuPollsButton.includeInLayout = true;
		}
		
		/**
		 * If we recieve signal that deskshare stream is on - include Deskshare button to the layout
		 */ 
		public function onDeskshareStreamChange(isDeskshareStreaming:Boolean):void
		{
			view.menuDeskshareButton.visible = view.menuDeskshareButton.includeInLayout = isDeskshareStreaming;
		}
		
		/**
		 * Unsubscribe from listening for Deskshare Streaming Signal
		 */
		public override function destroy():void
		{
			userSession.deskshareConnection.isStreamingSignal.remove(onDeskshareStreamChange);
		}
	}
}