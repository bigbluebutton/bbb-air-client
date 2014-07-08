package org.bigbluebutton
{
	import flash.events.Event;
	
	import mockolate.prepare;
	import mockolate.received;
	import mockolate.runner.MockolateRule;
	import mockolate.stub;
	
	import org.bigbluebutton.command.MicrophoneMuteSignal;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	
	import robotlegs.bender.extensions.commandCenter.dsl.ICommandMapper;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.extensions.mediatorMap.dsl.IMediatorMapper;
	import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IInjector;
	
	public class AppConfigTest
	{		
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		[Mock]
		public var injector:IInjector;
		
		[Mock]
		public var signalCommandMap:ISignalCommandMap;
		
		private static var TIMEOUT:Number = 5000;
		
		protected var instance:AppConfig;
		
		[Before(async)]
		public function setUp():void
		{
			Async.proceedOnEvent(this, prepare(IInjector, ISignalCommandMap), Event.COMPLETE, TIMEOUT, timeoutHandler);
			instance = new AppConfig();
			
			instance.injector = this.injector;
			instance.signalCommandMap = this.signalCommandMap;
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfAppConfig():void
		{
			assertTrue("instance is AppConfig", instance is AppConfig);
		}
		
		[Test]
		public function instantiated_implementsIConfigInterface():void
		{
			assertTrue("instance implements IConfig interface", instance is IConfig);
		}
		
		protected function timeoutHandler(passThroughData:Object):void
		{
			fail("Timeout occured during setUp() method");
		}
	}
}
