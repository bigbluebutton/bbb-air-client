package org.bigbluebutton.core
{
	import org.bigbluebutton.model.IMessageListener;

	public class PresentMessageReceiver implements IPresentMessageReceiver, IMessageListener
	{
		public function PresentMessageReceiver()
		{
		}
		
		public function onMessage(messageName:String, message:Object):void {
			switch (messageName) {
				case "PresentationCursorUpdateCommand":
					handlePresentationCursorUpdateCommand(message);
					break;			
				default:
			}
		}  
		
		private function handlePresentationCursorUpdateCommand(message:Object):void {
			trace("cursorUpdateCommand received");
			/*
			var e:CursorEvent = new CursorEvent(CursorEvent.UPDATE_CURSOR);
			e.xPercent = message.xPercent;
			e.yPercent = message.yPercent;
			var dispatcher:Dispatcher = new Dispatcher();
			dispatcher.dispatchEvent(e);
			*/
		}
	}
}