package com.bbc_icontent.objects
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class BoyWalk extends MovieClip
	{
		public static var STEP_DONE:String = 'step_done';
		
		private var _spaceStep:int = 156;
		public function BoyWalk()
		{
			super();
			stop();
		}
		
		public function stepLeft():void{
			gotoAndPlay(2);
			x -= 76;
			addEventListener(Event.ENTER_FRAME, checkSteps);
		}
		
		private function checkSteps(e:Event):void{
			if(currentFrame == 10){
				x -= 80;
			}
			if(currentFrame == totalFrames){
				stop();
				removeEventListener(Event.ENTER_FRAME, checkSteps);
				this.dispatchEvent(new Event(STEP_DONE));
			}
		}
	}
}