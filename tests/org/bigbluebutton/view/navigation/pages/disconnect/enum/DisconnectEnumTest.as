package org.bigbluebutton.view.navigation.pages.disconnect.enum
{
	import org.flexunit.asserts.assertTrue;
	
	public class DisconnectEnumTest
	{		
		protected var instance:DisconnectEnum;
		
		[Before]
		public function setUp():void
		{
			instance = new DisconnectEnum();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfDisconnectEnum():void
		{
			assertTrue("instance is DisconnectEnum", instance is DisconnectEnum);
		}		
	}
}