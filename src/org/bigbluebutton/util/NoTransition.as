package org.bigbluebutton.util {
	
	import spark.transitions.SlideViewTransition;
	
	public class NoTransition extends SlideViewTransition {
		public function NoTransition() {
			super();
			duration = 0;
		}
	}
}
