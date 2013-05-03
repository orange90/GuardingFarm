package  {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	
	public class Timing extends MovieClip {
		
		
		private var _timer:Timer = new Timer(100,10);
		private var _start:Point;
		private var _end:Point = new Point(0,0);
		private var _repeat:uint = 10;
		
		public function Timing() {
			_timer.addEventListener(TimerEvent.TIMER,moveIt)
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE,disappear)
		}
		protected function fly():void
		{
		    start = new Point(this.x,this.y);
			_timer.start();
		}
		private function MoveIt():void
		{
			repeat--;
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
