package  com.bbc_icontent.screens{
	import flash.display.Shape;
	
	public class Darker extends Shape{
		private var _alpha:Number;
		private var _width:int;
		private var _height:int;
		
		public function Darker(width_darker:int = 1280, height_darker:int = 720, alpha_value:Number = .4) {
			// constructor code
			_alpha = alpha_value;
			_width = width_darker;
			_height = height_darker;
			
			draw();
		}
		
		public function draw():void{
			graphics.clear();
			graphics.beginFill(0x000000, _alpha);
			graphics.drawRect(0, 0, _width, _height);
			graphics.endFill();
		}

	}
	
}
