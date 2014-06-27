package org.bigbluebutton.view.navigation.pages.participants
{
	import flash.events.Event;
	
	import mockolate.prepare;
	import mockolate.runner.MockolateRule;
	
	import org.bigbluebutton.model.User;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	
	import spark.components.supportClasses.ItemRenderer;
	
	public class ParticipantItemRendererTest
	{		
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		private static var TIMEOUT:Number = 5000;
		
		[Mock]
		public var user:User;
		
		protected var instance:ParticipantItemRenderer;
		
		[Before(async)]
		public function setUp():void
		{
			Async.proceedOnEvent(this, prepare(User), Event.COMPLETE, TIMEOUT, timeoutHandler)
			instance = new ParticipantItemRenderer();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfParticipantItemRenderer():void
		{
			assertTrue("instance is ParticipantItemRenderer", instance is ParticipantItemRenderer);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark ItemRenderer component", instance is ItemRenderer);
		}
		
		[Test]
		public function setDataMethodCalledWhenUserIsNull_LabelTextIsEmpty():void
		{
			// Arrange
			user = null;
			
			// Act
			instance.data = user;
			
			// Assert
			assertTrue("If User object is null, ParticipantItemRenderer's labelDisplay text property should be empty", instance.labelDisplay.text == ""); 
		}
		
		protected function timeoutHandler(passThroughData:Object):void
		{
			fail("Timeout occured during setUp() method");
		}
	}
}
