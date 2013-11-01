package org.bigbluebutton.core
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	
	import org.osflash.signals.ISignal;

	public interface ILoginService
	{
		function get successJoinedSignal():ISignal;
		function get successGetConfigSignal():ISignal;
		function get unsuccessJoinedSignal():ISignal;
		function load(joinUrl:String):void;
	}
}