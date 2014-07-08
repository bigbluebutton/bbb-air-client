package org.bigbluebutton.view.navigation.pages.userdetails
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.View;
	
	public class UserDetailsViewBaseTest
	{		
		protected var instance:UserDetailsViewBase;
		
		[Before]
		public function setUp():void
		{
			instance = new UserDetailsViewBase();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfUserDetailsViewBase():void
		{
			assertTrue("instance is UserDetailsViewBase", instance is UserDetailsViewBase);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark View component", instance is View);
		}
	}
}
