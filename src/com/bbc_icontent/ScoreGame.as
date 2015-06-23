package com.bbc_icontent
{
	import flash.net.SharedObject;
	import flash.utils.Dictionary;

	public class ScoreGame
	{
		private static var SCORE_LEVELS:Dictionary;
		private static var sharedObjectScore:SharedObject;
		private static var soId:String = 'bmb_001';
		public static function initializeScore():void{	
			sharedObjectScore = SharedObject.getLocal(soId);
			if(sharedObjectScore.data.score != undefined && 1>5){
				trace('Hello'+ sharedObjectScore.data.score);
				SCORE_LEVELS = sharedObjectScore.data.score as Dictionary;
			}
			else{
				SCORE_LEVELS = new Dictionary();
				// score limit is predefined.
				SCORE_LEVELS[InfoGame.LEVEL_ROOM_DOWNSTAIRS] = new ScoreLevel(0, 3);
				SCORE_LEVELS[InfoGame.LEVEL_BEDROOM] = new ScoreLevel(0, 9);
				SCORE_LEVELS[InfoGame.LEVEL_STAIRS] = new ScoreLevel(0, 4);
				SCORE_LEVELS[InfoGame.LEVEL_KITCHEN] = new ScoreLevel(0, 16);
				SCORE_LEVELS[InfoGame.LEVEL_ROOMFLOOR] = new ScoreLevel(0, 0);
				
				var totalScore:int = 0;
				for(var key:Object in SCORE_LEVELS){
					totalScore += ScoreLevel(SCORE_LEVELS[key]).scoreLimit;
				}
				trace('Calculated TOTAL SCORE : '+totalScore);
				SCORE_LEVELS[InfoGame.LEVEL_ALL] = new ScoreLevel(0, totalScore);
				trace('SAVING for the first TIME');
				saveScore();
			}			
		}
		
		public static function getGrade():int{
			var scoreLevel:ScoreLevel = getScore(InfoGame.LEVEL_ALL);
			var pers:int = scoreLevel.scoreCurrent/scoreLevel.scoreLimit * 100;
			
			trace("GRADE OBTAINED : "+pers);
			
			if(pers > 80){
				scoreLevel = null;
				trace("GRADE A");
				return 3;
			}
			else if( pers > 50){
				trace("GRADE B");
				scoreLevel = null;
				return 2;
			}
			else {
				trace("GRADE C");
				scoreLevel = null; return 1;
			}
		}
		
		public static function getScore(levelId:String):ScoreLevel{
			return SCORE_LEVELS[levelId] as ScoreLevel;
		}
		
		public static function getScoreString(levelId:String):String{
			return SCORE_LEVELS[levelId].scoreString;
		}
		
		public static function setScore(levelId:String, score:ScoreLevel):void{
			//ScoreLevel(SCORE_LEVELS[levelId]).scoreCurrent
			SCORE_LEVELS[levelId] = score;
		}
		
		public static function updateScore(score:int):void{
			var scoreCalculation:ScoreLevel = SCORE_LEVELS[InfoGame.LEVEL_ALL] as ScoreLevel;
			scoreCalculation.scoreCurrent += score;
			
			SCORE_LEVELS[InfoGame.LEVEL_ALL] = new ScoreLevel(scoreCalculation.scoreCurrent, scoreCalculation.scoreLimit);
			
			saveScore();
		}
		
		public static function saveScore():void{
			//save to shared object
			return;
			trace('Score saving to shared object .......... ');
			sharedObjectScore.data.score = SCORE_LEVELS;
			sharedObjectScore.flush();
		}
	}
}