package org.mconf.mobile.core
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	
	import mx.graphics.shaderClasses.ExclusionShader;
	import mx.utils.ObjectUtil;
	
	import org.flexunit.internals.events.ExecutionCompleteEvent;
	import org.mconf.mobile.model.Config;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class JoinService
	{
		protected var _successSignal:Signal = new Signal();
		protected var _unsuccessSignal:Signal = new Signal();
		
		public function get successSignal():ISignal {
			return _successSignal;
		}
		
		public function get unsuccessSignal():ISignal {
			return _unsuccessSignal;
		}
		
		public function join(joinUrl:String):void {
			var fetcher:URLFetcher = new URLFetcher();
			fetcher.successSignal.add(onSuccess);
			fetcher.unsuccessSignal.add(onUnsuccess);
			fetcher.fetch(joinUrl);
		}
		
		protected function onSuccess(data:Object, urlRequest:URLRequest):void {
			try {
				var xml:XML = new XML(data);
				if (xml.returncode == 'FAILED') {
					unsuccessSignal.dispatch(xml.messageKey + ": " + xml.message);
					return;
				}
			} catch (e:Error) {
				trace("The response is probably not an XML, continuing");
				trace(ObjectUtil.toString(e));
			}
			successSignal.dispatch(urlRequest);
		}
		
		protected function onUnsuccess(reason:String):void {
			unsuccessSignal.dispatch(reason);
		}
	}
}