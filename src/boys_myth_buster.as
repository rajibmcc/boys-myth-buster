package
{
	import com.bbc_icontent.InfoGame;
	import com.bbc_icontent.Level;
	import com.bbc_icontent.Screen;
	import com.bbc_icontent.events.LevelEvents;
	import com.bbc_icontent.levels.LevelBedroom;
	import com.bbc_icontent.levels.LevelKitchen;
	import com.bbc_icontent.levels.LevelRoomDown;
	import com.bbc_icontent.levels.LevelRoomFloor;
	import com.bbc_icontent.levels.LevelStairs;
	import com.bbc_icontent.screens.ScreenHome;
	import com.mcc.interactives.utils.AfterPlayClip;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class boys_myth_buster extends Sprite
	{
		
		//change this file
		//another change
		private var _currentIdLevel:int;
		private var _levels:Vector.<Class>;
		private var _currentLevel:Level;

		private var homeScreen:ScreenHome;
		private var _movTheEnd:MovieClip;
		
		public function boys_myth_buster()
		{
			_currentIdLevel = -1;
			InfoGame.initializeInfo();
			
			_levels = new Vector.<Class>();
			_levels.push(LevelBedroom, LevelRoomFloor,  LevelStairs, LevelRoomDown, LevelKitchen);
			
			
			homeScreen = new ScreenHome();
			addChild(homeScreen);
			
			homeScreen.show();
			homeScreen.addEventListener(LevelEvents.LEVEL_START, startLevelFromBegining);
		}
		
		private function startLevelFromBegining(e:LevelEvents):void{
			//homeScreen.hide();
			startNextLevel();
		}	
		
		private function startNextLevel():void{
			if(_currentLevel != null){
				var _prevLevel:Level = _currentLevel;
				_currentLevel.removeEventListener(LevelEvents.LEVEL_COMPLETE, goNevtLevel);
				_currentLevel.removeEventListener(LevelEvents.LEVEL_PREVIOUS, goPreviousLevel);
				_prevLevel.destroy();
			}
			
			_currentLevel = nextLevel;

			if(_currentLevel != null){
				_currentLevel.initialize();
				_currentLevel.show();
				addChild(_currentLevel);
				_currentLevel.startLevel();
				_currentLevel.addEventListener(LevelEvents.LEVEL_COMPLETE, goNevtLevel);
				_currentLevel.addEventListener(LevelEvents.LEVEL_PREVIOUS, goPreviousLevel);
			}
			else{
				_movTheEnd = new ScreenTheEnd();
				addChild(_movTheEnd);
				AfterPlayClip.callBack(_movTheEnd, THE_END);
			}
			
		}
		
		private function THE_END():void{
			trace("````````````````````````````````````THE END```````````````````````````````````````````");
		}
		
		
		private function startPreviousLevel():void{
			if(_currentLevel != null){
				var _prevLevel:Level = _currentLevel;
				_currentLevel.removeEventListener(LevelEvents.LEVEL_COMPLETE, goNevtLevel);
				_currentLevel.removeEventListener(LevelEvents.LEVEL_PREVIOUS, goPreviousLevel);
				_prevLevel.destroy();
			}
			
			_currentLevel = prevLevel;
			
			_currentLevel.initialize();
			_currentLevel.show();
			addChild(_currentLevel);
			_currentLevel.startLevel();
			_currentLevel.addEventListener(LevelEvents.LEVEL_COMPLETE, goNevtLevel);
			_currentLevel.addEventListener(LevelEvents.LEVEL_PREVIOUS, goPreviousLevel);
		}
		
		
		private function goPreviousLevel(e:LevelEvents):void{
			startPreviousLevel();
		}
		
		
		private function goNevtLevel(e:LevelEvents):void{
			startNextLevel();
		}
		
		protected function get nextLevel(): Level {
			trace('------------------------------- GETING LEVEL\nTOTAL LEVEL:'+ _levels.length);
			if (_currentIdLevel + 1 < _levels.length) {
				_currentIdLevel++;
				trace('level is Returning...[INDEX:'+_currentIdLevel+']');
				trace('-------------------------------');
				var levelClass:Class = _levels[_currentIdLevel];
				return new levelClass();
			} else {
				trace('level is NULL');
				trace('-------------------------------');
				return null;
			}
		}
		
		protected function get prevLevel(): Level {
			trace('------------------------------- GETING LEVEL\nTOTAL LEVEL:'+ _levels.length);
			if (_currentIdLevel - 1 <= 0) {
				_currentIdLevel--;
				trace('level is Returning...[INDEX:'+_currentIdLevel+']');
				trace('-------------------------------');
				var levelClass:Class = _levels[_currentIdLevel];
				return new levelClass();
			} else {
				trace('level is NULL');
				trace('-------------------------------');
				return null;
			}
		}
	}
}