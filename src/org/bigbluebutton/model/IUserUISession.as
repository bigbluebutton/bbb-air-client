package org.bigbluebutton.model
{
	import org.bigbluebutton.view.navigation.pages.TransitionAnimationENUM;
	import org.osflash.signals.ISignal;

	public interface IUserUISession
	{
		function get pageChangedSignal(): ISignal;
		function get pageTransitionStartSignal(): ISignal;
		function get loadingSignal(): ISignal;
		function get unsuccessJoined(): ISignal;
		
		function get currentPage():String;
		function get lastPage():String;
		function popPage(animation:int = TransitionAnimationENUM.APPEAR):void;
		function pushPage(value:String, details:Object = null, animation:int = TransitionAnimationENUM.APPEAR):void;
		function get currentPageDetails():Object;
		function get loading():Boolean;
		function set loading(value:Boolean):void;		
	}
}