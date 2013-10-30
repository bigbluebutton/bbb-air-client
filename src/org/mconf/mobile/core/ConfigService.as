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
	
	public class ConfigService
	{
		protected var _successSignal:Signal = new Signal();
		protected var _unsuccessSignal:Signal = new Signal();
		
		public function get successSignal():ISignal {
			return _successSignal;
		}
		
		public function get unsuccessSignal():ISignal {
			return _unsuccessSignal;
		}
		
		public function getConfig(configUrl:String, urlRequest:URLRequest):void {
			var fetcher:URLFetcher = new URLFetcher;
			fetcher.successSignal.add(onSuccess);
			fetcher.unsuccessSignal.add(onUnsuccess);
			fetcher.fetch(configUrl, urlRequest);
		}
		
		protected function onSuccess(data:Object, urlRequest:URLRequest):void {
			successSignal.dispatch(new XML(data));
		}
		
		protected function onUnsuccess(reason:String):void {
			unsuccessSignal.dispatch(reason);
		}
		
		public static function joinUrlToConfigUrl(joinUrl:String):String {
			var reg:RegExp = /(?P<protocol>[a-zA-Z]+) : \/\/  (?P<host>[^:\/]*) (:(?P<port>\d+))?  ((?P<path>[^?]*))? ((?P<parameters>.*))? /x;
			var results:Array = reg.exec(joinUrl);
			
			return results.protocol + "://" + results.host + (results.port.length > 0? ":" + results.port: "") + "/bigbluebutton/api/configXML?a=" + (new Date()).time;
		}
	}
}