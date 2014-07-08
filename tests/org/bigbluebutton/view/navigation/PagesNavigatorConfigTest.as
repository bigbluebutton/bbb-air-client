package org.bigbluebutton.view.navigation
{
	import flash.events.Event;
	
	import mockolate.prepare;
	import mockolate.received;
	import mockolate.runner.MockolateRule;
	import mockolate.stub;
	
	import org.bigbluebutton.command.JoinMeetingSignal;
	import org.bigbluebutton.command.RaiseHandSignal;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.osflash.signals.Signal;
	
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandMapper;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.extensions.mediatorMap.dsl.IMediatorMapper;
	import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IInjector;
	
	public class PagesNavigatorConfigTest
	{		
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		[Mock]
		public var injector:IInjector;
		
		[Mock]
		public var mediatorMap:IMediatorMap;
		
		[Mock]
		public var mediatorMapper:IMediatorMapper;
		
		[Mock]
		public var signalCommandMap:ISignalCommandMap;
		
		[Mock]
		public var commandMapper:ICommandMapper;
		
		private static var TIMEOUT:Number = 5000;
		
		protected var instance:PagesNavigatorConfig;
		
		[Before(async)]
		public function setUp():void
		{
			Async.proceedOnEvent(this, prepare(IInjector, IMediatorMap, ISignalCommandMap, IMediatorMapper, ICommandMapper), Event.COMPLETE, TIMEOUT, timeoutHandler);
			instance = new PagesNavigatorConfig();
			
			instance.injector = this.injector;
			instance.mediatorMap = this.mediatorMap;
			instance.signalCommandMap = this.signalCommandMap;
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfPagesNavigatorConfig():void
		{
			assertTrue("instance is PagesNavigatorConfig", instance is PagesNavigatorConfig);
		}
		
		[Test]
		public function instantiated_implementsIConfigInterface():void
		{
			assertTrue("instance implements IConfig interface", instance is IConfig);
		}
		
		[Test]
		public function executed_callsMediatorMapMapMethod():void
		{	
			// Arrange
			stub(instance.mediatorMap).method("map").args(IPagesNavigatorView).returns(mediatorMapper);
			stub(instance.signalCommandMap).method("map").args(JoinMeetingSignal).returns(commandMapper);
			
			// Act
			instance.configure();
			
			// Assert
			assertThat(instance.mediatorMap, received().method('map'));
		}
		
		[Test]
		public function executed_callsMediatorMapperToMediatorMethod():void
		{	
			// Arrange
			stub(instance.mediatorMap).method("map").args(IPagesNavigatorView).returns(mediatorMapper);
			stub(instance.signalCommandMap).method("map").args(JoinMeetingSignal).returns(commandMapper);
			
			// Act
			instance.configure();
			
			// Assert
			assertThat(mediatorMapper, received().method('toMediator'));
		}
		
		[Test]
		public function executed_callsSignalCommandMapMapMethod():void
		{	
			// Arrange
			stub(instance.mediatorMap).method("map").args(IPagesNavigatorView).returns(mediatorMapper);
			stub(instance.signalCommandMap).method("map").args(JoinMeetingSignal).returns(commandMapper);
			
			
			// Act
			instance.configure();
			
			// Assert
			assertThat(instance.signalCommandMap, received().method('map'));
		}
		
		[Test]
		public function executed_callsCommandMapperToCommandMethod():void
		{	
			// Arrange
			stub(instance.mediatorMap).method("map").args(IPagesNavigatorView).returns(mediatorMapper);
			stub(instance.signalCommandMap).method("map").args(JoinMeetingSignal).returns(commandMapper);
			
			// Act
			instance.configure();
			
			// Assert
			assertThat(commandMapper, received().method('toCommand'));
		}
		
		protected function timeoutHandler(passThroughData:Object):void
		{
			fail("Timeout occured during setUp() method");
		}	
	}
}