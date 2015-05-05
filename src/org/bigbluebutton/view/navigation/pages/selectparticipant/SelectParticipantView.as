package org.bigbluebutton.view.navigation.pages.selectparticipant {
	
	import flash.events.MouseEvent;
	
	public class SelectParticipantView extends SelectParticipantViewBase implements ISelectParticipantView {
		//private var _buttonTestSignal: Signal = new Signal();
		//public function get buttonTestSignal(): ISignal
		//{
		//	return _buttonTestSignal;
		//}
		override protected function childrenCreated():void {
			super.childrenCreated();
			//this.addEventListener(MouseEvent.CLICK, onClick);
		}
		import spark.components.List;
		
		public function get list():List {
			return participantslist;
		}
		
		/*
		   public function onClick(e:MouseEvent):void
		   {
		   //buttonTestSignal.dispatch();
		   }
		 */
		public function dispose():void {
		}
	}
}
