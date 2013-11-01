package org.bigbluebutton.view.navigation.pages.profile
{
	import flash.events.MouseEvent;
	
	public class ProfileView extends ProfileViewBase implements IProfileView
	{
		
		//private var _buttonTestSignal: Signal = new Signal();
		//public function get buttonTestSignal(): ISignal
		//{
		//	return _buttonTestSignal;
		//}
		
		override protected function childrenCreated():void
		{
			super.childrenCreated();
			
			//this.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		public function onClick(e:MouseEvent):void
		{
			//buttonTestSignal.dispatch();
		}

		public function dispose():void
		{
			
		}

	}
}