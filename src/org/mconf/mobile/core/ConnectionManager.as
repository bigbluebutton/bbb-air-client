package org.mconf.mobile.core
{
	import flash.net.NetConnection;
	
	import org.mconf.mobile.model.ConferenceParameters;

	public class ConnectionManager
	{
		private var _connDelegate:NetConnectionMediator;
		
		public function ConnectionManager()
		{
			_connDelegate = new NetConnectionMediator();
		}
		
		public function set uri(uri:String):void {
			_connDelegate.uri = uri;
		}
		
		public function get connection():NetConnection {
			return _connDelegate.connection;
		}
		
		public function connect(params:ConferenceParameters):void {
			_connDelegate.connect(params);
		}
		
		public function disconnect(onUserAction:Boolean):void {
			_connDelegate.disconnect(onUserAction);
		}
	}
}