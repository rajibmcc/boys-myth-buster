package com.bbc_icontent.screens {

	import com.bbc_icontent.Screen;
	import com.bbc_icontent.custom_elements.DropTargetJigsaw;
	import com.bbc_icontent.events.LevelEvents;
	import com.bbc_icontent.objects.ClockSkined;
	import com.mcc.interactives.IEvents.TextLineEvents;
	import com.mcc.interactives.component.TextLine;
	import com.mcc.interactives.utils.AfterPlayClip;
	import com.mcc.interactives.utils.DelayCall;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;

//Edited in FB
	public class ScreenDownStair03 extends Screen {
		private var sec: int;
		private var remTime: int;
		private var quizTime: ClockSkined;
		private var screenStart: ScreenGameStart;

		private var placeHolders: Vector.<DropTargetJigsaw>;
		private var dragables: Vector.<Sprite>;

		private var storePositions: Vector.<Point>;
		private var dragCurrent: Sprite;
		private var placeTarget: DropTargetJigsaw;
		private var placedTotal: int;
		private var dragOffsetX: Number;
		private var dragOffsetY: Number;
		private var dragActive: Boolean;
		
		private var _textline:TextLine;

		public function ScreenDownStair03() {
			// constructor code
			sec = 40;
			quizTime = clock as ClockSkined;
			quizTime.setup(sec, 5);
			quizTime.visible = false;
			//clock.visible = false;
			//clock.criticalMark.visible = false;
			//clock.time.text = '' + sec;
			screenStart = content_mc as ScreenGameStart;
			screenStart.visible = false;

			placeHolders = new Vector.<DropTargetJigsaw>();
			dragables = new Vector.<Sprite>();
			storePositions = new Vector.<Point>();

			//external swf name for message before showing score
			_textline = textline as TextLine;
			_textline.visible = false;
			
			scoreMax = 1;
		}

		override public function show(): void {
			screenStart.visible = true;
			addChild(screenStart);
			screenStart.addEventListener(LevelEvents.LEVEL_START, prepareQuiz);
		}
		

		private function prepareQuiz(e:LevelEvents): void {
			trace('Content play completed');
			screenStart.removeEventListener(LevelEvents.LEVEL_START, prepareQuiz);
			removeChild(screenStart);
			placeHolders.push(plc01, plc02, plc03, plc04, plc05, plc06, plc07, plc08, plc09);
			dragables.push(exp01, exp02, exp03, exp04, exp05, exp06, exp07, exp08, exp09);
			
			
			//swap random position 
			/*for (var i:int = 0; i < dragables.length; i++) {
				storePositions.push(new Point(dragables[i].x, dragables[i].y));
			}*/
			
								
			//store position for reset
			for (var i:int = 0; i < dragables.length; i++) {
				storePositions.push(new Point(dragables[i].x, dragables[i].y));
			}		
			
			startQuiz();
		}
		
		private function startQuiz():void{
			clock.visible = true;
			placedTotal = 0;
			quizTime.addEventListener(TimerEvent.TIMER_COMPLETE, timesUp);
			
			quizTime.start();
			enableDraging();
		}
		
		private function resetDragables():void{
			for(var i:int = 0; i<dragables.length; i++){
				dragables[i].mouseEnabled = true;
				dragables[i].x = storePositions[i].x;
				dragables[i].y = storePositions[i].y;
				placeHolders[i].empty = true;
			}
		}

		private function enableDraging(): void {
			for (var i: int = 0; i < dragables.length; i++) {
				//trace('>>>>>>> ' + dragables[i].name);
				dragables[i].addEventListener(MouseEvent.MOUSE_DOWN, stickWithPointer);
			}
		}

		private function stickWithPointer(e: MouseEvent): void {
			trace('MOUSE DOWN happend');
			if (!dragActive) {
				dragCurrent = e.currentTarget as Sprite;
				addChild(dragCurrent);

				dragCurrent.removeEventListener(MouseEvent.MOUSE_DOWN, stickWithPointer);
				dragActive = true;
				dragOffsetX = dragCurrent.x - stage.mouseX;
				dragOffsetY = dragCurrent.y - stage.mouseY;
				stage.addEventListener(MouseEvent.MOUSE_MOVE, dragOverStage);
				stage.addEventListener(MouseEvent.MOUSE_UP, dragCompleted);
			} 
			else return;
		}

		private function dragOverStage(e: MouseEvent): void {
			dragCurrent.x = dragOffsetX + stage.mouseX;
			dragCurrent.y = dragOffsetY + stage.mouseY;
			checkCollision(dragCurrent);
		}
		private function dragCompleted(e: MouseEvent): void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragOverStage);
			stage.removeEventListener(MouseEvent.MOUSE_UP, dragCompleted);
			dragCurrent.addEventListener(MouseEvent.MOUSE_DOWN, stickWithPointer);
			placeTarget = checkCollision(dragCurrent);
			var index:int;
			if(placeTarget != null && placeTarget){
				var nameTarget:String = placeTarget.name;
				var nameObject:String = dragCurrent.name;
				if(nameTarget.substr(3) == nameObject.substr(3)){
					dragCurrent.x = placeTarget.x ;//+ placeTarget.width*.5 - dragCurrent.width*.5;
					dragCurrent.y = placeTarget.y ;//+ placeTarget.height*.5 - dragCurrent.height*.5;
					trace(dragCurrent.x +" "+ placeTarget.x+"<>"+dragCurrent.y +" " + placeTarget.y);
					placeTarget.empty = false;
					dragCurrent.mouseEnabled = false;
					placedTotal++;
					if(placedTotal == placeHolders.length){
						quizTime.stopClock();
						DelayCall.call(allPlaced, 1);
					}
				}
				else{
					index = dragables.indexOf(dragCurrent);
					trace(storePositions[index].x +'  ::  '+storePositions[index].y);
					dragCurrent.x = storePositions[index].x;
					dragCurrent.y = storePositions[index].y;
				}
				
			}
			else{
				index = dragables.indexOf(dragCurrent);
				trace(storePositions[index].x +'  ::  '+storePositions[index].y);
				dragCurrent.x = storePositions[index].x;
				dragCurrent.y = storePositions[index].y;
			}
			//trace(placeTarget);
			dragActive = false;
			restoreAlpha();
		}
		
		private function allPlaced():void{
			_textline.visible = true;
			_textline.appear();
			
			_textline.addEventListener(TextLineEvents.TEXTLINE_DISAPPEARED, prepareExit);
			_textline.addEventListener(TextLineEvents.TEXTLINE_END, prepareExit);
		}
		
		private function prepareExit(e:TextLineEvents):void{
			if(e.type == TextLineEvents.TEXTLINE_END) {
				_textline.disAppear();
				return;
			}
			
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));
		}
		
		private function checkCollision(movingObject:Sprite):DropTargetJigsaw{
			var mObject:Sprite = movingObject;
			var targetObject:DropTargetJigsaw;
			var dx:Number = 0;
			var dy:Number = 0;
			var distance:Number = 0;
			var range:Number = 65;
			
			for(var i:int = 0; i<placeHolders.length; i++){
				targetObject = placeHolders[i] as DropTargetJigsaw;
				dx = movingObject.x - targetObject.x;
				dy = movingObject.y - targetObject.y;
				
				distance = Math.sqrt(dx*dx + dy*dy);
				if(distance < range && targetObject.empty){
					targetObject.alpha = .2;
					return targetObject;
				}
				else{
					targetObject.alpha = 1;
				}				
			}
			
			return null;
		}
		
		
		
		
		private function restoreAlpha():void{
			for(var i:int = 0; i<placeHolders.length; i++){
				placeHolders[i].alpha = 1;
			}
		}

		override public function restartPartial(): void {			
			quizTime.restart(true);
			resetDragables();
			startQuiz();
		}
		
		override public function hide():void
		{
			// TODO Auto Generated method stub
			super.hide();
			quizTime.stopClock();
			quizTime.removeEventListener(TimerEvent.TIMER_COMPLETE, timesUp);
		}
		
		
		/*function updateTime(e: TimerEvent): void {
			remTime = sec - e.currentTarget.currentCount;
			clock.time.text = '' + remTime;
			clock.play();
			if (remTime < 4) {
				clock.criticalMark.visible = true;
			}
		}*/

		function timesUp(e: TimerEvent): void {
			
				if(placedTotal == placeHolders.length){
						quizTime.stopClock();
						DelayCall.call(allPlaced, 1);
				}else{
					this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_TIMEUP));
				}
				
		}
	}
}