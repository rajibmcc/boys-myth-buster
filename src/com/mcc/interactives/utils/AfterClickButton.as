package  com.mcc.interactives.utils{
import flash.events.MouseEvent;
import flash.display.SimpleButton;
	
	public class AfterClickButton {

		public static function callBack(button:SimpleButton, callbackFunction:Function, once:Boolean = true) {
			// constructor code
			button.addEventListener(MouseEvent.CLICK, callFunction);
			
			function callFunction(e:MouseEvent):void{
				/*if(once){
					button.removeEventListener(MouseEvent.CLICK, callFunction);
				}*/
				callbackFunction();
			}
		}
	}
}
