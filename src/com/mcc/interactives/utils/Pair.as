package  com.mcc.interactives.utils{
	
	public class Pair {
		private var _xValue:Number;
		private var _yValue:Number;
		public function Pair(xValue:Number = 0, yValue:Number = 0) {
			// constructor code
			_xValue = xValue;
			_yValue = yValue;
		}
		
		public function set xValue(value:Number):void{
			_xValue = value;
		}
		
		public function get xValue():Number{
			return _xValue;
		}
		
		public function set yValue(value:Number):void{
			_yValue = value;
		}
		public function get yValue():Number{
			return _yValue;
		}
		
		public function toString():String{
			return '[Object Pair('+_xValue+','+_yValue+')]'; 
		}

	}
	
}
