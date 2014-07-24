package org.bigbluebutton.view.ui
{
	import org.bigbluebutton.model.IUserSession;
	
	import robotlegs.bender.bundles.mvcs.Mediator;

	public class RecordingStatusMediator extends Mediator
	{
		[Inject]
		public var userSession:IUserSession;
		
		[Inject]
		public var view:IRecordingStatus;
		
		override public function initialize():void
		{
			userSession.recordingStatusChangedSignal.add(setRecordingStatus);
		}
		
		public function setRecordingStatus(recording:Boolean):void
		{
			view.setVisibility(recording);
		}
		
		override public function destroy():void
		{
			userSession.recordingStatusChangedSignal.remove(setRecordingStatus);
		}
		
	}
}