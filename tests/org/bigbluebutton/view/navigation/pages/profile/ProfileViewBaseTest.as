package org.bigbluebutton.view.navigation.pages.profile
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.View;
	
	public class ProfileViewBaseTest
	{		
		protected var instance:ProfileViewBase;
		
		[Before]
		public function setUp():void
		{
			instance = new ProfileViewBase();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfProfileViewBase():void
		{
			assertTrue("instance is ProfileViewBase", instance is ProfileViewBase);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark View component", instance is View);
		}
	}
}