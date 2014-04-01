package org.bigbluebutton.view.ui
{
	public class SwapCameraButton extends SwapCameraBase implements ISwapCameraButton 
	{
		public function SwapCameraButton()
		{
			super();
		}
		
		public function setVisibility(val:Boolean):void
		{
			swapCameraButton.visible = val;
		}
		
		public function dispose():void
		{
			this.dispose();
		}
	}
}