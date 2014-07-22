package org.bigbluebutton.model.polling
{
	import mx.collections.ArrayCollection;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	public class PollModel
	{
		public static const POLL_CREATED:int = 0;
		public static const POLL_DESTROYED:int = 1;
		public static const POLL_STARTED:int = 2;
		public static const POLL_STOPPED:int = 3;
		public static const POLL_UPDATED:int = 4;
		public static const POLL_RESULTS_UPDATED:int = 5;
		public static const I_RESPONDED_TO_POLL:int = 6;
		
		public var pollsChangedSignal:ISignal = new Signal();
		public var responseToPollSignal:ISignal = new Signal();
		
		private var _polls:ArrayCollection;
		
		public function PollModel() {
			_polls = new ArrayCollection();
		}
		
		public function get Polls():ArrayCollection {
			return _polls;
		}
		
		public function createPoll(poll:Poll):void {
			if(poll && !hasPoll(poll.id)) {
				_polls.addItem(poll);
			}
			
			pollsChangedSignal.dispatch(POLL_CREATED, poll.id);
		}
		
		public function destroyPoll(pollID:String):void {
			if(hasPoll(pollID)) {
				_polls.removeItemAt(getPollIndex(pollID));
			}
			
			pollsChangedSignal.dispatch(POLL_DESTROYED, pollID);
		}
		
		public function startPoll(pollID:String):void {
			if(hasPoll(pollID)) {
				var poll:Poll = getPoll(pollID);
				poll.start();
			}
			
			pollsChangedSignal.dispatch(POLL_STARTED, pollID);
		}
		
		public function stopPoll(pollID:String):void {
			if(hasPoll(pollID)) {
				var poll:Poll = getPoll(pollID);
				poll.stop();
			}
			
			pollsChangedSignal.dispatch(POLL_STOPPED, pollID);
		}
		
		public function updatePoll(poll:Poll):void {
			if(hasPoll(poll.id)) {
				_polls.removeItemAt(getPollIndex(poll.id));
				_polls.addItem(poll);
			}
			
			pollsChangedSignal.dispatch(POLL_UPDATED, poll.id);
		}
		
		public function updateResults(pollID:String, questionID:String, responseID:String, responder:Responder):void {
			if(hasPoll(pollID)) {
				var poll:Poll = getPoll(pollID);
				poll.updateResults(questionID, responseID, responder);
			}
			
			responseToPollSignal.dispatch(pollID, questionID, responseID);
		}
		
		public function getPoll(pollID:String):Poll {
			if(hasPoll(pollID)) {
				return _polls.getItemAt(getPollIndex(pollID)) as Poll;
			}
			return null;
		}
		
		private function getPollIndex(pollID:String):int {
			for(var i:int = 0; i < _polls.length; i++) {
				var p:Poll = _polls.getItemAt(i) as Poll;
				if(p && p.id == pollID) {
					return i;
				}
			}
			return -1;
		}
		
		public function hasPoll(pollID:String):Boolean {
			for(var i:int = 0; i < _polls.length; i++) {
				var p:Poll = _polls.getItemAt(i) as Poll;
				if(p && p.id == pollID) {
					return true;
				}
			}
			return false;
		}
		
		public function userHasResponded(pollID:String):void {
			for(var i:int = 0; i < _polls.length; i++) {
				var p:Poll = _polls.getItemAt(i) as Poll;
				if(p && p.id == pollID) {
					p.userResponded();
				}
			}
			
			pollsChangedSignal.dispatch(I_RESPONDED_TO_POLL, pollID);
		}
		
		public function hasUserResponded(pollID:String):Boolean {
			for(var i:int = 0; i < _polls.length; i++) {
				var p:Poll = _polls.getItemAt(i) as Poll;
				if(p && p.id == pollID) {
					return p.hasResponded;
				}
			}
			return false;       
		}
		
	}
}