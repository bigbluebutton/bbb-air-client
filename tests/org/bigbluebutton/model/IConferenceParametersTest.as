package org.bigbluebutton.model
{
	import org.flexunit.asserts.assertTrue;

	public class IConferenceParametersTest
	{		
		protected var instance:IConferenceParameters;
		
		[Before]
		public function setUp():void
		{
			instance = new ConferenceParameters();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfIConferenceParameters():void
		{
			assertTrue("instance is IConferenceParameters", instance is IConferenceParameters);
		}
	}
}