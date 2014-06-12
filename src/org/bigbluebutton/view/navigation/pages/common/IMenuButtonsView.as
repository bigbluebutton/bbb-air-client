package org.bigbluebutton.view.navigation.pages.common
{
	import org.bigbluebutton.view.ui.MenuChatButton;
	import org.bigbluebutton.view.ui.MenuDeskshareButton;
	import org.bigbluebutton.view.ui.MenuParticipantsButton;
	import org.bigbluebutton.view.ui.MenuPresentationButton;
	import org.bigbluebutton.view.ui.MenuVideoChatButton;

	public interface IMenuButtonsView
	{
		function get menuDeskshareButton():MenuDeskshareButton	
		function get menuVideoChatButton():MenuVideoChatButton	
		function get menuPresentationButton():MenuPresentationButton
		function get menuChatButton():MenuChatButton
		function get menuParticipantsButton():MenuParticipantsButton
	}
}