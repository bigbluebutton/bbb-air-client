package org.bigbluebutton.command
{
	import flashx.textLayout.debug.assert;
	
	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;
	import org.hamcrest.object.equalTo;
	import org.bigbluebutton.model.IUserSettings;
	import org.bigbluebutton.view.ui.IMicButton;
	import org.bigbluebutton.view.ui.MicButton;
	import org.mockito.integrations.flexunit4.MockitoRule;
	import org.mockito.integrations.havingPropertyOf;
	import org.mockito.integrations.mock;
	import org.mockito.integrations.times;
	import org.mockito.integrations.verify;
	
	[Mock(type="org.bigbluebutton.model.IUserSettings")]
	public class MicrophoneEnableCommandTests
	{
		[Rule]
		public var mockitoRule: MockitoRule = new MockitoRule();
		
		/**
		 * Tests that the command microphoneEnabledOff really change/mantain the variable "selected" in the button false 
		 */
		[Test]
		public function execute_microphoneEnabledOffAndCheckSelectedProperty(): void
		{
			var micButton:MicButton = new MicButton();
			
			var command: MicrophoneOnCommand = createCommand();
			command.enabled = false;
			command.execute();
						
			assertFalse(micButton.selected);
		}
		
		/**
		 * Tests that the command microphoneEnabledOff really change the visual in the button to desabled
		 */
		[Test]
		public function execute_microphoneEnabledOffAndCheckSelectedState(): void
		{
			var micButton:MicButton = new MicButton();
			
			var command: MicrophoneOnCommand = createCommand();
			command.enabled = false;
			command.execute();
			
			assertThat(micButton.currentState, equalTo("unselected"));
		}
		
		/**
		 * Tests that the command microphoneEnabledOn really change the variable "selected" in the button 
		 */
		[Test]
		public function execute_microphoneEnabledOnAndCheckSelectedProperty(): void
		{
			var micButton:MicButton = new MicButton();
			
			var command: MicrophoneOnCommand = createCommand();
			command.enabled = true;
			command.execute();
			
			assertTrue(micButton.selected);
		}
		
		/**
		 * Tests that the command microphoneEnabledOn really change the visual in the button 
		 */
		[Test]
		public function execute_microphoneEnabledOnAndCheckSelectedState(): void
		{
			var micButton:MicButton = new MicButton();
			
			var command: MicrophoneOnCommand = createCommand();
			command.enabled = true;
			command.execute();
			
			assertThat(micButton.currentState, equalTo("selected"));
		}
		
		/**
		 * Tests that the command to enable after the disable works 
		 */
		[Test]
		public function execute_microphoneEnabledOnThenOffAndCheckIfOff(): void
		{
			var micButton:MicButton = new MicButton();
			
			var command: MicrophoneOnCommand = createCommand();
			command.enabled = true;
			command.execute();
			
			var command1: MicrophoneOnCommand = createCommand();
			command1.enabled = false;
			command1.execute();
			
			assertFalse(micButton.selected);
		}
		
		/**
		 * Tests that the command to enable after the disable works 
		 */
		[Test]
		public function execute_microphoneEnabledOffThenOnAndCheckIfOn(): void
		{
			var micButton:MicButton = new MicButton();
			
			var command: MicrophoneOnCommand = createCommand();
			command.enabled = false;
			command.execute();
			
			var command1: MicrophoneOnCommand = createCommand();
			command1.enabled = true;
			command1.execute();
			
			assertTrue(micButton.selected);
		}
		
		/**
		 * Creates the test subject with its dependencies.
		 */
		private function createCommand(): MicrophoneOnCommand
		{
			var command: MicrophoneOnCommand = new MicrophoneOnCommand();
			command.userSettings = mock(IUserSettings);
			return command;
		}
	}
}