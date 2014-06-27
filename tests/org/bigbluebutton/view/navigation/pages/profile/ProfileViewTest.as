package org.bigbluebutton.view.navigation.pages.profile
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.View;
	
	public class ProfileViewTest
	{		
		protected var instance:ProfileView;
		
		[Before]
		public function setUp():void
		{
			instance = new ProfileView();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfProfileView():void
		{
			assertTrue("instance is ProfileView", instance is ProfileView);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark View component", instance is View);
		}
		
		[Test]
		public function instantiated_implementsIProfileView():void
		{
			assertTrue("instance implements IProfileView", instance is IProfileView);
		}
	}
}