package com.bbc_icontent.levels
{
	import com.bbc_icontent.InfoGame;
	import com.bbc_icontent.Level;
	import com.bbc_icontent.screens.ScreenBedroomFeedback;
	import com.bbc_icontent.screens.ScreenRoomFloor02;
	import com.bbc_icontent.screens.ScreenRoomFloorEnd;
	
	public class LevelRoomFloor extends Level
	{
		public function LevelRoomFloor()
		{
			super();
			
			_classCurrentEndScreen = ScreenRoomFloorEnd;
			_checkPoints.push(ScreenRoomFloor02);
			_levelId = InfoGame.LEVEL_ROOMFLOOR;
		}
	}
}