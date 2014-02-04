package org.bigbluebutton.view.ui
{
	import flash.events.MouseEvent;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	import spark.components.Group;
	
	public class NavigationButton extends Group implements INavigationButton
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
			navigate();
		}	
		
		protected function navigate():void
		{
			_navigationSignal.dispatch();
		}
		
		public function dispose():void
		{
			_navigationSignal.removeAll();
			
			this.removeEventListener(MouseEvent.CLICK, onClick);
		}
		
		protected var _navigateTo:String = "";

		public function get navigateTo():String
		{
			return _navigateTo;
		}

		public function set navigateTo(value:String):void
		{
			_navigateTo = value;
		}
		
		protected var _pageDetails:String = "";
		
		public function get pageDetails():String
		{
			return _pageDetails;
		}
		
		public function set pageDetails(value:String):void
		{
			_pageDetails = value;
		}
	}
}