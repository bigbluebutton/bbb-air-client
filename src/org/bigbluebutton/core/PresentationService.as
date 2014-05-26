package org.bigbluebutton.core
{
	import org.bigbluebutton.model.IConferenceParameters;
	import org.bigbluebutton.model.IMessageListener;
	import org.bigbluebutton.model.IUserSession;

	public class PresentationService implements IPresentationService
	{
		[Inject]
		public var presentMessageSender:IPresentMessageSender;
		
		[Inject]
		public var presentMessageReceiver : IPresentMessageReceiver;
		
		[Inject]
		public var conferenceParameters: IConferenceParameters;
		
		[Inject]
		public var userSession: IUserSession;
		
		public function PresentationService() {
			
		}
		
		public function setupMessageReceiver():void {
			userSession.mainConnection.addMessageListener(presentMessageReceiver as IMessageListener);
		}
		
		public function getPresentationInfo():void {
			presentMessageSender.getPresentationInfo();
		}

		public function gotoSlide(id:String):void {
			presentMessageSender.gotoSlide(id);
		}
		
		public function move(xOffset:Number, yOffset:Number, widthRatio:Number, heightRatio:Number):void {
			presentMessageSender.move(xOffset, yOffset, widthRatio, heightRatio);
		}
		
		public function removePresentation(name:String):void {
			presentMessageSender.removePresentation(name);
		}
		
		public function sendCursorUpdate(xPercent:Number, yPercent:Number):void {
			presentMessageSender.sendCursorUpdate(xPercent, yPercent);
		}
		
		public function sharePresentation(share:Boolean, presentationName:String):void {
			presentMessageSender.sharePresentation(share, presentationName);
		}
	}
}