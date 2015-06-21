package com.bbc_icontent.levels
{
	import com.bbc_icontent.InfoGame;
	import com.bbc_icontent.Level;
	import com.bbc_icontent.screens.ScreenBedroom01;
	import com.bbc_icontent.screens.ScreenBedroom02;
	import com.bbc_icontent.screens.ScreenBedroomEnd;
	import com.bbc_icontent.screens.ScreenBedroomFeedback;
	
	public class LevelBedroom extends Level
	{
		public function LevelBedroom()
		{
			super();
			_classCurrentFeedbackScreen = ScreenBedroomFeedback;
			_classCurrentEndScreen = ScreenBedroomEnd;
			_checkPoints.push(ScreenBedroom01, ScreenBedroom02);
			_levelId = InfoGame.LEVEL_BEDROOM;
		}
	}
}