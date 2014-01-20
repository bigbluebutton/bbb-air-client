package org.bigbluebutton.model
{
	import mx.collections.ArrayList;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	public class UserUISession implements IUserUISession
	{
		public function UserUISession()
		{
			
		}
		
		/**
		 * Dispatched when the application is loading something
		 */
		private var _loadingSignal: Signal = new Signal();
		
		public function get loadingSignal(): ISignal
		{
			return _loadingSignal;
		}
		
		/**
		 * Dispatched when a setting was changed
		 */
		private var _pageChangedSignal: Signal = new Signal();
		
		public function get pageChangedSignal(): ISignal
		{
			return _pageChangedSignal;
		}
		
		/**
		 * Holds the page's names used on ViewNavigator
		 */ 
		protected var _listPages:ArrayList = new ArrayList([]);
		
		public function get currentPage():String
		{
			var s:String = null;
			if(_listPages.length > 0)
			{
				s = _listPages.getItemAt(_listPages.length-1).value as String;
			}
			return s;
		}
		
		public function pushPage(value:String, details:Object = null):void
		{
			if(value != currentPage)
			{
				_listPages.addItem({value:value, details:details});
				var removeView:Boolean = false;
				_pageChangedSignal.dispatch(currentPage, removeView);
			}
		}
		
		public function popPage():void
		{
			if(_listPages.length > 0)
			{
				_listPages.removeItemAt(_listPages.length-1);
				var removeView:Boolean = true;
				_pageChangedSignal.dispatch(currentPage, removeView);
			}				
		}
		
		public function get currentPageDetails():Object
		{
			var details:Object = null;
			if(_listPages.length > 0)
			{
				details = _listPages.getItemAt(_listPages.length-1).details;
			}
			return details; 
		}
		
		/**
		 * Should be set true when the application is loading data
		 */ 
		private var _loading:Boolean = false;

		public function get loading():Boolean
		{
			return _loading;
		}

		public function set loading(value:Boolean):void
		{
			_loading = value;
			_loadingSignal.dispatch(_loading);
		}
	}
}