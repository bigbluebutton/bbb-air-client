package org.bigbluebutton.view.navigation.pages.videochat
{
	import flash.display.DisplayObject;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectUtil;
	
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.User;
	import org.bigbluebutton.model.UserSession;
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class VideoChatViewMediator extends Mediator
	{
		[Inject]
		public var view: IVideoChatView;
		
		[Inject]
		public var userSession: IUserSession;
		
		override public function initialize():void
		{
			Log.getLogger("org.bigbluebutton").info(String(this));
			
			userSession.userlist.userRemovedSignal.add(userRemovedHandler);
			userSession.userlist.userAddedSignal.add(userAddedHandler);
			userSession.userlist.userChangeSignal.add(userChangeHandler);
			
			// find all currently open streams
			var users:ArrayCollection = userSession.userlist.users;
			for (var i:Number=0; i < users.length; i++) {
				var u:User = users.getItemAt(i) as User;
				if (u.hasStream) {
					startStream(u.name, u.streamName);
				}
			}
		}
		
		override public function destroy():void
		{
			view.cleanUpVideos();
			
			super.destroy();
			
			view.dispose();
			view = null;
		}
		
		private function userAddedHandler(user:User):void {
			if (user.hasStream)
				startStream(user.name, user.streamName);
		}
		
		private function userRemovedHandler():void {//userID:String):void {
			stopStream();//userID);
		}
		
		private function userChangeHandler(user:User, property:String = null):void {
			if (property == "hasStream" && user.hasStream)
				startStream(user.name, user.streamName);
		}
		
		private function startStream(name:String, streamName:String):void {
			var resolution:Object = getVideoResolution(streamName);
			
			if (resolution) {
				trace(ObjectUtil.toString(resolution));
				var width:Number = Number(String(resolution.dimensions[0]));
				var length:Number = Number(String(resolution.dimensions[1]));
				if (view) 
				{
					view.startStream(userSession.videoConnection.connection, name, streamName, resolution.userID, width, length);
				}
			}
		}
		
		private function stopStream():void { //userID:String):void {
			if (view) {
				view.stopStream();//userID);
			}
		}
		
		protected function getVideoResolution(stream:String):Object {
			var pattern:RegExp = new RegExp("(\\d+x\\d+)-([A-Za-z0-9]+)-\\d+", "");
			if (pattern.test(stream)) {
				trace("The stream name is well formatted [" + stream + "]");
				trace("Stream resolution is [" + pattern.exec(stream)[1] + "]");
				trace("Userid [" + pattern.exec(stream)[2] + "]");
				return {userID: pattern.exec(stream)[2], dimensions:pattern.exec(stream)[1].split("x")};
			} else {
				trace("The stream name doesn't follow the pattern <width>x<height>-<userId>-<timestamp>. However, the video resolution will be set to 320x240");
				return null;
			}
		}
	}
}