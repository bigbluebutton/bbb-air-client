/**
 * BigBlueButton open source conferencing system - http://www.bigbluebutton.org/
 * 
 * Copyright (c) 2012 BigBlueButton Inc. and by respective authors (see below).
 *
 * This program is free software; you can redistribute it and/or modify it under the
 * terms of the GNU Lesser General Public License as published by the Free Software
 * Foundation; either version 3.0 of the License, or (at your option) any later
 * version.
 * 
 * BigBlueButton is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License along
 * with BigBlueButton; if not, see <http://www.gnu.org/licenses/>.
 *
 */
package org.bigbluebutton.core {
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SyncEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.net.SharedObject;
	
	import org.bigbluebutton.command.LoadPresentationSignal;
	import org.bigbluebutton.model.IConferenceParameters;
	import org.bigbluebutton.model.IUserSession;
	
	/*
	import org.bigbluebutton.core.managers.UserManager;
	import org.bigbluebutton.main.events.BBBEvent;
	import org.bigbluebutton.main.events.MadePresenterEvent;
	import org.bigbluebutton.main.model.users.BBBUser;
	import org.bigbluebutton.main.model.users.Conference;
	import org.bigbluebutton.modules.present.events.CursorEvent;
	import org.bigbluebutton.modules.present.events.MoveEvent;
	import org.bigbluebutton.modules.present.events.NavigationEvent;
	import org.bigbluebutton.modules.present.events.RemovePresentationEvent;
	import org.bigbluebutton.modules.present.events.UploadEvent;
	import org.bigbluebutton.modules.present.events.ZoomEvent;
	*/
	
	public class PresentServiceSO extends BaseServiceSO implements IPresentServiceSO
	{
		[Inject]
		public var userSession: IUserSession;
		
		[Inject]
		public var loadPresentationSignal: LoadPresentationSignal;
		
		private static const SO_NAME:String = "presentationSO";
		
		private static const PRESENTER:String = "presenter";
		private static const SHARING:String = "sharing";
		private static const UPDATE_MESSAGE:String = "updateMessage";
		private static const CURRENT_PAGE:String = "currentPage";
		
		private static const OFFICE_DOC_CONVERSION_SUCCESS_KEY:String = "OFFICE_DOC_CONVERSION_SUCCESS";
		private static const OFFICE_DOC_CONVERSION_FAILED_KEY:String = "OFFICE_DOC_CONVERSION_FAILED";
		private static const SUPPORTED_DOCUMENT_KEY:String = "SUPPORTED_DOCUMENT";
		private static const UNSUPPORTED_DOCUMENT_KEY:String = "UNSUPPORTED_DOCUMENT";
		private static const PAGE_COUNT_FAILED_KEY:String = "PAGE_COUNT_FAILED";
		private static const PAGE_COUNT_EXCEEDED_KEY:String = "PAGE_COUNT_EXCEEDED";    	
		private static const GENERATED_SLIDE_KEY:String = "GENERATED_SLIDE";
		private static const GENERATING_THUMBNAIL_KEY:String = "GENERATING_THUMBNAIL";
		private static const GENERATED_THUMBNAIL_KEY:String = "GENERATED_THUMBNAIL";
		private static const CONVERSION_COMPLETED_KEY:String = "CONVERSION_COMPLETED";
		
		private var currentSlide:Number = -1;
		
		public function PresentServiceSO(){
			super(SO_NAME);
		}
		
		override public function connect(connection:NetConnection, uri:String, params:IConferenceParameters):void {
			super.connect(connection, uri, params);
			
			syncReceived.add(syncHandler);
			successConnected.add(connectionSuccessHandler);
		}
		
		public function whatIsTheSlideInfo(userid:Number):void {
			
		}
		
		public function whatIsTheSlideInfoReply(userID:String, xOffset:Number, yOffset:Number, widthRatio:Number, heightRatio:Number):void{
			
		}
		
		/**
		 * Send an event to the server to update the presenter's cursor view on the client
		 * @param xPercent
		 * @param yPercent
		 * 
		 */
		public function sendCursorUpdate(xPercent:Number, yPercent:Number):void{
			userSession.mainConnection.connection.call("presentation.sendCursorUpdate",// Remote function name
				new Responder(
					// On successful result
					function(result:Boolean):void { 
						
						if (result) {
							trace("Successfully sent sendCursorUpdate");							
						}	
					},	
					// status - On error occurred
					function(status:Object):void { 
						trace("Error occurred:"); 
						for (var x:Object in status) { 
							trace(x + " : " + status[x]); 
						} 
					}
				), //new Responder
				xPercent,
				yPercent
			); //_netConnection.call
			
		}
		
		/**
		 * Sends an event to the server to update the clients with the new slide position 
		 * @param slideXPosition
		 * @param slideYPosition
		 * 
		 */		
		public function move(xOffset:Number, yOffset:Number, widthRatio:Number, heightRatio:Number):void{
			trace("sending move slide command");
			userSession.mainConnection.connection.call("presentation.resizeAndMoveSlide",// Remote function name
				new Responder(
					// participants - On successful result
					function(result:Boolean):void {
						if (result) {
							trace("Successfully sent resizeAndMoveSlide");
						}
					},
					// status - On error occurred
					function(status:Object):void {
						trace("Error occurred:");
						for (var x:Object in status) {
							trace(x + " : " + status[x]);
						}
					}
				), //new Responder
				xOffset,
				yOffset,
				widthRatio,
				heightRatio
			); //_netConnection.call
			
			presenterViewedRegionX = xOffset;
			presenterViewedRegionY = yOffset;
			presenterViewedRegionW = widthRatio;
			presenterViewedRegionH = heightRatio;
		}
		
		/**
		 * A callback method from the server to update the slide position
		 * @param slideXPosition
		 * @param slideYPosition
		 * 
		 */
		public function moveCallback(xOffset:Number, yOffset:Number, widthRatio:Number, heightRatio:Number):void{
			trace("moveCallback recieved");
			/*
			var e:MoveEvent = new MoveEvent(MoveEvent.MOVE);
			e.xOffset = xOffset;
			e.yOffset = yOffset;
			e.slideToCanvasWidthRatio = widthRatio;
			e.slideToCanvasHeightRatio = heightRatio;
			dispatcher.dispatchEvent(e);
			*/
		}
		
		/***
		 * A hack for the viewer to sync with the presenter. Have the viewer query the presenter for it's x,y,width and height info.
		 */
		private var presenterViewedRegionX:Number = 0;
		private var presenterViewedRegionY:Number = 0;
		private var presenterViewedRegionW:Number = 100;
		private var presenterViewedRegionH:Number = 100;
		
		public function removePresentation(name:String):void {
			trace("send removePresentation call");
			userSession.mainConnection.connection.call("presentation.removePresentation",// Remote function name
				new Responder(
					function(result:Boolean):void {
						if (result) {
							trace("Successfully removed presentation: " + name);
						}
					},
					// status - On error occurred
					function(status:Object):void {
						trace("Error occurred:");
						for (var x:Object in status) {
							trace(x + " : " + status[x]);
						}
					}
				), //new Responder
				name
			); //_netConnection.call
		}
		
		public function removePresentationCallback(presentationName:String):void {
			trace("removePresentationCallback " + presentationName);
			userSession.presentationList.removePresentation(presentationName);
		}
		
		public function getPresentationInfo():void {
			trace("getPresentationInfo sent");
			userSession.mainConnection.connection.call( "presentation.getPresentationInfo",// Remote function name
				new Responder(
					// participants - On successful result
					function(result:Object):void {
						trace("Successfully queried for presentation information.");
						if (result.presenter.hasPresenter) {
							//dispatcher.dispatchEvent(new MadePresenterEvent(MadePresenterEvent.SWITCH_TO_VIEWER_MODE));						
						}
						
						if (result.presentation.xOffset) {
							trace("Sending presenters slide settings");
							/*
							var e:MoveEvent = new MoveEvent(MoveEvent.CUR_SLIDE_SETTING);
							e.xOffset = Number(result.presentation.xOffset);
							e.yOffset = Number(result.presentation.yOffset);
							e.slideToCanvasWidthRatio = Number(result.presentation.widthRatio);
							e.slideToCanvasHeightRatio = Number(result.presentation.heightRatio);
							trace("****presenter settings [" + e.xOffset + "," + e.yOffset + "," + e.slideToCanvasWidthRatio + "," + e.slideToCanvasHeightRatio + "]");
							dispatcher.dispatchEvent(e);
							*/
						}
						
						if (result.presentations) {
							for(var p:Object in result.presentations) {
								var u:Object = result.presentations[p]
								trace("Presentation name " + u as String);
								userSession.presentationList.addPresentation(u as String);
							}
						}
						
						if (result.presentation.sharing) {
							currentSlide = Number(result.presentation.slide);
							trace("The presenter has shared slides and showing slide " + currentSlide);
							loadPresentationSignal.dispatch(result.presentation.currentPresentation);
						}
					},
					// status - On error occurred
					function(status:Object):void {
						trace("Error occurred:");
						for (var x:Object in status) {
							trace(x + " : " + status[x]);
						}
					}
				) //new Responder
			); //_netConnection.call
		}
		
		private function sendPresentationName(presentationName:String):void {
			trace("sendPresentationName called");
			/*
			var uploadEvent:UploadEvent = new UploadEvent(UploadEvent.CONVERT_SUCCESS);
			uploadEvent.presentationName = presentationName;
			dispatcher.dispatchEvent(uploadEvent)
			*/
		}
		
		/**
		 * Send an event out to the server to go to a new page in the SlidesDeck 
		 * @param page
		 * 
		 */		
		public function gotoSlide(num:int):void {
			trace("send gotoSlide call");
			userSession.mainConnection.connection.call("presentation.gotoSlide",// Remote function name
				new Responder(
					// On successful result
					function(result:Boolean):void {
						if (result) {
							trace("Successfully moved page to: " + num);
						}
					},
					// status - On error occurred
					function(status:Object):void {
						trace("Error occurred:");
						for (var x:Object in status) {
							trace(x + " : " + status[x]);
						}
					}
				), //new Responder
				num
			); //_netConnection.call
		}
		
		/**
		 * A callback method. It is called after the gotoPage method has successfully executed on the server
		 * The method sets the clients view to the page number received 
		 * @param page
		 * 
		 */		
		public function gotoSlideCallback(page:Number):void {
			trace("gotoSlideCallback received");
			userSession.presentationList.currentSlideNum = int(page);
		}
		
		public function getCurrentSlideNumber():void {
			trace("getCurrentSlideNumber called");
			if (currentSlide >= 0) {
				/*
				var e:NavigationEvent = new NavigationEvent(NavigationEvent.GOTO_PAGE)
				e.pageNumber = currentSlide;
				dispatcher.dispatchEvent(e);
				*/
			}
		}
		
		public function sharePresentation(share:Boolean, presentationName:String):void {
			trace("PresentationSOService::sharePresentation()... presentationName=" + presentationName);
			userSession.mainConnection.connection.call("presentation.sharePresentation",// Remote function name
				new Responder(
					// On successful result
					function(result:Boolean):void {
						if (result) {
							trace("Successfully shared presentation");
						}
					},
					// status - On error occurred
					function(status:Object):void {
						trace("Error occurred:");
						for (var x:Object in status) {
							trace(x + " : " + status[x]);
						}
					}
				), //new Responder
				presentationName,
				share
			); //_netConnection.call
		}
		
		public function sharePresentationCallback(presentationName:String, share:Boolean):void {
			trace("sharePresentationCallback " + presentationName + "," + share);
			if (share) {
				loadPresentationSignal.dispatch(presentationName);
			} else {
				//dispatcher.dispatchEvent(new UploadEvent(UploadEvent.CLEAR_PRESENTATION));
			}
		}
		
		public function pageCountExceededUpdateMessageCallback(conference:String, room:String, code:String, presentationName:String, messageKey:String, numberOfPages:Number, maxNumberOfPages:Number):void {
			trace("pageCountExceededUpdateMessageCallback:Received update message " + messageKey);
			/*
			var uploadEvent:UploadEvent = new UploadEvent(UploadEvent.PAGE_COUNT_EXCEEDED);
			uploadEvent.maximumSupportedNumberOfSlides = maxNumberOfPages;
			dispatcher.dispatchEvent(uploadEvent);
			*/
		}
		
		public function generatedSlideUpdateMessageCallback(conference:String, room:String, code:String, presentationName:String, messageKey:String, numberOfPages:Number, pagesCompleted:Number):void {
			trace( "CONVERTING = [" + pagesCompleted + " of " + numberOfPages + "]");
			/*
			var uploadEvent:UploadEvent = new UploadEvent(UploadEvent.CONVERT_UPDATE);
			uploadEvent.totalSlides = numberOfPages;
			uploadEvent.completedSlides = pagesCompleted;
			dispatcher.dispatchEvent(uploadEvent);	
			*/
		}
		
		public function conversionCompletedUpdateMessageCallback(conference:String, room:String, code:String, presentationName:String, messageKey:String, slidesInfo:String):void {
			trace("conversionCompletedUpdateMessageCallback:Received update message " + messageKey);
			userSession.presentationList.addPresentation(presentationName);
			
			/*
			dispatcher.dispatchEvent(new BBBEvent(BBBEvent.PRESENTATION_CONVERTED));
			var readyEvent:UploadEvent = new UploadEvent(UploadEvent.PRESENTATION_READY);
			readyEvent.presentationName = presentationName;
			dispatcher.dispatchEvent(readyEvent);
			*/
		}
		
		public function conversionUpdateMessageCallback(conference:String, room:String, code:String, presentationName:String, messageKey:String):void {
			trace("conversionUpdateMessageCallback:Received update message " + messageKey);
			var totalSlides:Number;
			var completedSlides:Number;
			var message:String;
			//var uploadEvent:UploadEvent;
			
			switch (messageKey) {
				case OFFICE_DOC_CONVERSION_SUCCESS_KEY :
					trace("received Office Doc Conversion Success");
					//uploadEvent = new UploadEvent(UploadEvent.OFFICE_DOC_CONVERSION_SUCCESS);
					//dispatcher.dispatchEvent(uploadEvent);
					break;
				case OFFICE_DOC_CONVERSION_FAILED_KEY :
					trace("received Office Doc Conversion Failed");
					//uploadEvent = new UploadEvent(UploadEvent.OFFICE_DOC_CONVERSION_FAILED);
					//dispatcher.dispatchEvent(uploadEvent);
					break;
				case SUPPORTED_DOCUMENT_KEY :
					trace("received Supported Document");
					//uploadEvent = new UploadEvent(UploadEvent.SUPPORTED_DOCUMENT);
					//dispatcher.dispatchEvent(uploadEvent);
					break;
				case UNSUPPORTED_DOCUMENT_KEY :
					trace("received Unsupported Document");
					//uploadEvent = new UploadEvent(UploadEvent.UNSUPPORTED_DOCUMENT);
					//dispatcher.dispatchEvent(uploadEvent);
					break;
				case GENERATING_THUMBNAIL_KEY :	
					trace("received Generating Thumbnail");
					//dispatcher.dispatchEvent(new UploadEvent(UploadEvent.THUMBNAILS_UPDATE));
					break;		
				case PAGE_COUNT_FAILED_KEY :
					trace("received Page Count Failed");
					//uploadEvent = new UploadEvent(UploadEvent.PAGE_COUNT_FAILED);
					//dispatcher.dispatchEvent(uploadEvent);
					break;	
				case GENERATED_THUMBNAIL_KEY :
					trace("conversionUpdateMessageCallback:GENERATED_THUMBNAIL_KEY " + messageKey);
					break;
				default:
					trace("conversionUpdateMessageCallback:Unknown message " + messageKey);
					break;
			}														
		}	
		
		private function syncHandler():void {
			//		var statusCode:String = event.info.code;
			trace("!!!!! Presentation sync handler");
			getPresentationInfo();
		}
		
		private function connectionSuccessHandler():void {
			getPresentationInfo();
		}
	}
}