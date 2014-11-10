package org.bigbluebutton.model.presentation
{
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	
	public class SlideTest
	{		
		protected var instance:Slide;
		
		public var dispatcher:EventDispatcher = new EventDispatcher();
		
		[Before]
		public function setUp():void
		{
			// TODO : Provide valid constructor parameters relevant to the test
			instance = new Slide(1, "testSlideURI", "testThumbURI", "testTxtURI", true);
		}
		
		/* Slide::data tests */
		
		[Test (async)]
		public function data_dispatchesSlideLoadedSignal():void
		{
			var b:ByteArray = new ByteArray();
			instance.slideLoadedSignal.add(slideLoadedSignalFromDataChecker);
			Async.proceedOnEvent(this, dispatcher, SlideTestHelperEvents.SLIDE_LOADED_SIGNAL_CORRECT_DATA, 5000);
			instance.data = b;
		}
		
		private function slideLoadedSignalFromDataChecker():void
		{
			dispatcher.dispatchEvent(new SlideTestHelperEvents(SlideTestHelperEvents.SLIDE_LOADED_SIGNAL_CORRECT_DATA));
		}
		
		[Test]
		public function data_setsLoadedToTrue():void
		{
			var b:ByteArray = new ByteArray();
			instance.data = b;
			assertThat(instance.loaded, equalTo(true));
		}
		
		/* Slide::swfSource tests */
		
		[Test (async)]
		public function swfSource_dispatchesSlideLoadedSignal():void
		{
			var o:Object = new Object();
			instance.slideLoadedSignal.add(slideLoadedSignalFromSwfSourceChecker);
			Async.proceedOnEvent(this, dispatcher, SlideTestHelperEvents.SLIDE_LOADED_SIGNAL_CORRECT_SWFSOURCE, 5000);
			instance.swfSource = o;
		}
		
		private function slideLoadedSignalFromSwfSourceChecker():void
		{
			dispatcher.dispatchEvent(new SlideTestHelperEvents(SlideTestHelperEvents.SLIDE_LOADED_SIGNAL_CORRECT_SWFSOURCE));
		}
		
		[Test]
		public function swfSource_setsSWFFileSource():void
		{
			var o:Object = new Object;
			instance.swfSource = o;
			assertThat(instance.SWFFile.source, equalTo(o));
		}
		
		[Test]
		public function swfSource_setsLoadedToTrue():void
		{
			var o:Object = new Object;
			instance.swfSource = o;
			assertThat(instance.loaded, equalTo(true));
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
/*		[Test]
		public function instantiated_isInstanceOfSlide():void
		{
			assertTrue("instance is Slide", instance is Slide);
		}*/
	}
}