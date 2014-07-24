package org.bigbluebutton.view.ui
{
	import spark.components.Image;
	
	public class RecordingStatus extends Image implements IRecordingStatus
	{
		public function RecordingStatus()
		{
			super();
		}
		
		public function setVisibility(val:Boolean):void
		{
			super.visible = val;
		}
		
		public function dispose():void
		{
			
		}
	}
}