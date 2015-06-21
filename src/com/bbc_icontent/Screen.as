package  com.bbc_icontent{
	import com.bbc_icontent.events.LevelEvents;
	
	import flash.display.Sprite;
	
	//CHEAT----------- BEGIN
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	//CHEAT----------- END
		
	public class Screen extends Sprite{
		public var _loadablepath:String = 'no_external';
		//-------------- SCORE MESSAGE DISPLAY ------------//
		//derived. use text string instead of lib linkage. 
		//public var levelScoreClass:Class = null;		//
		//proposed.
		private var _scoreMessage:String="common";
		//-------------- SCORE MESSAGE DISPLAY ------------//
		private var _scoreValue:int = 0;
		protected var _scoreMax:int = 0;
		
		
		public function Screen() {
			super();
			
			//CHEAT
			addEventListener(Event.ADDED_TO_STAGE, cheatEnable);
			//
		}
		
		private function cheatEnable(e:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE, cheatEnable);
			stage.addEventListener(KeyboardEvent.KEY_UP, cheat);
		}
		
		private function cheat(e:KeyboardEvent):void{
			switch(e.keyCode)
			{
				case Keyboard.N:
				{
					this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));
					break;
				}
					
				case Keyboard.P:
				{
					this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_PREVIOUS));
					break;
				}
					
				default:
				{
					break;
				}
			}
		}
		//CHEAT----------- END

		public function get scoreMax():int
		{
			return _scoreMax;
		}

		public function set scoreMax(value:int):void
		{
			_scoreMax = value;
		}

		public function initialize():void{
			
		}
		
		public function show():void{
			this.visible = true;
		}
		
		public function hide():void{
			this.visible = false;
		}		
		
		public function restartPartial():void{
			
		}
		
		public function pause():void{
			
		}
		
		public function reset():void{
			_scoreValue = 0;
		}
		
		public function resume():void{
			
		}
		
		public function destroy():void{
			if(this.parent != null) this.parent.removeChild(this);
		}
		
		public function get scoreValue():int
		{
			return _scoreValue;
		}
		
		public function set scoreValue(value:int):void
		{
			_scoreValue = value;
		}
		public function scoreValueIncreaseByOne():void{
			_scoreValue++;
		}
		
		public function get scoreMessage():String
		{
			return _scoreMessage;
		}
		
		public function set scoreMessage(value:String):void
		{
			_scoreMessage = value;
		}
		
		public function set loadablepath(value:String):void{
			_loadablepath = value;
		}
		
		
		public function get loadablepath():String{
			return _loadablepath;
		}
	}
	
}