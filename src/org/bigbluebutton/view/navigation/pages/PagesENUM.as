package org.bigbluebutton.view.navigation.pages
{
	import flash.utils.Dictionary;
	
	import org.bigbluebutton.view.navigation.pages.chat.ChatView;
	import org.bigbluebutton.view.navigation.pages.login.LoginPageView;
	import org.bigbluebutton.view.navigation.pages.participants.ParticipantsView;
	import org.bigbluebutton.view.navigation.pages.presentation.PresentationView;
	import org.bigbluebutton.view.navigation.pages.profile.ProfileView;
	import org.bigbluebutton.view.navigation.pages.videochat.VideoChatView;

	public class PagesENUM
	{
		public static const PRESENTATION:String = "presentation";
		public static const LOGIN:String = "login";
		public static const PROFILE:String = "profile";
		public static const VIDEO_CHAT:String = "videochat";
		public static const CHAT:String = "chat";
		public static const PARTICIPANTS:String = "participants";
		
		protected static function init():void
		{
			if(!dicInitiated) 
			{
				dic[PRESENTATION] = PresentationView;
				dic[LOGIN] = LoginPageView;
				dic[PROFILE] = ProfileView;
				dic[VIDEO_CHAT] = VideoChatView;
				dic[CHAT] = ChatView;
				dic[PARTICIPANTS] = ParticipantsView;
				
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