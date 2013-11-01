package org.bigbluebutton.model
{
	import org.osflash.signals.ISignal;

	public interface IUserUISession
	{
		function get pageChangedSignal(): ISignal;
		function get loadingSignal(): ISignal;

		function get currentPage():String;
		function popPage():void	;
		function pushPage(value:String):void;
		function get loading():Boolean;
		function set loading(value:Boolean):void;
	}
}