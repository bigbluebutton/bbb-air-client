package org.bigbluebutton.util {
	
	import org.osmf.logging.Logger;
	import org.osmf.logging.LoggerFactory;
	
	public class BigBlueButtonLoggerFactory extends LoggerFactory {
		public function BigBlueButtonLoggerFactory() {
			super();
		}
		
		override public function getLogger(category:String):Logger {
			return new BigBlueButtonLogger(category);
		}
	}
}
