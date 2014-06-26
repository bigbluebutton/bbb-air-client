package org.bigbluebutton.view.navigation.pages.videochat
{
	import flash.media.Video;
	
	import mx.core.FlexGlobals;
	
	import org.bigbluebutton.view.navigation.pages.common.VideoView;

	// later will be used to add additional functionality to the webcam view e.g. display username on the top of the video
	public class VideoChatVideoView extends VideoView
	{	
		public function setVideoPosition():void
		{
			if (video && stage.contains(video))
			{
				stage.removeChild(video);
			}		
			video = new Video();
			video.attachNetStream(ns);
			resizeForPortrait();
			var topActionBarHeight : Number = FlexGlobals.topLevelApplication.topActionBar.height;
			video.y = topActionBarHeight;
			video.x = (stage.stageWidth-video.width)/2;
			this.stage.addChild(video);
		}

	}
}