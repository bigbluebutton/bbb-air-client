package org.bigbluebutton.view.navigation.pages.participants
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.View;
	
	public class ParticipantsViewBaseTest
	{		
		protected var instance:ParticipantsViewBase;
		
		[Before]
		public function setUp():void
		{
			instance = new ParticipantsViewBase();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfParticipantsViewBase():void
		{
			assertTrue("instance is ParticipantsViewBase", instance is ParticipantsViewBase);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark View component", instance is View);
		}
	}
}
