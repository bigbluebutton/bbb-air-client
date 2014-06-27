package org.bigbluebutton.view.navigation.pages.disconnect.enum
{
	import org.flexunit.asserts.assertTrue;
	
	public class DisconnectTypeTest
	{		
		protected var instance:DisconnectType;
		
		[Before]
		public function setUp():void
		{
			instance = new DisconnectType();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfDisconnectType():void
		{
			assertTrue("instance is DisconnectType", instance is DisconnectType);
		}		
	}
}