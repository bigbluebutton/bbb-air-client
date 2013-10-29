package org.mconf.mobile.core
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	
	import org.osflash.signals.ISignal;

	public interface IJoinService
	{
		function get successfullyJoinedMeetingSignal():ISignal;
		function get unsuccessfullyJoinedMeetingSignal():ISignal;
		function load(joinUrl:String):void;
		function enter(enterUrl:String):void;
	}
}