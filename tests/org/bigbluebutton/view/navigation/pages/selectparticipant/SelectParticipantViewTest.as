package org.bigbluebutton.view.navigation.pages.selectparticipant
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.View;
	
	public class SelectParticipantViewTest
	{		
		protected var instance:SelectParticipantView;
		
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
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark View component", instance is View);
		}
		
		[Test]
		public function instantiated_implementsISelectParticipantView():void
		{
			assertTrue("instance implements ISelectParticipantView", instance is ISelectParticipantView);
		}
	}
}