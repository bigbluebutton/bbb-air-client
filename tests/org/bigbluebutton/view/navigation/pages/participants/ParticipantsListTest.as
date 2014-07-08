package org.bigbluebutton.view.navigation.pages.participants
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.List;
	
	public class ParticipantsListTest
	{		
		protected var instance:ParticipantsList;
		
		[Before]
		public function setUp():void
		{
			instance = new ParticipantsList();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfParticipantsList():void
		{
			assertTrue("instance is ParticipantsList", instance is ParticipantsList);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark List component", instance is List);
		}
	}
}