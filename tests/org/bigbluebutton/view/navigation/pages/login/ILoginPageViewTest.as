package org.bigbluebutton.view.navigation.pages.login
{
	import org.flexunit.asserts.assertTrue;
	
	public class ILoginPageViewTest
	{		
		protected var instance:ILoginPageView;
		
		[Before]
		public function setUp():void
		{
			instance = new LoginPageView();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfLoginPageView():void
		{
			assertTrue("instance is LoginPageView", instance is LoginPageView);
		}
	}
}