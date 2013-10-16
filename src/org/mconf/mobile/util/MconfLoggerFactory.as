package org.mconf.mobile.util
{
	import org.osmf.logging.Logger;
	import org.osmf.logging.LoggerFactory;
	
	public class MconfLoggerFactory extends LoggerFactory
	{
		public function MconfLoggerFactory()
		{
			super();
		}
		
		override public function getLogger(category:String):Logger
		{
			return new MconfLogger(category);
		}
	}
}