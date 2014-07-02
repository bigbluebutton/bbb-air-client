package org.bigbluebutton.view.navigation.pages.videochat
{
	import flash.display.GradientType;
	import flash.display.Graphics;
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
			var matrix:Matrix = new Matrix();
			_shape= new Shape();
			matrix.createGradientBox(video.width, video.height, Math.PI/2,0,0);
			_shape.graphics.beginGradientFill(GradientType.LINEAR,  [0xFFFFFF,0x000000], [0,0.75], [0,127], matrix,SpreadMethod.PAD);
			_shape.graphics.drawRect(_userName.x,_userName.y,video.width, _userName.height);
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