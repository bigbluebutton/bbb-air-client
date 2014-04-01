package org.bigbluebutton.view.ui
{
	import flash.events.MouseEvent;
	
	import mx.events.DragEvent;
	
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.command.ShareCameraSignal;
	import flash.media.CameraPosition;
	

	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class SwapCameraMediator extends Mediator
	{
		[Inject]
		public var view:ISwapCameraButton;
		
		[Inject]
		public var userSession:IUserSession;
			
		[Inject]
		public var shareCameraSignal: ShareCameraSignal;
		
		public override function initialize():void
		{
			view.setVisibility(userSession.userList.me.hasStream);		
			(view as SwapCameraButton).addEventListener(MouseEvent.CLICK, mouseClickHandler);
		}
		
		/**
		 * Raised on button click, will send signal to swap camera source  
		 **/
		private function mouseClickHandler(e:MouseEvent):void
		{		
			if (String(userSession.videoConnection.cameraPosition) == CameraPosition.FRONT)
			{
				shareCameraSignal.dispatch(userSession.userList.me.hasStream, CameraPosition.BACK);
			}
			else if (String(userSession.videoConnection.cameraPosition) == CameraPosition.BACK)
			{
				shareCameraSignal.dispatch(userSession.userList.me.hasStream, CameraPosition.FRONT);
			}
		}
	}
}