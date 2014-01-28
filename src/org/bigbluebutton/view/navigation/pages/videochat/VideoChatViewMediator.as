package org.bigbluebutton.view.navigation.pages.videochat
{
	import flash.display.DisplayObject;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectUtil;
	
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.IUserUISession;
	import org.bigbluebutton.model.User;
	import org.bigbluebutton.model.UserSession;
	import org.bigbluebutton.view.navigation.pages.PagesENUM;
	import org.mockito.integrations.currentMockito;
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class VideoChatViewMediator extends Mediator
	{
		[Inject]
		public var view: IVideoChatView;
		
		[Inject]
		public var userSession: IUserSession;
		
		[Inject]
		public var userUISession: IUserUISession;
		
		protected var user:User;
		
		override public function initialize():void
		{
			Log.getLogger("org.bigbluebutton").info(String(this));
			
			userSession.userlist.userRemovedSignal.add(userRemovedHandler);
			userSession.userlist.userAddedSignal.add(userAddedHandler);
			userSession.userlist.userChangeSignal.add(userChangeHandler);
			
			userUISession.pageTransitionStartSignal.add(onPageTransitionStart);
			
			// find all currently open streams
			//var users:ArrayCollection = userSession.userlist.users;
			//for (var i:Number=0; i < users.length; i++) {
			//	var u:User = users.getItemAt(i) as User;
			//	if (u.hasStream) {
			//		startStream(u.name, u.streamName);
			//	}
			//}
			
			user = userUISession.currentPageDetails as User;
			
			var presenter:User = userSession.userlist.getPresenter();
			var userWithCamera:User = getUserWithCamera();
			if(user && user.hasStream)
			{
				startStream(user.name, user.streamName);
				view.noVideoMessage.visible = false;
			}
			else if(presenter != null)
			{
				startStream(presenter.name, presenter.streamName);
			}
			else if(userWithCamera != null)
			{
				startStream(userWithCamera.name, userWithCamera.streamName);
			}
			else
			{
				view.noVideoMessage.visible = true;
			}
		}
		
		protected function getUserWithCamera():User
		{
			var users:ArrayCollection = userSession.userlist.users;
			for each(var u:User in users) 
			{
				if (u.hasStream) {
					return u;
				}
			}
			return null;
		}
				
		private function onPageTransitionStart(lastPage:String):void
		{
			if(lastPage == PagesENUM.VIDEO_CHAT)
			{
				view.dispose();
			}
		}
		
		override public function destroy():void
		{
			view.cleanUpVideos();
			
			userSession.userlist.userRemovedSignal.remove(userRemovedHandler);
			userSession.userlist.userAddedSignal.remove(userAddedHandler);
			userSession.userlist.userChangeSignal.remove(userChangeHandler);
			
			userUISession.pageTransitionStartSignal.remove(onPageTransitionStart);
			
			super.destroy();
			
			view.dispose();
			view = null;
		}
		
		private function userAddedHandler(user:User):void {
			//if (user.hasStream)
			//	startStream(user.name, user.streamName);
		}
		
		private function userRemovedHandler(userID:String):void {
			if(user.userID == userID)
			{
				stopStream();
				userUISession.popPage();
			}
		}
		
		private function userChangeHandler(user:User, property:String = null):void {
			if(user == user)
			{
				if (property == "hasStream" && user.hasStream)
				{
					startStream(user.name, user.streamName);
				}
			}
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