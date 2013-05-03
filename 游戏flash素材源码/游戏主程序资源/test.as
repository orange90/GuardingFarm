package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import flash.events.Event;
	
	public class test extends MovieClip {
		
		var i:uint = 0;
		public function test() {
			// constructor code
			var startTime:uint = getTimer()
			var apple = new Apple();
			addChild(apple);
			apple.moveTo(new Point(0,0),new Point(200,200));
			addEventListener(Event.ENTER_FRAME,kaka)
			
			
			
		}
		private function kaka(event:Event)
		{
			i++;
			if (i == 24)
			{
				var cabbage:Ternip = new Ternip();
				addChild(cabbage);
				cabbage.moveTo(new Point(0,0),new Point(0,400));
			}
		}
		
		
	}
	
}
