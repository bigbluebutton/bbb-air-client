package org.bigbluebutton.core
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

	import org.bigbluebutton.core.util.URLFetcher;
	import org.bigbluebutton.model.Config;
	import org.flexunit.internals.events.ExecutionCompleteEvent;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class JoinService
	{
		protected var _successSignal:Signal = new Signal();
		protected var _unsuccessSignal:Signal = new Signal();

		private static const URL_REQUEST_ERROR_TYPE:String = "TypeError";
		private static const URL_REQUEST_INVALID_URL_ERROR:String = "invalidURL";
		private static const URL_REQUEST_GENERIC_ERROR:String = "genericError";
		private static const XML_RETURN_CODE_FAILED:String = "FAILED";
		private static const JOIN_URL_EMPTY:String = "emptyJoinUrl";

		public function get successSignal():ISignal {
			return _successSignal;
		}

		public function get unsuccessSignal():ISignal {
			return _unsuccessSignal;
		}

		public function join(joinUrl:String):void {
			if (joinUrl.length == 0) {
				onUnsuccess(JOIN_URL_EMPTY);
				return;
			}

			var fetcher:URLFetcher = new URLFetcher();
			fetcher.successSignal.add(onSuccess);
			fetcher.unsuccessSignal.add(onUnsuccess);
			fetcher.fetch(joinUrl);
		}

		protected function onSuccess(data:Object, responseUrl:String, urlRequest:URLRequest):void {
			try {
				var xml:XML = new XML(data);
				if (xml.returncode == XML_RETURN_CODE_FAILED) {
					onUnsuccess(xml.messageKey);
					return;
				}
			} catch (e:Error) {
				switch(e.name)
				{
					case URL_REQUEST_ERROR_TYPE:
						onUnsuccess(URL_REQUEST_INVALID_URL_ERROR);
						break;
					default:
						onUnsuccess(URL_REQUEST_GENERIC_ERROR);
				}

				trace("The response is probably not a XML. " + e.message);
				return;
			}
			successSignal.dispatch(urlRequest, responseUrl);
		}

		protected function onUnsuccess(reason:String):void {
			unsuccessSignal.dispatch(reason);
		}
	}
}

