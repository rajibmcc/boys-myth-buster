package com.mcc.interactives.utils {
	import flash.display.MovieClip;
	import flash.events.Event;

	public class AfterPlayClip {
		public static function callBack(movieClip: MovieClip, callback: Function = null, stopClipAtEnd: Boolean = true): void {
			movieClip.addEventListener(Event.ENTER_FRAME, checkForFrameEnd);

			function checkForFrameEnd(e: Event): void {
				if (movieClip.currentFrame == movieClip.totalFrames) {
					if (stopClipAtEnd) {
						movieClip.stop();						
					}
					
					movieClip.removeEventListener(Event.ENTER_FRAME, checkForFrameEnd);
					
					if(callback == null) return;
					
					callback();
				}
			}//end checkForFrameEnd
		}
	}
}