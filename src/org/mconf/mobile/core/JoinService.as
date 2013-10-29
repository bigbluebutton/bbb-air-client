package org.mconf.mobile.core
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	
	import mx.utils.ObjectUtil;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class JoinService implements IJoinService
	{
		private var _urlRequest:URLRequest = null;
		private var _successJoinedSignal:Signal = new Signal();
		private var _unsuccessJoinedSignal:Signal = new Signal();
		private var _joinUrl:String;
		
		public function get successJoinedSignal():ISignal {
			return _successJoinedSignal;
		}

		public function get unsuccessJoinedSignal():ISignal {
			return _unsuccessJoinedSignal;
		}
		
		protected function fail(reason:String):void { 
			trace("Join failed: " + reason);
			unsuccessJoinedSignal.dispatch(reason);
		}			
		
		public function load(joinUrl:String):void {
			_joinUrl = joinUrl;
			
			var joinSubservice:JoinSubservice = new JoinSubservice();
			joinSubservice.successSignal.add(afterJoin);
			joinSubservice.unsuccessSignal.add(fail);
			joinSubservice.join(_joinUrl);
		}
		
		protected function afterJoin(urlRequest:URLRequest):void {
			_urlRequest = urlRequest;
			
			var configSubservice:ConfigSubservice = new ConfigSubservice();
			configSubservice.successSignal.add(afterConfig);
			configSubservice.unsuccessSignal.add(fail);
			configSubservice.getConfig(ConfigSubservice.joinUrlToConfigUrl(_joinUrl), _urlRequest);
		}
		
		protected function afterConfig(xml:XML):void {
			trace(xml);
			
			var enterSubservice:EnterSubservice = new EnterSubservice();
			enterSubservice.successSignal.add(afterEnter);
			enterSubservice.unsuccessSignal.add(fail);
			enterSubservice.enter(EnterSubservice.joinUrlToEnterUrl(_joinUrl), _urlRequest);
		}
		
		protected function afterEnter(xml:XML):void {
			trace(xml);
			
			var returncode:String = xml.returncode;
			if (returncode == 'SUCCESS') {
				trace("Join SUCCESS");
				var user:Object = {
					username:xml.fullname, 
						conference:xml.conference, 
						conferenceName:xml.confname,
						externMeetingID:xml.externMeetingID,
						meetingID:xml.meetingID, 
						externUserID:xml.externUserID, 
						internalUserId:xml.internalUserID,
						role:xml.role, 
						room:xml.room, 
						authToken:xml.room, 
						record:xml.record, 
						webvoiceconf:xml.webvoiceconf, 
						dialnumber:xml.dialnumber,
						voicebridge:xml.voicebridge, 
						mode:xml.mode, 
						welcome:xml.welcome, 
						logoutUrl:xml.logoutUrl, 
						defaultLayout:xml.defaultLayout, 
						avatarURL:xml.avatarURL };
				user.customdata = new Object();
				if(xml.customdata)
				{
					for each(var cdnode:XML in xml.customdata.elements()){
						trace("checking user customdata: "+cdnode.name() + " = " + cdnode);
						user.customdata[cdnode.name()] = cdnode.toString();
					}
				}
				trace("Dispatching successfullyJoinedMeetingSignal");
				successJoinedSignal.dispatch(user);
			} else {
				trace("Join FAILED");
				
				unsuccessJoinedSignal.dispatch("Add some reason here!");
			}
		}
	}
}