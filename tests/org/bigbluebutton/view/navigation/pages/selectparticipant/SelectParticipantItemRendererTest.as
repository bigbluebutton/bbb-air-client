package org.bigbluebutton.view.navigation.pages.selectparticipant
{
	import flash.events.Event;
	
	import mockolate.prepare;
	import mockolate.runner.MockolateRule;
	
	import org.bigbluebutton.model.User;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	
	import spark.components.supportClasses.ItemRenderer;
	
	public class SelectParticipantItemRendererTest
	{		
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		private static var TIMEOUT:Number = 5000;
		
		[Mock]
		public var user:User;
		
		protected var instance:SelectParticipantItemRenderer;
		
		[Before(async)]
		public function setUp():void
		{
			Async.proceedOnEvent(this, prepare(User), Event.COMPLETE, TIMEOUT, timeoutHandler)
			instance = new SelectParticipantItemRenderer();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfSelectParticipantItemRenderer():void
		{
			assertTrue("instance is SelectParticipantItemRenderer", instance is SelectParticipantItemRenderer);
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
			assertTrue("If User object is null, SelectParticipantItemRenderer's labelDisplay text property should be empty", instance.labelDisplay.text == ""); 
		}
		
		protected function timeoutHandler(passThroughData:Object):void
		{
			fail("Timeout occured during setUp() method");
		}
	}
}
