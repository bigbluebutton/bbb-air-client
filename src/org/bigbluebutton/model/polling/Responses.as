package org.bigbluebutton.model.polling
{
	public class Responses
	{
		private var _questionID:String;
		private var _responses:Array;
		
		public function Responses(questionID:String, responses:Array) {
			_questionID = questionID;
			_responses = responses;
		}
			
		public function get questionID():String {
			return _questionID;
		}
		
		public function get responseIDs():Array {
			return _responses;
		}
	}
}