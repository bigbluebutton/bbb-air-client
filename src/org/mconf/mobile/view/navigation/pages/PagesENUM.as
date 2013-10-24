package org.mconf.mobile.view.navigation.pages
{
	import org.mconf.mobile.view.navigation.pages.app.AppPageView;
	import org.mconf.mobile.view.navigation.pages.login.LoginPageView;

	public class PagesENUM
	{
		public static const APPLICATION:PageName = new PageName("app");
		public static const LOGIN:PageName = new PageName("login");
		
		public static function getClassfromPageName(name:String):Class
		{
			var pageName:PageName = new PageName(name);
			var klass:Class = null;
			if(pageName.isValid())
			{
				switch(pageName.toString())
				{
					case APPLICATION.toString(): 
						klass = AppPageView;
						break;
					
					case LOGIN.toString(): 
						klass = LoginPageView;
						break;
				}
			}
			return klass;
		}
	}
}