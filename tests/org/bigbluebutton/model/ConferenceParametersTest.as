package org.bigbluebutton.model
{
	import org.flexunit.asserts.assertTrue;

	public class ConferenceParametersTest
	{		
		protected var instance:ConferenceParameters;
		
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
		public function instantiated_isInstanceOfConferenceParameters():void
		{
			assertTrue("instance is ConferenceParameters", instance is ConferenceParameters);
		}
		
		[Test]
		public function instantiated_implementsIConferenceParametersInterface():void
		{
			assertTrue("instance implements IConferenceParameters interface", instance is IConferenceParameters);
		}
	}
}