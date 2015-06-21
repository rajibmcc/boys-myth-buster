package com.bbc_icontent {
	import com.bbc_icontent.events.LevelEvents;
	
	import flash.system.System;

	public class Level extends Screen {
		private var _currentCheckPoint: int;
		protected var _checkPoints: Vector.<Class> ;
		protected var _levelId:String ='na';
		
		protected var _currentLevelScreen: Screen;
		protected var _currentFeedbackScreen: ScoreFeedback;
		protected var _currentEndScreen: Screen;
		//
		
		protected var _classCurrentFeedbackScreen: Class;
		protected var _classCurrentEndScreen: Class;

		public function Level() {
			// constructor code
			super();
			_checkPoints = new Vector.<Class>();
			_currentCheckPoint = -1;
		}
		
		/**
		 * Must set the id at first and before initialization
		 * @return void
		 * 
		 */		
		public function set setId(lvl_id:String):void{
			_levelId = lvl_id;
		}
		
		public function get getId():String{
			return _levelId;
		}
		
		override public function initialize(): void {
			trace(_classCurrentFeedbackScreen+' : CLASS : '+_classCurrentEndScreen);
			if(_classCurrentFeedbackScreen != null) _currentFeedbackScreen = new _classCurrentFeedbackScreen();
			if(_classCurrentEndScreen != null) _currentEndScreen = new _classCurrentEndScreen();
		}

		
		public function startLevel():void{			
			_currentLevelScreen = nextLevel;
			if(_currentLevelScreen != null){
				activateScreen();
				trace(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> LEVEL STARTED");
			}
		}
		
		private function goNextLevel(e:LevelEvents):void{
			trace("goNextLevel CALL");
			var prevLevelScreen:Screen = _currentLevelScreen;
			deactivateScreen();
			prevLevelScreen.destroy();
			_currentLevelScreen = nextLevel;			
			prevLevelScreen = null;
			if(_currentLevelScreen != null){
				activateScreen();
			}
			else{
				//No levels to play. Show End screen.
				showEndScreen(null);
			}
		}
		
		private function goPreviousLevel(e:LevelEvents):void{
			var prevLevelScreen:Screen = _currentLevelScreen;
			deactivateScreen();
			prevLevelScreen.destroy();
			_currentLevelScreen = prevLevel;
			prevLevelScreen = null;
			if(_currentLevelScreen != null){
				activateScreen();
			}
			else{
				//No levels to play. Show End screen.
				this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_PREVIOUS));
			}
		}
		
		private function activateScreen():void{
			trace("Activating Screen :::: ////////");
			addChild(_currentLevelScreen);
			_currentLevelScreen.show();
			
			
			_currentLevelScreen.addEventListener(LevelEvents.LEVEL_NEXT, goNextLevel);
			_currentLevelScreen.addEventListener(LevelEvents.LEVEL_PREVIOUS, goPreviousLevel);
			_currentLevelScreen.addEventListener(LevelEvents.LEVEL_RIGHT_MOVE, showPopupRight);
			_currentLevelScreen.addEventListener(LevelEvents.LEVEL_WRONG_MOVE, showPopupWrong);
		}
		
		private function deactivateScreen():void{
			_currentLevelScreen.removeEventListener(LevelEvents.LEVEL_NEXT, goNextLevel);
			_currentLevelScreen.removeEventListener(LevelEvents.LEVEL_PREVIOUS, goPreviousLevel);
			_currentLevelScreen.removeEventListener(LevelEvents.LEVEL_RIGHT_MOVE, showPopupRight);
			_currentLevelScreen.removeEventListener(LevelEvents.LEVEL_WRONG_MOVE, showPopupWrong);
		}
		
		private function showEndScreen(e:LevelEvents):void{
			trace("SHOW END LEVEL ++++++++++++++++++++++++++ TRY : "+_currentEndScreen);
			if(_currentEndScreen == null) {
				this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_COMPLETE));
				return;
			}
			trace("SHOW END LEVEL ++++++++++++++++++++++++++ SUCCESS");
			addChild(_currentEndScreen);
			_currentEndScreen.show();
			_currentEndScreen.addEventListener(LevelEvents.LEVEL_COMPLETE, prepareLevelExit);
		}
		
		private function showPopupRight(e:LevelEvents):void{			
			if(_currentFeedbackScreen == null) return;
			trace("SHOWING RIGHT FEEDBACK---------------------------");
			_currentFeedbackScreen.isCorrect = true;
			_currentFeedbackScreen.scoreMessage = _currentLevelScreen.scoreMessage;
			_currentFeedbackScreen.show();
			addChild(_currentFeedbackScreen);
			_currentFeedbackScreen.addEventListener(LevelEvents.LEVEL_SKIP, closePopup);
		}
		
		private function showPopupWrong(e:LevelEvents):void{
			if(_currentFeedbackScreen == null) return;
			trace("SHOWING WRONG FEEDBACK---------------------------");
			_currentFeedbackScreen.isCorrect = false;
			_currentFeedbackScreen.scoreMessage = _currentLevelScreen.scoreMessage;
			_currentFeedbackScreen.show();
			addChild(_currentFeedbackScreen);
			_currentFeedbackScreen.addEventListener(LevelEvents.LEVEL_SKIP, closePopup);
		}
		
		private function closePopup(e:LevelEvents):void{
			_currentFeedbackScreen.hide();
			_currentLevelScreen.resume();
		}
		
		private function prepareLevelExit(e:LevelEvents):void{
			trace("LEVEL COMPLETED");
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_COMPLETE));
		}
		
		protected function get nextLevel(): Screen {
			trace('------------------------------- GETING LEVEL\nTOTAL LEVEL:'+ _checkPoints.length);
			if (_currentCheckPoint + 1 < _checkPoints.length) {
				_currentCheckPoint++;
				trace('level is Returning...[INDEX:'+_currentCheckPoint+']');
				trace('-------------------------------');
				var levelClass:Class = _checkPoints[_currentCheckPoint];
				return new levelClass();
			} else {
				trace('level is NULL');
				trace('-------------------------------');
				return null;
			}
		}

		protected function get prevLevel(): Screen {
			if (_currentCheckPoint - 1 >= 0) {
				_currentCheckPoint--;
				
				var levelClass:Class = _checkPoints[_currentCheckPoint];
				return new levelClass();
			} else {
				return null;
			}
		}
	}
}