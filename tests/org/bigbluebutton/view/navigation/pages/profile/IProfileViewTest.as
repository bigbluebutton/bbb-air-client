package org.bigbluebutton.view.navigation.pages.profile
{
	import org.flexunit.asserts.assertTrue;
	
	public class IProfileViewTest
	{		
		protected var instance:IProfileView;
		
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
	}
}