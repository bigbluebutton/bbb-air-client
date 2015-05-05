package org.bigbluebutton.testing {
	
	import org.mockito.integrations.mock;
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.localEventMap.api.IEventMap;
	
	public class MediatorTests {
		/**
		 * Sets the dependencies on a mediator ensuring it has
		 * all the dependencies that the RL framework will provide
		 * when the application is running.
		 */
		protected function setupMediator(mediator:Mediator):void {
			mediator.eventMap = mock(IEventMap);
		}
	}
}
