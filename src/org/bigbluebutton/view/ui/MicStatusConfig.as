package org.bigbluebutton.view.ui
{
	import org.bigbluebutton.command.MicrophoneEnableCommand;
	import org.bigbluebutton.command.MicrophoneEnableSignal;
	import org.bigbluebutton.command.MicrophoneOnCommand;
	import org.bigbluebutton.command.MicrophoneOnSignal;
	
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IInjector;


	public class MicStatusConfig implements IConfig
	{
		[Inject]
		public var injector: IInjector;
		
		[Inject]
		public var mediatorMap: IMediatorMap;
		
		[Inject]
		public var signalCommandMap: ISignalCommandMap;
		
		public function configure(): void
		{
			dependencies();
			mediators();
			signals();
		}
		
		/**
		 * Specifies all the dependencies for the feature
		 * that will be injected onto objects used by the
		 * application.
		 */
		private function dependencies(): void
		{
			 
		}
		
		/**
		 * Maps view mediators to views.
		 */
		private function mediators(): void
		{
			mediatorMap.map(IMicStatus).toMediator(MicStatusMediator);
		}
		
		/**
		 * Maps signals to commands using the signalCommandMap.
		 */
		private function signals(): void
		{

		}	
	}
}