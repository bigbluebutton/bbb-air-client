package org.bigbluebutton.view.navigation.pages.login
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.View;
	
	public class LoginPageViewTest
	{		
		protected var instance:LoginPageView;
		
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
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark View component", instance is View);
		}
		
		[Test]
		public function instantiated_implementsILoginPageView():void
		{
			assertTrue("instance implements ILoginPageView", instance is ILoginPageView);
		}
	}
}