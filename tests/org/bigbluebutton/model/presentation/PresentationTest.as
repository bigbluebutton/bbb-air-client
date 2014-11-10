package org.bigbluebutton.model.presentation
{
	import flash.events.EventDispatcher;
	
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;

	public class PresentationTest
	{		
		protected var instance:Presentation;
		
		public var dispatcher:EventDispatcher = new EventDispatcher();
		
		[Before]
		public function setUp():void
		{
			instance = new Presentation("PresentationName", fakeChangeCurrentPresentationCallback, 10, true);
			
			var s1:Slide = createSlide(1);
			s1.current = true;
			var s2:Slide = createSlide(2);
			var s3:Slide = createSlide(3);
			
			instance.add(s1);
			instance.add(s2);
			instance.add(s3);
		}
		
		/* Presentation::add tests */
		
		/* The slide numbers in the messages sent to the client uses a 1-base lists, whereas the vector in which the
		 * slides are stored uses 0-based lists. So the index in vector should be one less than the slide number. */
		[Test]
		public function add_slideAddedToSlideListWithIndexOneLessThatSlideNumber():void
		{
			var s4:Slide = createSlide(4);
			var s5:Slide = createSlide(5);
			var s6:Slide = createSlide(6);
			
			instance.add(s4);
			instance.add(s5);
			instance.add(s6);
			
			assertThat(instance.slides[3], equalTo(s4));
			assertThat(instance.slides[4], equalTo(s5));
			assertThat(instance.slides[5], equalTo(s6));
		}
		
		[Test]
		public function add_slideAddedIsCurrent_currentSlideNumFieldIsSet():void
		{
			var s4:Slide = createSlide(4);
			var s5:Slide = createSlide(5);
			var s6:Slide = createSlide(6);
			s5.current = true;
			
			instance.add(s4);
			instance.add(s5);
			instance.add(s6);
			
			assertThat(instance.currentSlideNum, equalTo(4)); /* Not 5 !! */ 
		}
		
		/* Presentation::getSlideAt tests */
		
		[Test]
		public function getSlideAt_returnsSlideAtThatIndex():void
		{
			assertThat(instance.getSlideAt(0).slideURI, equalTo("slideURI1"));
			assertThat(instance.getSlideAt(1).slideURI, equalTo("slideURI2"));
			assertThat(instance.getSlideAt(2).slideURI, equalTo("slideURI3"));
			
			var s4:Slide = createSlide(4);
			instance.add(s4);
			assertThat(instance.getSlideAt(3), equalTo(s4));
		}
		
		[Test]
		public function getSlideAt_calledWithOutOfBoundsNumber_returnsNull():void
		{
			assertThat(instance.getSlideAt(3), equalTo(null));
			assertThat(instance.getSlideAt(100), equalTo(null));
		}
		
		/* Presentation::show tests */
		
		[Test (async)]
		public function show_dispatchesSlideChangeSignal():void
		{
			instance.slideChangeSignal.add(slideChangeSignalDispatchedFromShowChecker);
			Async.proceedOnEvent(this, dispatcher, PresentationTestHelperEvents.SLIDE_CHANGE_SIGNAL_FROM_SHOW_CORRECT, 5000);
			instance.show();
		}
		
		private function slideChangeSignalDispatchedFromShowChecker():void
		{
			dispatcher.dispatchEvent(new PresentationTestHelperEvents(
										PresentationTestHelperEvents.SLIDE_CHANGE_SIGNAL_FROM_SHOW_CORRECT));
		}
		
		/* The callback is used to change presentations. The way the application is structured, it is a reference
		 * to PresentationList::changeCurrentPresentation, a wrapper for the PresentationList::currentPresentation
		 * setter. The reference to the function would normally be passed to the Presentation constructor by the
		 * PresentationList, which instantiates each Presentation. In this test, the reference passed is a reference
		 * to the 'fakeChangeCurrentPresentationCallback' helper defined below. */
		[Test (async)]
		public function show_invokesCallBackWithSelfAsArgument():void
		{
			Async.proceedOnEvent(this, dispatcher, PresentationTestHelperEvents.CHANGE_PRESENTATION_CALLBACK_CALLED, 5000);
			instance.show();
		}
		
		private function fakeChangeCurrentPresentationCallback(p:Presentation):void
		{
			assertThat(p, equalTo(instance));
			dispatcher.dispatchEvent(new PresentationTestHelperEvents(
										PresentationTestHelperEvents.CHANGE_PRESENTATION_CALLBACK_CALLED));
		}
		
		/* Presentation::currentSlideNum tests */
		
		[Test (async)]
		public function currentSlideNum_dispatchesSlideChangeSignal():void
		{
			instance.slideChangeSignal.add(slideChangeSignalDispatchedFromCurrentSlideNumChecker);
			Async.proceedOnEvent(this, dispatcher,
						PresentationTestHelperEvents.SLIDE_CHANGE_SIGNAL_FROM_CURRENT_SLIDE_NUM_CORRECT, 5000);
			
			instance.currentSlideNum = 3;
		}
		
		private function slideChangeSignalDispatchedFromCurrentSlideNumChecker():void
		{
			dispatcher.dispatchEvent(new PresentationTestHelperEvents(
										PresentationTestHelperEvents.SLIDE_CHANGE_SIGNAL_FROM_CURRENT_SLIDE_NUM_CORRECT));
		}
		
		/* The slide numbers in the messages sent to the client uses a 1-base lists, whereas the vector in which the
		 * slides are stored uses 0-based lists. So the 'Presentation' class's field that stores this number should be
		 * one less than the actual slide number. */
		[Test]
		public function currentSlideNum_setsCurrentSlideNumber():void
		{
			instance.currentSlideNum = 3;
			assertThat(instance.currentSlideNum, equalTo(2));
			instance.currentSlideNum = 1;
			assertThat(instance.currentSlideNum, equalTo(0));
		}
		
		[Test]
		public function currentSlideNum_togglesCurrentPropertyOfOldAndNewCurrentSlides():void
		{
			instance.currentSlideNum = 3;
			assertThat(instance.currentSlideNum, equalTo(2));
			
			instance.currentSlideNum = 1;
			/* Make sure old current slides 'current' field is set back to false: */
			assertThat(instance.getSlideAt(2).current, equalTo(false));
		}
		
		/* helpers */
		
		private function createSlide(slideNumber:Number):Slide
		{
			return new Slide(slideNumber, "slideURI" + slideNumber,
							"thumbURI" + slideNumber, "txtURI" + slideNumber, false);
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
/*		[Test]
		public function instantiated_isInstanceOfPresentation():void
		{
			assertTrue("instance is Presentation", instance is Presentation);
		}*/
	}
}