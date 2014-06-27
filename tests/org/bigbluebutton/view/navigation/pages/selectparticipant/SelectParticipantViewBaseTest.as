package org.bigbluebutton.view.navigation.pages.selectparticipant
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.View;
	
	public class SelectParticipantViewBaseTest
	{		
		protected var instance:SelectParticipantViewBase;
		
		[Before]
		public function setUp():void
		{
			instance = new SelectParticipantViewBase();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfSelectParticipantViewBase():void
		{
			assertTrue("instance is SelectParticipantViewBase", instance is SelectParticipantViewBase);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark View component", instance is View);
		}
	}
}