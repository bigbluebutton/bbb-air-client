package 
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.isTrue;
	import org.mconf.mobile.command.TurnOffMicSignal;
	import org.mconf.mobile.command.TurnOnMicSignal;
	import org.mconf.mobile.testing.MediatorTests;
	import org.mconf.mobile.view.mic.api.IMicButton;
	import org.mconf.mobile.view.mic.mediator.MicButtonMediator;
	import org.mconf.mobile.view.navigation.api.ITopView;
	import org.mockito.integrations.flexunit4.MockitoRule;
	import org.mockito.integrations.given;
	import org.mockito.integrations.mock;
	import org.mockito.integrations.times;
	import org.mockito.integrations.verify;
	import org.osflash.signals.Signal;
	
	[Mock(type="org.mconf.mobile.command.TurnOnMicSignal")]
	[Mock(type="org.mconf.mobile.command.TurnOffMicSignal")]
	[Mock(type="robotlegs.bender.extensions.localEventMap.api.IEventMap")]
	public class MediatorTests extends MediatorTests
	{
		private var _micButton: IMicButton;
		
		[Rule]
		public var mockitoRule: MockitoRule = new MockitoRule();
		
		/**
		 * Tests that when the cancelSignal is dispatched to signify the user
		 * wishing to quit the todo form, the view is removed as a popup.
		 */
//		[Test]
//		public function cancelSignalDispatched_viewIsRemovedAsPopup(): void
//		{
//			var micButtonMediator: MicButtonMediator = createMediator();
//			simulateTurnOffMic();
//			verify(times(1)).that(micButtonMediator.popup.remove(_micButton));
//		}
		
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
		 * Tests that when the saveSignal on the view is dispatched the createNewTodoSignal
		 * is dispatched.
		 */
		[Test]
		public function saveSignalDispatched_TodoCollectionHasNoActive_ShouldDispatchCreateNewTodoSignal(): void
		{
			const expectedTaskDescription: String = "My dummy task.";
			
			var micButtonMediator: MicButtonMediator = createMediator();
//			simulateSave(expectedTaskDescription);
			
//			verify(times(1)).that(micButtonMediator.createNewTodoSignal.dispatch(expectedTaskDescription));
//			verify(never()).that(micButtonMediator.updateTodoSignal.dispatch(expectedTaskDescription));
		}
		
		/**
		 * Tests that when the saveSignal on the view is dispatched the view
		 * is removed as a popup in the UI.
		 */
		[Test]
		public function saveSignalDispatched_viewIsRemovedAsPopup(): void
		{
			var micButtonMediator: MicButtonMediator = createMediator();
//			simulateSave( "My dummy task.");
			
//			verify(times(1)).that(micButtonMediator.popup.remove(_micButton));
		}
		
		/**
		 * Tests that when the user wishes to save and the TodoCollection has an active Todo, the UpdateTodoSignal
		 * is dispatched.
		 */
		[Test]
		public function saveSignalDispatched_TodoCollectionHasActive_ShouldDispatchUpdateTodoSignal(): void
		{
//			const expectedTaskDescription: String = "My dummy task.";
			
//			var micButtonMediator: TemplateViewMediator = createMediator(new Todo());
//			simulateSave(expectedTaskDescription);
			
//			verify(times(1)).that(micButtonMediator.updateTodoSignal.dispatch(expectedTaskDescription));
//			verify(never()).that(micButtonMediator.createNewTodoSignal.dispatch(expectedTaskDescription));
		}
		
		/**
		 * Creates the test subject with its dependencies.
		 */
		private function createMediator(obj: * = null): MicButtonMediator
		{
			var micButtonMediator: MicButtonMediator = new MicButtonMediator();
			micButtonMediator.turnOnMicSignal = mock(TurnOnMicSignal);
			micButtonMediator.turnOffMicSignal = mock(TurnOffMicSignal);

//			given(micButtonMediator.todoCollection.activeTodo).willReturn(activeTodo);
			
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