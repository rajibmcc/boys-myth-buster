package com.bbc_icontent
{
	import com.bbc_icontent.events.LevelEvents;

	public class EndScreen extends Screen
	{
		public function EndScreen()
		{
			super();
		}
		
		public function startSegmentBegining():void{
			
		}
		
		public function startSegmentEnd():void{
			
		}
		
		protected function finished():void{
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_COMPLETE));
		}
	}
}