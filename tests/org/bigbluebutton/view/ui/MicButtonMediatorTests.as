package org.bigbluebutton.view.ui
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.isTrue;
	import org.bigbluebutton.command.MicrophoneEnableSignal;
	import org.bigbluebutton.testing.MediatorTests;
	import org.mockito.integrations.flexunit4.MockitoRule;
	import org.mockito.integrations.given;
	import org.mockito.integrations.mock;
	import org.mockito.integrations.times;
	import org.mockito.integrations.verify;
	import org.osflash.signals.Signal;
	
	[Mock(type="org.bigbluebutton.command.TurnOnMicSignal")]
	[Mock(type="org.bigbluebutton.command.TurnOffMicSignal")]
	[Mock(type="org.bigbluebutton.view.mic.api.IMicButton")]
	[Mock(type="robotlegs.bender.extensions.localEventMap.api.IEventMap")]
	public class MicButtonMediatorTests extends MediatorTests
	{
		private var _micButton: IMicButton;
		
		[Rule]
		public var mockitoRule: MockitoRule = new MockitoRule();
		
		/**
		 * Tests when the mediator is destroyed the
		 * view is disposed of.
		 */
		[Test]
		public function destory_ViewIsDisposed(): void
		{
			var micButtonMediator: MicButtonMediator = createMediator();
			micButtonMediator.destroy();
			verify(times(1)).that(_micButton.dispose());
		}
		
		/**
		 * Tests when the mediator is destory the dependencies
		 * are nullified.
		 */
		[Test]
		public function destory_NullifiesDependencies(): void
		{
			var micButtonMediator: MicButtonMediator = createMediator();
			micButtonMediator.destroy();
			assertThat(!micButtonMediator.view, isTrue()); 
		}
		
		/**
		 * Creates the test subject with its dependencies.
		 */
		private function createMediator(obj: * = null): MicButtonMediator
		{
			var micButtonMediator: MicButtonMediator = new MicButtonMediator();
			micButtonMediator.view = createMockOfMicButton();
			micButtonMediator.microphoneEnableSignal = mock(MicrophoneEnableSignal);

			//given(micButtonMediator.view.turnOffMicSignal).willReturn(activeTodo);
			
			setupMediator(micButtonMediator);
			
			micButtonMediator.initialize();
			
			return micButtonMediator;
		}
		
		/**
		 * Creates a mock of the TodoFormView with its signals set.
		 */
		private function createMockOfMicButton(): IMicButton
		{
			_micButton = mock(IMicButton);
			given(_micButton.turnOffMicSignal).willReturn(new Signal());
			given(_micButton.turnOnMicSignal).willReturn(new Signal());
			return _micButton;
		}
		
		/**
		 * Simulates the user wanting to cancel the todo form.
		 */
		private function simulateTurnOffMic(): void
		{
			(_micButton.turnOffMicSignal as Signal).dispatch();
		}
		
		/**
		 * Simulates the user wanting to cancel the todo form.
		 */
		private function simulateTurnOnMic(): void
		{
			(_micButton.turnOnMicSignal as Signal).dispatch();
		}
	}
}