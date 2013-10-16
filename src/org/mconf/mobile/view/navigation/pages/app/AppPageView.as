package org.mconf.mobile.view.navigation.pages.app
{
	import flash.events.MouseEvent;
	
	public class AppPageView extends AppPageViewBase implements IAppPageView
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