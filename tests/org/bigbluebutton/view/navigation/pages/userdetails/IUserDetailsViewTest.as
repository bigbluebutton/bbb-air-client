package org.bigbluebutton.view.navigation.pages.userdetails
{
	import org.flexunit.asserts.assertTrue;
	
	public class IUserDetailsViewTest
	{		
		protected var instance:IUserDetailsView;
		
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
	}
}