package org.bigbluebutton.view.navigation.pages.selectparticipant
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.List;
	
	public class SelectParticipantListTest
	{		
		protected var instance:SelectParticipantList;
		
		[Before]
		public function setUp():void
		{
			instance = new SelectParticipantList();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfSelectParticipantList():void
		{
			assertTrue("instance is SelectParticipantList", instance is SelectParticipantList);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark List component", instance is List);
		}
	}
}