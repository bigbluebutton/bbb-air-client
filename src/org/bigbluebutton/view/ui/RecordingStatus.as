package org.bigbluebutton.view.ui {
	
	import spark.components.Button;
	
	public class RecordingStatus extends Button implements IRecordingStatus {
		public function RecordingStatus() {
			super();
		}
		
		public function setVisibility(val:Boolean):void {
			super.visible = super.includeInLayout = val;
		}
		
		public function dispose():void {
		}
	}
}
