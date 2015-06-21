package com.bbc_icontent.levels
{
	import com.bbc_icontent.InfoGame;
	import com.bbc_icontent.Level;
	import com.bbc_icontent.screens.ScreenStairs01;
	import com.bbc_icontent.screens.ScreenStairs02;
	import com.bbc_icontent.screens.ScreenStairsFeedback;
	
	public class LevelStairs extends Level
	{
		public function LevelStairs()
		{
			super();
			_classCurrentFeedbackScreen = ScreenStairsFeedback;
			_checkPoints.push(ScreenStairs01, ScreenStairs02);
			_levelId = InfoGame.LEVEL_STAIRS;
		}
	}
}