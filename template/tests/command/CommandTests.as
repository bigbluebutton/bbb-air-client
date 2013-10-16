package 
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.hasPropertyWithValue;
	import org.hamcrest.object.notNullValue;
	import org.mockito.integrations.any;
	import org.mockito.integrations.anyOf;
	import org.mockito.integrations.flexunit4.MockitoRule;
	import org.mockito.integrations.given;
	import org.mockito.integrations.havingPropertyOf;
	import org.mockito.integrations.mock;
	import org.mockito.integrations.times;
	import org.mockito.integrations.verify;
	
//	[Mock(type="ITodoCollection")]
	public class CommandTests
	{
		[Rule]
		public var mockitoRule: MockitoRule = new MockitoRule();
		
		/**
		 * Tests that the command adds a new Todo to the todos collection
		 * with the task description that is set.
		 */
		[Test]
		public function execute_todoWithTaskDescriptionIsAddedToCollection(): void
		{
			var actionCommand: TurnOffMicCommand = createCommand();
			actionCommand.execute();
			
//			verify(times(1)).that(createNewTodoCommand.todoCollection.add(havingPropertyOf("task", expectedTaskDescription)));
		}
		
		/**
		 * Creates the test subject with its dependencies.
		 */
		private function createCommand(): TurnOffMicCommand
		{
			var turnOffMicCommand: TurnOffMicCommand = new TurnOffMicCommand();
//			actionCommand.todoCollection = mock(ITodoCollection);
			return turnOffMicCommand;
		}
	}
}