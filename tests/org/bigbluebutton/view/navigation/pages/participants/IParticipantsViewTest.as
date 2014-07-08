package org.bigbluebutton.view.navigation.pages.participants
{
	import org.flexunit.asserts.assertTrue;
	
	public class IParticipantsViewTest
	{		
		protected var instance:IParticipantsView;
		
		[Before]
		public function setUp():void
		{
			instance = new ParticipantsView();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfParticipantsView():void
		{
			assertTrue("instance is ParticipantsView", instance is ParticipantsView);
		}
	}
}