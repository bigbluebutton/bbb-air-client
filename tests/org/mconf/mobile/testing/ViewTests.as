package org.bigbluebutton.testing
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;
	
	import org.fluint.uiImpersonation.UIImpersonator;
	
	import spark.components.Button;
	import spark.components.TextArea;

	public class ViewTests
	{
		/**
		 * Adds a UIComponent to a mock of the display list.
		 */
		protected function addToUI(view: UIComponent): void
		{
			UIImpersonator.addChild(view);
		}
		
		/**
		 * Generic teardown for each test.
		 */
		public function after(): void
		{
			UIImpersonator.removeAllChildren();
		}
		
		/**
		 * Mimics the user clicking a button.
		 */
		protected function click(button: IEventDispatcher): void
		{
			button.dispatchEvent(new MouseEvent(MouseEvent.CLICK));	
		}

		/**
		 * Dummy method used to test signals.
		 */
		protected function dummyMethod(): void { }
		
		/**
		 * Updates thats text of a TextArea and dispatches its change event.
		 */
		protected function updateText(textArea: TextArea, updateTextTo: String): void
		{
			textArea.text = updateTextTo;
			textArea.dispatchEvent(new Event(Event.CHANGE));
		}
	}
}