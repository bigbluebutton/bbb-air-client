package org.bigbluebutton.view.navigation.pages.login
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.View;
	
	public class LoginPageViewBaseTest
	{		
		protected var instance:LoginPageViewBase;
		
		[Before]
		public function setUp():void
		{
			instance = new LoginPageViewBase();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfLoginPageViewBase():void
		{
			assertTrue("instance is LoginPageViewBase", instance is LoginPageViewBase);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark View component", instance is View);
		}
	}
}