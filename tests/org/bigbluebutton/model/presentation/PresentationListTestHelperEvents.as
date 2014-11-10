package org.bigbluebutton.model.presentation
{
	import flash.events.Event;
	
	public class PresentationListTestHelperEvents extends Event
	{
		public static const PRESENTATION_CHANGE_SIGNAL:String = "PRESENTATION_CHANGE_SIGNAL";
		
		public function PresentationListTestHelperEvents(type:String):void
		{
			super(type);
		}
	}
}