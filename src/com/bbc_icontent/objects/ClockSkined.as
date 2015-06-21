package com.bbc_icontent.objects
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	public class ClockSkined extends MovieClip
	{
		private var timer:Timer;
		private var timeTotal:int;
		private var timeRemaining:int;
		private var _alertAt:int;
		private var _remainingTime:int;
		
		private var cMark:Sprite;
		private var dTime:TextField;
		public function ClockSkined()
		{
			super();
			cMark = this.getChildByName("criticalMark") as Sprite;
			dTime = this.getChildByName("time") as TextField;
			cMark.visible = false;
			stop();
		}
		
		/**
		 * Sets up the clock
		 * @param totalTime Int Total time in seconds
		 * 
		 */		
		public function setup(totalTime:int, alertAt:int = -1):void{
			if(timer != null){
				timer.removeEventListener(TimerEvent.TIMER, timerTick);
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timerComplete);
			}
			if(alertAt == -1){
				_alertAt = totalTime*.25;
			}
			else if(alertAt <= -1){
				_alertAt = 0;
			}
			else{
				_alertAt = alertAt;
			}
			
			timeTotal = totalTime;
			timer = new Timer(1000, timeTotal);
			dTime.text = ''+timeTotal;
		}
		
		public function start():void{
			trace(timer.running);
			if(timer.running) return;
			timer.addEventListener(TimerEvent.TIMER, timerTick);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerComplete);
			timer.start();
		}
		
		public function stopClock():void{
			if(timer == null) return;
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, timerTick);
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timerComplete);
		}
		
		public function restart(wait:Boolean = false):void{
			timer.reset();
			cMark.visible = false;
			dTime.text = ''+timeTotal;
			if(!wait){
				start();
			}		
		}
		
		public function destroy():void{
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, timerTick);
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timerComplete);
			timer = null;
			if(this.parent){
				this.parent.removeChild(this);
			}
		}
		
		private function timerComplete(event:TimerEvent):void
		{
			timer.reset();
			timer.removeEventListener(TimerEvent.TIMER, timerTick);
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timerComplete);			
			this.dispatchEvent(new TimerEvent(TimerEvent.TIMER_COMPLETE));
		}
		
		private function onFrame(event:Event):void
		{
			if(currentFrame == totalFrames){
				removeEventListener(Event.ENTER_FRAME, onFrame);
				gotoAndStop(1);
			}
		}
		
		private function timerTick(event:TimerEvent):void{
			trace('............ TICK ..............['+event.currentTarget.currentCount+']');
			this.dispatchEvent(new TimerEvent(TimerEvent.TIMER));
			_remainingTime = timeTotal -Timer(event.currentTarget).currentCount;
			_remainingTime <= _alertAt ? cMark.visible = true : cMark.visible = false;
			
			play();
			dTime.text = '' + _remainingTime;
			addEventListener(Event.ENTER_FRAME, onFrame);
		}
	}
}