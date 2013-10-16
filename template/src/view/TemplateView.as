package org.mconf.mobile.template.view
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.utils.StringUtil;
	
	import org.mconf.mobile.template.view.api.ITopView;
	import org.mconf.mobile.template.view.ui.TemplateViewBase;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	public class TopView extends TemplateViewBase implements ITopView
	{
		private var _actionSignal: Signal = new Signal();
		
		/**
		 * Dispatched when the user wants to cancel the
		 * adding or modifying of a todo item.
		 */
		public function get actionSignal(): ISignal
		{
			return _actionSignal;
		}
		
		/**
		 * Handles the cancelButton being clicked by the
		 * user by dispatching the cancelSignal.
		 */
		private function action(e: MouseEvent): void
		{
			_actionSignal.dispatch();
		}

		/**
		 * Description of a task entered by the user.
		 */
		public function get taskDescription(): String
		{
//			return (taskDescriptionTextArea) ? taskDescriptionTextArea.text : null;
		}
		
		public function set taskDescription(value: String): void
		{
//			taskDescriptionTextArea.text = value;
//			validate();
		}
		
		override protected function childrenCreated():void
		{
			super.childrenCreated();
			
//			cancelButton.addEventListener(MouseEvent.CLICK, cancel);
//			saveButton.addEventListener(MouseEvent.CLICK, save);
//			taskDescriptionTextArea.addEventListener(Event.CHANGE, validate);
		}

		
		public function dispose():void
		{
			_actionSignal.removeAll();
			
//			cancelButton.removeEventListener(MouseEvent.CLICK, cancel);
//			saveButton.removeEventListener(MouseEvent.CLICK, save);
//			taskDescriptionTextArea.removeEventListener(Event.CHANGE, validate);
		}
		
		/**
		 * Validates the task description, if it is deemed valid,
		 * then the save button is enabled, otherwise it is disabled.
		 */
		private function validate(e: Event = null): void
		{
//			saveButton.enabled = (taskDescription != null && StringUtil.trim(taskDescription) != "");
		}
	}
}