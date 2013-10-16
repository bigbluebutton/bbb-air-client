package org.mconf.mobile.template.mediator
{
	import flash.display.DisplayObject;
	
	import org.mconf.mobile.template.signal.ActionSignal;
	import org.mconf.mobile.template.view.api.ITopView;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class TopViewMediator extends Mediator
	{
		[Inject]
		public var actionSignal: ActionSignal;
		
//		[Inject]
//		public var updateTodoSignal: UpdateTodoSignal;
		
//		[Inject]
//		public var todoCollection: ITodoCollection;
		
//		[Inject]
//		public var popup: IPopup;
		
		[Inject]
		public var view: ITopView;
		
		override public function initialize():void
		{
//			view.cancelSignal.add(cancel);
//			view.saveSignal.add(save);
			
//			setTaskDescription();
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			view.dispose();
			
//			popup = null;
//			view = null;
		}
		
		/**
		 * Cancels the adding or modifying of 
		 * a todo.
		 */
		private function cancel(): void
		{
//			remove();
		}
		
		/**
		 * Removes the form from the view.
		 */
		private function remove(): void
		{
//			popup.remove(view);
		}
		
		/**
		 * Saves the entered task to the todo
		 * list.
		 */
		private function save(): void
		{
//			if (todoCollection.activeTodo != null)
//				updateTodoSignal.dispatch(view.taskDescription);
//			else
//				createNewTodoSignal.dispatch(view.taskDescription);
			
//			remove();
		}
		
		/**
		 * Sets the task description on the view if the user
		 * is modifying a todo item.
		 */
		private function setTaskDescription(): void
		{
//			if (todoCollection.activeTodo)
//				view.taskDescription = todoCollection.activeTodo.task;
		}
	}
}