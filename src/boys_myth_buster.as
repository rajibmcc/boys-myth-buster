package
{
	import com.bbc_icontent.Screen;
	import com.bbc_icontent.events.LevelEvents;
	import com.bbc_icontent.screens.ScreenBedroom;
	import com.bbc_icontent.screens.ScreenHome;
	import com.bbc_icontent.screens.ScreenRoomFloor;
	import com.mcc.interactives.component.TextLine;
	
	import flash.display.Sprite;
	
	public class boys_myth_buster extends Sprite
	{
		private var currentLevel:int;

		private var homeScreen:ScreenHome;
		
		public function boys_myth_buster()
		{
			currentLevel = 0;
			
			homeScreen = new ScreenHome();
			addChild(homeScreen);
			
			homeScreen.show();
			homeScreen.addEventListener(LevelEvents.LEVEL_START, startLevelFromBegining);
		}
		
		private function startLevelFromBegining(e:LevelEvents):void{
			trace("GAME STARTED");
			
			homeScreen.hide();
			
			/*var sb:ScreenBedroom = new ScreenBedroom();
			addChild(sb);
			sb.show();*/
			
			var sf:ScreenRoomFloor = new ScreenRoomFloor();
			addChild(sf);
		}
	}
}