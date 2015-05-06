package org.bigbluebutton.core {
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import mx.utils.ObjectUtil;
	import org.bigbluebutton.core.util.URLParser;
	import org.bigbluebutton.model.Config;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	public class LoginService implements ILoginService {
		protected var _urlRequest:URLRequest = null;
		
		protected var _successJoinedSignal:Signal = new Signal();
		
		protected var _successGetConfigSignal:Signal = new Signal();
		
		protected var _unsuccessJoinedSignal:Signal = new Signal();
		
		protected var _joinUrl:String;
		
		public function get successJoinedSignal():ISignal {
			return _successJoinedSignal;
		}
		
		public function get unsuccessJoinedSignal():ISignal {
			return _unsuccessJoinedSignal;
		}
		
		public function get successGetConfigSignal():ISignal {
			return _successGetConfigSignal;
		}
		
		protected function fail(reason:String):void {
			trace("Login failed. " + reason);
			unsuccessJoinedSignal.dispatch(reason);
			//TODO: show message to user saying that the meeting identifier is invalid 
		}
		
		public function load(joinUrl:String):void {
			_joinUrl = joinUrl;
			var joinSubservice:JoinService = new JoinService();
			joinSubservice.successSignal.add(afterJoin);
			joinSubservice.unsuccessSignal.add(fail);
			joinSubservice.join(_joinUrl);
		}
		
		protected function afterJoin(urlRequest:URLRequest, responseUrl:String):void {
			_urlRequest = urlRequest;
			var configSubservice:ConfigService = new ConfigService();
			configSubservice.successSignal.add(afterConfig);
			configSubservice.unsuccessSignal.add(fail);
			configSubservice.getConfig(getServerUrl(responseUrl), _urlRequest);
		}
		
		protected function getServerUrl(url:String):String {
			var parser:URLParser = new URLParser(url);
			return parser.protocol + "://" + parser.host + ":" + parser.port;
		}
		
		protected function afterConfig(xml:XML):void {
			var config:Config = new Config(xml);
			successGetConfigSignal.dispatch(config);
			var enterSubservice:EnterService = new EnterService();
			enterSubservice.successSignal.add(afterEnter);
			enterSubservice.unsuccessSignal.add(fail);
			enterSubservice.enter(config.application.host, _urlRequest);
		}
		
		protected function afterEnter(result:Object):void {
			if (result.returncode == 'SUCCESS') {
				trace("Join SUCCESS");
				var user:Object = {
						username: result.fullname,
						conference: result.conference,
						conferenceName: result.confname,
						externMeetingID: result.externMeetingID,
						meetingID: result.meetingID,
						externUserID: result.externUserID,
						internalUserId: result.internalUserID,
						role: result.role,
						room: result.room,
						authToken: result.authToken,
						record: result.record,
						webvoiceconf: result.webvoiceconf,
						dialnumber: result.dialnumber,
						voicebridge: result.voicebridge,
						mode: result.mode,
						welcome: result.welcome,
						logoutUrl: result.logoutUrl,
						defaultLayout: result.defaultLayout,
						avatarURL: result.avatarURL,
						guest: result.guest};
				user.customdata = new Object();
				if (result.customdata) {
					for (var key:String in result.customdata) {
						trace("checking user customdata: " + key + " = " + result.customdata[key]);
						user.customdata[key] = result.customdata[key].toString();
					}
				}
				successJoinedSignal.dispatch(user);
			} else {
				trace("Join FAILED");
				unsuccessJoinedSignal.dispatch("Add some reason here!");
			}
		}
	}
}
