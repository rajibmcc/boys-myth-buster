package  com.mcc.interactives.utils{
	
	public class SuffleArray {
		public static function doSuffle(arr:Array):Array{
			var _numArrItems:int = arr.length;
			var _arr:Array = new Array().concat(arr);
			//_arr = _arr.concat(arr);			
			var objectA:*;			
			var index:int;
			
			for(var i:int = 0; i< _numArrItems; i++){
				index = Math.floor(Math.random()*_numArrItems);
				objectA = _arr.splice(index, 1);				
				_arr.push(objectA);
			}
			
			return _arr;
		}
	}
	
}
