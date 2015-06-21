package com.bbc_icontent.levels
{
	import com.bbc_icontent.InfoGame;
	import com.bbc_icontent.Level;
	import com.bbc_icontent.screens.ScreenKitchen01;
	import com.bbc_icontent.screens.ScreenKitchen02;
	import com.bbc_icontent.screens.ScreenKitchen03;
	import com.bbc_icontent.screens.ScreenKitchen04;
	import com.bbc_icontent.screens.ScreenKitchenFeedback;
	
	public class LevelKitchen extends Level
	{
		public function LevelKitchen()
		{
			super();
			_classCurrentFeedbackScreen = ScreenKitchenFeedback;
			_checkPoints.push(ScreenKitchen01, ScreenKitchen02, ScreenKitchen03, ScreenKitchen04);
			_levelId = InfoGame.LEVEL_KITCHEN;
		}
	}
}