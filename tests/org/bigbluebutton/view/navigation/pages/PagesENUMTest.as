package org.bigbluebutton.view.navigation.pages
{
	import org.flexunit.asserts.assertTrue;
	
	public class PagesENUMTest
	{		
		protected var instance:PagesENUM;
		
		[Before]
		public function setUp():void
		{
			instance = new PagesENUM();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfPagesENUM():void
		{
			assertTrue("instance is PagesENUM", instance is PagesENUM);
		}		
	}
}
