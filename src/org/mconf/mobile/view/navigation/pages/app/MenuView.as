package org.mconf.mobile.view.navigation.pages.app
{
	import flash.events.MouseEvent;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	public class MenuView extends MenuViewBase implements IMenuView
	{
		
/*		private var _buttonTestSignal: Signal = new Signal();
		
		/**
		 * Dispatched when the user wants to cancel the
		 * adding or modifying of a todo item.
		 *
		public function get buttonTestSignal(): ISignal
		{
			return _buttonTestSignal;
		}
*/
		
		override protected function childrenCreated():void
		{
			super.childrenCreated();
			
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		public function onClick(e:MouseEvent):void
		{
//			buttonTestSignal.dispatch();
		}

		public function dispose():void
		{
			
		}
	}
}