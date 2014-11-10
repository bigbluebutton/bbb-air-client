package org.bigbluebutton.model.presentation
{
	import flash.events.Event;
	
	public class PresentationTestHelperEvents extends Event
	{
		public static const CHANGE_PRESENTATION_CALLBACK_CALLED:String = "CHANGE_PRESENTATION_CALLBACK_CALLED";
		public static const SLIDE_CHANGE_SIGNAL_FROM_SHOW_CORRECT:String = "SLIDE_CHANGE_SIGNAL_FROM_SHOW_CORRECT";
		public static const SLIDE_CHANGE_SIGNAL_FROM_CURRENT_SLIDE_NUM_CORRECT:String = "SLIDE_CHANGE_SIGNAL_FROM_CURRENT_SLIDE_NUM_CORRECT";
		
		public function PresentationTestHelperEvents(type:String):void
		{
			super(type);
		}
	}
}