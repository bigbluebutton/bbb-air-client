package org.mconf.mobile.model
{
	import mx.collections.ArrayList;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	public class UserSession implements IUserSession
	{
		public function UserSession()
		{
			
		}
		
		/**
		 * Dispatched when a setting was changed
		 */
		private var _pageChangedSignal: Signal = new Signal();
		
		public function get pageChangedSignal(): ISignal
		{
			return _pageChangedSignal;
		}
		
		protected var _listPages:ArrayList = new ArrayList([]);
		
		public function get currentPage():String
		{
			var s:String = null;
			if(_listPages.length > 0)
			{
				s = _listPages.getItemAt(_listPages.length-1) as String;
			}
			return s;
		}
		
		public function pushPage(value:String):void
		{
			_listPages.addItem(value);
			_pageChangedSignal.dispatch(currentPage, false);
		}
		
		public function popPage():void
		{
			if(_listPages.length > 0)
			{
				_listPages.removeItemAt(_listPages.length-1);
				_pageChangedSignal.dispatch(currentPage, true);
			}				
		}
	}
}