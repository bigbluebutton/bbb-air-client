package org.mconf.mobile.view.ui
{
	import org.mconf.mobile.command.MicrophoneEnableCommand;
	import org.mconf.mobile.command.MicrophoneEnableSignal;
	
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IInjector;


	public class MicButtonConfig implements IConfig
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
			mediatorMap.map(IMicButton).toMediator(MicButtonMediator);
		}
		
		/**
		 * Maps signals to commands using the signalCommandMap.
		 */
		private function signals(): void
		{
			signalCommandMap.map(MicrophoneEnableSignal).toCommand(MicrophoneEnableCommand);
		}	
	}
}