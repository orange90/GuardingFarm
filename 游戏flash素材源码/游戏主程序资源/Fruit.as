package  {
	
	import flash.display.MovieClip;
	import flash.geom.Point
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	
	public class Fruit extends MovieClip {
		
		private var _timer:Timer = new Timer(100,10);
		private var _start:Point;
		private var _end:Point;
		private var _repeat:uint = 10;
		public function Fruit() {
			
			_timer.addEventListener(TimerEvent.TIMER,moveIt)
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE,disappear)
			
		}
		public function moveTo(startPoint:Point, endPoint:Point)
		{
			
			_start = startPoint;
			_end = endPoint;
			_timer.start();
			
		}
		private function moveIt(event:TimerEvent):void
		{
			_repeat--;
			this.x = _start.x + (_end.x - _start.x) / 10 * (10 - _repeat);
			this.y = _start.y + (_end.y - _start.y) / 10 * (10 - _repeat);
		}
		private function disappear(event:TimerEvent):void
		{
			this.visible = false;
			this.parent.removeChild(this);
		}
	}
	
}
