package org.mconf.mobile.view.ui
{
	import flash.events.MouseEvent;
	
	import org.mconf.mobile.core.JoinService;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	public class LoginButton extends LoginButtonBase implements ILoginButton
	{
		/**
		 * Dispatched when the user click the button to log in
		 */		
		private var _loginSignal: Signal = new Signal();
		
		public function get loginSignal(): ISignal
		{
			return _loginSignal;
		}

		public function LoginButton()
		{
			super();
		}
		
		override protected function childrenCreated():void
		{
			super.childrenCreated();
			
			this.addEventListener(MouseEvent.CLICK, change);
		}
		
		protected function change(e:MouseEvent):void
		{
			trace("Login get clicked, dispatching signal");
			
			// TEMPORARY CODE!!!
			var url:String = "http://test-install.blindsidenetworks.com/bigbluebutton/api/join?meetingID=Demo%20Meeting&fullName=Air%20client&password=ap&checksum=e9c5f7a397509e908ada2787aa0a284842ef4faf";
			loginSignal.dispatch(url);
		}		
		
		override public function dispose():void
		{
			super.dispose();
			
			_loginSignal.removeAll();
			
			this.removeEventListener(MouseEvent.CLICK, change);
		}
	}
}