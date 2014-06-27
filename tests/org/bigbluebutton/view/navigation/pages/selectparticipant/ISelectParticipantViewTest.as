package org.bigbluebutton.view.navigation.pages.selectparticipant
{
	import org.flexunit.asserts.assertTrue;
	
	public class ISelectParticipantViewTest
	{		
		protected var instance:ISelectParticipantView;
		
		[Before]
		public function setUp():void
		{
			instance = new SelectParticipantView();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfSelectParticipantView():void
		{
			assertTrue("instance is SelectParticipantView", instance is SelectParticipantView);
		}
	}
}
