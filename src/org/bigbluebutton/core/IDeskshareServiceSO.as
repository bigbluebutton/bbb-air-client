package org.bigbluebutton.core
{
	import org.bigbluebutton.model.IConferenceParameters;
	import flash.net.NetConnection;

	public interface IDeskshareServiceSO
	{
		function connect(connection:NetConnection, uri:String, params:IConferenceParameters):void
	}
}