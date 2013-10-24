package org.mconf.mobile.util
{
	import spark.transitions.SlideViewTransition;
	
	public class NoTransition extends SlideViewTransition
	{
		public function NoTransition()
		{
			super();
			
			duration = 0;
		}
	}
}