package org.bigbluebutton.core.util {
	
	import mx.collections.ArrayCollection;
	
	public class VectorUtil {
		/**
		 * Converts a Vector collection to an ArrayCollection.
		 */
		public static function toArrayCollection(toConvert:*):ArrayCollection {
			return new ArrayCollection(toArray(toConvert));
		}
		
		/**
		 * Converts a Vector collection to an array.
		 */
		private static function toArray(toConvert:*):Array {
			var result:Array = [];
			for each (var item:* in toConvert) {
				result.push(item);
			}
			return result;
		}
	}
}
