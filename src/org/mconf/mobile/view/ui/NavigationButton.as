package org.mconf.mobile.view.ui
{
	import flash.events.MouseEvent;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	public class NavigationButton extends NavigationButtonBase implements INavigationButton
	{
		private var _navigationSignal: Signal = new Signal();
		
		/**
		 * Dispatched when the user wants to navigato to a different page.
		 */
		public function get navigationSignal(): ISignal
		{
			return _navigationSignal;
		}
		
		public function NavigationButton()
		{
			super();
		}
		
		override protected function childrenCreated():void
		{
			super.childrenCreated();
			
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		protected function onClick(e:MouseEvent):void
		{
			_navigationSignal.dispatch();
		}		
		
		public function dispose():void
		{
			_navigationSignal.removeAll();
			
			this.removeEventListener(MouseEvent.CLICK, onClick);
		}
		
		protected var _pageToNavigate:String = "";

		public function get pageToNavigate():String
		{
			return _pageToNavigate;
		}

		public function set pageToNavigate(value:String):void
		{
			_pageToNavigate = value;
		}
		
		protected var _action:String = "";
		
		public function get action():String
		{
			return _action;
		}
		
		public function set action(value:String):void
		{
			_action = value;
		}
	}
}