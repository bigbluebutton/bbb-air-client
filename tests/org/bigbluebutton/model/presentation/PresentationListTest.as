package org.bigbluebutton.model.presentation
{
	import flash.events.EventDispatcher;
	
	import mockolate.runner.MockolateRule;
	
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;
	
	public class PresentationListTest
	{		
		protected var instance:PresentationList;
		
		public var dispatcher:EventDispatcher = new EventDispatcher();
		
		[Before]
		public function setUp():void
		{
			instance = new PresentationList();
			var p:Presentation = instance.addPresentation("presentation name 1", 5, true);
			instance.currentPresentation = p;
			instance.addPresentation("presentation name 2", 10, false);
			instance.addPresentation("presentation name 3", 20, false);
		}
		
		/* PresentationList::addPresentation tests */
		
		[Test]
		public function addPresentation_createsAndAddsPresentationToPresentationList():void
		{
			instance.addPresentation("new presentation name", 15, false);
			
			var p:Presentation = instance.getPresentation("new presentation name");
			assertThat(p.fileName, equalTo("new presentation name"));
			assertThat(p.size(), equalTo(15));
			assertThat(p.current, equalTo(false));
		}
		
		/* PresentationList::removePresentation tests */
		
		[Test]
		public function removePresentation_invalidPresentationName_doesntBreak():void
		{
			instance.removePresentation("invalid name");
		}
		
		[Test]
		public function removePresentation_removesPresentationFromPresentationList():void
		{
			assertThat(instance.getPresentation("presentation name 1"), notNullValue());
			instance.removePresentation("presentation name 1");
			assertThat(instance.getPresentation("presentation name 1"), equalTo(null));
		}
		
		/* PresentationList::getPresentation tests */
		
		[Test]
		public function getPresentation_presentationInPresentationList_returnsPresentationReference():void
		{
			var p:Presentation = instance.getPresentation("presentation name 1");
			assertThat(p.fileName, equalTo("presentation name 1"));
			assertThat(p.size(), equalTo(5));
			assertThat(p.current, equalTo(true));
		}
		
		[Test]
		public function getPresentation_presentationNotInPresentationList_returnsNull():void
		{
			var p:Presentation = instance.getPresentation("invalid name");
			assertThat(p, equalTo(null));
		}
		
		/* PresentationList::currentPresentation tests */
		
		[Test (async)]
		public function currentPresentation_dispatcherPresentationChangeSignal():void
		{
			var p:Presentation = instance.getPresentation("presentation name 3");
			instance.presentationChangeSignal.add(presentationChangeSignalChecker);
			Async.proceedOnEvent(this, dispatcher, PresentationListTestHelperEvents.PRESENTATION_CHANGE_SIGNAL, 5000);
			instance.currentPresentation = p;
		}
		
		private function presentationChangeSignalChecker():void
		{
			dispatcher.dispatchEvent(new PresentationListTestHelperEvents(
										PresentationListTestHelperEvents.PRESENTATION_CHANGE_SIGNAL));
		}
		
		[Test]
		public function currentPresentation_setCurrentPresentation():void
		{
			var p:Presentation = instance.getPresentation("presentation name 3");
			instance.currentPresentation = p;
			assertThat(instance.currentPresentation, equalTo(p));
		}
		
		[Test]
		public function currentPresentation_togglesCurrentPropertyOfOldAndNewCurrentPresentations():void
		{
			assertThat(instance.getPresentation("presentation name 1").current, equalTo(true));
			var p:Presentation = instance.getPresentation("presentation name 2");
			instance.currentPresentation = p;
			assertThat(instance.getPresentation("presentation name 2").current, equalTo(true));
			assertThat(instance.getPresentation("presentation name 1").current, equalTo(false));
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
/*		[Test]
		public function instantiated_isInstanceOfPresentationList():void
		{
			assertTrue("instance is PresentationList", instance is PresentationList);
		}*/
	}
}