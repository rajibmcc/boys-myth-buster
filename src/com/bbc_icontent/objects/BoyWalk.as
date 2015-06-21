package com.bbc_icontent.objects
{
	import flash.display.MovieClip;
	import flash.events.Event;

	public class BoyWalk extends MovieClip
	{
		public static var STEP_DONE:String = 'step_done';
		var cX:Number,cY:Number;
		private var _spaceStep:int = 156;
		public function BoyWalk()
		{
			super();
			stop();
		}

		public function stepLeft(cX:Number, cY:Number):void
		{
			mouseEnabled=false;
			gotoAndPlay(2);
			this.cX = cX;
			this.cY = cY;

			addEventListener(Event.ENTER_FRAME, checkSteps);
		}

		private function checkSteps(e:Event):void
		{
			if (currentFrame == 10)
			{
				//x -= 80;

				x +=  cX - x;
				y +=  cY - y;
			}
			if (currentFrame == totalFrames)
			{
				stop();
				removeEventListener(Event.ENTER_FRAME, checkSteps);
				this.dispatchEvent(new Event(STEP_DONE));
			}
		}
	}
}