package org.bigbluebutton.core
{
	import flash.net.NetConnection;
	
	import org.bigbluebutton.model.ConferenceParameters;
	import org.bigbluebutton.model.IConferenceParameters;
	import org.osflash.signals.ISignal;

	public interface IUsersServiceSO
	{
		//function get successfullyJoinedMeetingSignal():ISignal;
		//function get unsuccessfullyJoinedMeetingSignal():ISignal;
		function connect(connection:NetConnection, uri:String, params:IConferenceParameters):void;
		function disconnect():void;
	}
}