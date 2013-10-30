package org.mconf.mobile.command
{
	import mx.utils.ObjectUtil;
	
	import org.mconf.mobile.core.IBigBlueButtonConnection;
	import org.mconf.mobile.core.IUsersService;
	import org.mconf.mobile.model.IConferenceParameters;
	import org.mconf.mobile.model.IUserSession;
	import org.mconf.mobile.model.IUserUISession;
	import org.mconf.mobile.view.navigation.pages.PagesENUM;
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class ConnectCommand extends Command
	{		
		[Inject]
		public var userSession: IUserSession;
		
		[Inject]
		public var userUISession: IUserUISession;
		
		[Inject]
		public var conferenceParameters: IConferenceParameters;
		
		[Inject]
		public var connection: IBigBlueButtonConnection;
		
		[Inject]
		public var uri: String;
		
		[Inject]
		public var usersService: IUsersService;
				
		override public function execute():void {
			connection.uri = uri;
			
			connection.successConnected.add(successConnected)
			connection.unsuccessConnected.add(unsuccessConnected)
			trace("Trying to create the NetConnection");
			connection.connect(conferenceParameters);
		}

		private function successConnected():void {
			Log.getLogger("org.mconf.mobile").info(String(this) + ":successConnected()");
			
			userSession.netconnection = connection.connection;
			userSession.userId = connection.userId;
			trace("My userId is " + userSession.userId); 
			
			userUISession.loading = false;
			userUISession.pushPage(PagesENUM.PRESENTATION); 
			
			usersService.connect(uri);
		}
		
		private function unsuccessConnected(reason:String):void {
			Log.getLogger("org.mconf.mobile").info(String(this) + ":unsuccessConnected()");
			
			userUISession.loading = false;
		}
		
	}
}