package com.bbc_icontent.levels
{
	import com.bbc_icontent.InfoGame;
	import com.bbc_icontent.Level;
	import com.bbc_icontent.screens.ScreenDownStair01;
	import com.bbc_icontent.screens.ScreenDownStair02;
	import com.bbc_icontent.screens.ScreenDownStair03;
	import com.bbc_icontent.screens.ScreenDownStairEnd;
	
	public class LevelRoomDown extends Level
	{
		public function LevelRoomDown()
		{
			super();
			
			_classCurrentEndScreen = ScreenDownStairEnd;
			_checkPoints.push(ScreenDownStair01, ScreenDownStair02, ScreenDownStair03);
			_levelId = InfoGame.LEVEL_ROOM_DOWNSTAIRS;
		}
	}
}