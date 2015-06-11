package  com.mcc.interactives.utils{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class DelayCall {
		private static var delayTimer:Timer = null;
		private static var _callBack:Function = null;
		/**
		 * 
		 * @param callBack Function calls after delayed time.
		 * @param delaytime Number delaytime in seconds.
		 * 
		 */		
		public static function call(callBack:Function, delaytime:Number):void {
			// constructor code
			_callBack = callBack;
			delayTimer = new Timer(1000*delaytime, 1);
			delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, delayTimerDone);
			delayTimer.start();
		}
		
		private static function delayTimerDone(e:TimerEvent):void{
			_callBack();
			kill();
		}
		public static function kill():void{
			if(delayTimer == null) return;
			
			delayTimer.stop();
			delayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, delayTimerDone);
			_callBack = null;
			delayTimer = null;
		}
	}
	
}
