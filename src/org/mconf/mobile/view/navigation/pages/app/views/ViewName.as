package org.mconf.mobile.view.navigation.pages.app.views
{
	public class ViewName extends Object
	{
		protected var _name:String
		
		public function ViewName(value:*="")
		{
			_name = value;
		}
		
		public function isValid():Boolean
		{
			return (_name != null && _name != "")
		}
				
		public function toString():String 
		{
			return _name;
		}
		
		public function valueOf():Object
		{
			return _name;
		}

	}
}