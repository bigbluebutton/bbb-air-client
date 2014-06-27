package org.bigbluebutton.view.navigation.pages.userdetails
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.View;
	
	public class UserDetailsViewTest
	{		
		protected var instance:UserDetailsView;
		
		[Before]
		public function setUp():void
		{
			instance = new UserDetailsView();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfUserDetailsView():void
		{
			assertTrue("instance is UserDetailsView", instance is UserDetailsView);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark View component", instance is View);
		}
		
		[Test]
		public function instantiated_implementsIUserDetailsView():void
		{
			assertTrue("instance implements IUserDetailsView", instance is IUserDetailsView);
		}
	}
}