package org.mconf.mobile.view.navigation.pages.app
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.utils.StringUtil;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	public class TopView extends TopViewBase implements IMainNavigatorView
	{
		
		private var _buttonTestSignal: Signal = new Signal();
		
		/**
		 * Dispatched when the user wants to cancel the
		 * adding or modifying of a todo item.
		 */
		public function get buttonTestSignal(): ISignal
		{
			return _buttonTestSignal;
		}
		
		override protected function childrenCreated():void
		{
			super.childrenCreated();
			
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		public function onClick(e:MouseEvent):void
		{
			buttonTestSignal.dispatch();
		}

		public function dispose():void
		{
			
		}
	}
}