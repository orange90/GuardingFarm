package  {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	
	public class Timing extends MovieClip {
		
		
		private var _timer:Timer = new Timer(50,20);
		private var _start:Point;
		private var _end:Point = new Point(0,0);
		private var _repeat:uint = 20;
		
		public function Timing() 
		{
			_timer.addEventListener(TimerEvent.TIMER,moveIt)
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE,disappear)
		}
		public function moveTo(startPoint:Point, endPoint:Point):void
		{
		    _start = new Point(startPoint.x,startPoint.y);;
			_end = endPoint;
			_timer.start();
		}
		private function moveIt(event:TimerEvent):void
		{
			_repeat--;
			this.x = _start.x + (_end.x - _start.x) / 20 * (20 - _repeat);
			this.y = _start.y + (_end.y - _start.y) / 20 * (20 - _repeat);
		}
		private function disappear(event:TimerEvent):void
		{
			this.visible = false;
			this.parent.removeChild(this);
		}
	}
	
}
