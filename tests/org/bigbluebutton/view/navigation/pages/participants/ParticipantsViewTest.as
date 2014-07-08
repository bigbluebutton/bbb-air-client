package org.bigbluebutton.view.navigation.pages.participants
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.View;
	
	public class ParticipantsViewTest
	{		
		protected var instance:ParticipantsView;
		
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
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark View component", instance is View);
		}
		
		[Test]
		public function instantiated_implementsIParticipantsView():void
		{
			assertTrue("instance implements IParticipantsView", instance is IParticipantsView);
		}
	}
}