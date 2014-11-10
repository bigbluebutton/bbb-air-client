package org.bigbluebutton.model.presentation
{
	import flash.events.Event;
	
	public class SlideTestHelperEvents extends Event
	{
		public static const SLIDE_LOADED_SIGNAL_CORRECT_DATA:String = "SLIDE_LOADED_SIGNAL_CORRECT_DATA";
		public static const SLIDE_LOADED_SIGNAL_CORRECT_SWFSOURCE:String = "SLIDE_LOADED_SIGNAL_CORRECT_SWFSOURCE";
		
		public function SlideTestHelperEvents(type:String):void
		{
			super(type);
		}
	}
}