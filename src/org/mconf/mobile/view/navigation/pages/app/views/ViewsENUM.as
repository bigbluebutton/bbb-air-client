package org.mconf.mobile.view.navigation.pages.app.views
{
	import flash.utils.Dictionary;
	
	import org.mconf.mobile.view.navigation.pages.app.views.profile.ProfileView;

	public class ViewsENUM
	{
		public static const PROFILE:String = "profile";
		public static const CHAT_ROOM:String = "chatroom";
		public static const PARTICIPANTS:String = "participants";
		public static const CAMERAS:String = "cameras";
		
		protected static function init():void
		{
			if(!dicInitiated) 
			{
				dic[PROFILE] = ProfileView;
				//dic[CHAT_ROOM] = LoginPageView;
				//dic[PARTICIPANTS] = LoginPageView;
				//dic[CAMERAS] = LoginPageView;
				
				dicInitiated = true;
			}
		}
		
		protected static var dic:Dictionary = new Dictionary();
		protected static var dicInitiated:Boolean = false;
		
		public static function contain(name:String):Boolean
		{
			init();
			return (dic[name] != null)
		}
		
		public static function getClassfromName(name:String):Class
		{
			init();
			var klass:Class = null;
			if(contain(name))
			{
				klass = dic[name];
			}
			return klass;
		}
	}
}