package org.bigbluebutton.util {
	
	import flash.utils.getTimer;
	import mx.logging.targets.TraceTarget;
	import org.osmf.logging.Logger;
	
	public class BigBlueButtonLogger extends Logger {
		protected var traceTarget:TraceTarget
		
		public function BigBlueButtonLogger(category:String) {
			super(category);
		}
		
		override public function debug(message:String, ... rest):void {
			trace(getTimer() + " DEBUG " + message);
		}
		
		override public function info(message:String, ... rest):void {
			trace(getTimer() + " INFO " + message);
		}
		
		override public function warn(message:String, ... rest):void {
			trace(getTimer() + " WARN " + message);
		}
		
		override public function error(message:String, ... rest):void {
			trace(getTimer() + " ERROR " + message);
		}
		
		override public function fatal(message:String, ... rest):void {
			trace(getTimer() + " FATAL " + message);
		}
	}
}
