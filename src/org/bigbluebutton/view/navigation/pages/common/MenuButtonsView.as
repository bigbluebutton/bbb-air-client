package org.bigbluebutton.view.navigation.pages.common
{
	import org.bigbluebutton.view.ui.MenuChatButton;
	import org.bigbluebutton.view.ui.MenuDeskshareButton;
	import org.bigbluebutton.view.ui.MenuParticipantsButton;
	import org.bigbluebutton.view.ui.MenuPresentationButton;
	import org.bigbluebutton.view.ui.MenuVideoChatButton;
		
	public class MenuButtonsView extends MenuButtons implements IMenuButtonsView
	{
		public function get menuDeskshareButton():MenuDeskshareButton
		{
			return deskshareBtn0;
		}
		
		public function get menuVideoChatButton():MenuVideoChatButton
		{
			return videochatBtn0;
		}
		
		public function get menuPresentationButton():MenuPresentationButton
		{
			return presentationBtn0;
		}
		
		public function get menuChatButton():MenuChatButton
		{
			return chatBtn0;
		}
		
		public function get menuParticipantsButton():MenuParticipantsButton
		{
			return participantsBtn0;
		}
	}
}