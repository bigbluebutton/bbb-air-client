package org.bigbluebutton.view.navigation.pages.videochat
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.InterpolationMethod;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.geom.*;
	import flash.media.Video;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import mx.core.FlexGlobals;
	
	import org.bigbluebutton.view.navigation.pages.common.VideoView;

	public class VideoChatVideoView extends VideoView
	{
		private var _userName:TextField;
		private var _shape:Shape;
		
		public function setVideoPosition(name:String):void
		{
			if (video && stage.contains(video))
			{
				stage.removeChild(video);
			}		
			resizeForPortrait();
			var topActionBarHeight : Number = FlexGlobals.topLevelApplication.topActionBar.height;
			video.y = topActionBarHeight + (screenHeight - video.height)/2;
			video.x = (stage.stageWidth-video.width)/2;
			this.stage.addChild(video);
			identifyVideoStream(video.x,video.height+video.y,name);
		}
		
		private function identifyVideoStream(x: Number, y:Number, name:String):void
		{
			this.styleName = "videoTextFieldStyle";
			var nameFormat:TextFormat = new TextFormat();
			nameFormat.size = this.getStyle("fontSize");
			nameFormat.font = this.getStyle("font-family");
			nameFormat.indent = this.getStyle("indent");
			_userName = new TextField();
			_userName.autoSize = TextFieldAutoSize.LEFT;
			_userName.text = name;
			_userName.textColor = this.getStyle("color");
			_userName.setTextFormat(nameFormat, 0, name.length);
			_userName.x = x;
			_userName.y = y - _userName.textHeight;
			
			var gradientMatrixWidth:Number = video.width;
			var gradientMatrixHeight:Number = _userName.height;
			var gradientMatrixRotation:Number = 1.57;
			var gradientTx:Number = 0;
			var gradientTy:Number = -_userName.height/2;
			
			var gradientDrawWidth:Number = video.width;
			var gradientDrawHeight:Number = _userName.height;
			var gradientOffsetX:Number = 0;
			var gradientOffsetY:Number = _userName.y;
			
			var gradientMatrix:Matrix = new Matrix ( );
			gradientMatrix.createGradientBox ( gradientMatrixWidth, gradientMatrixHeight, gradientMatrixRotation, gradientTx + gradientOffsetX, gradientTy + gradientOffsetY);
			
			var gradientType:String = GradientType.LINEAR;
			var gradientColors:Array = [0xB8B8B6, 0x242423];
			var gradientAlphas:Array = [1, 1];
			var gradientRatios:Array = [0, 255];
			var gradientSpreadMethod:String = SpreadMethod.PAD;
			var gradientInterpolationMethod:String = InterpolationMethod.LINEAR_RGB;
			var gradientFocalPoint:Number = 0;
			_shape = new Shape();
			var gradientGraphics:Graphics = _shape.graphics;
			
			gradientGraphics.beginGradientFill ( gradientType, gradientColors, gradientAlphas, gradientRatios, gradientMatrix, gradientSpreadMethod,  gradientInterpolationMethod, gradientFocalPoint );
			gradientGraphics.drawRect ( gradientOffsetX, gradientOffsetY, gradientDrawWidth ,gradientDrawHeight );
			gradientGraphics.endFill ( );
			this.stage.addChild(_shape);
			this.stage.addChild(_userName);
		}
	
		override public function close():void
		{
			super.close();
			if(_userName && this.stage.contains(_userName))
			{
				this.stage.removeChild(_userName);
			}
			if(_shape && this.stage.contains(_shape))
			{
				this.stage.removeChild(_shape);
			}
		}
	}
}