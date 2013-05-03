package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	
	public class Snake extends Mouse {
		
		private var _timer:Timer = new Timer(500,1);
		private var _add2SecIcon = new Add2Sec();
		private var _minus2SecIcon = new Minus2Sec();
		private var _minus1SecIcon = new Minus1Sec();
		
	    private var _tempX:uint;//需要两个临时的全局变量来传递startFly函数的坐标值。
		private var _tempY:uint;
		
		private var repeat:uint;//用在startFly函数里
		
		public function Snake(hole:Hole) {
			super(hole);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE,removeMess);
		}
		
		
		public function flyAway():void //点击了，飞走
		{
			addEventListener(Event.ENTER_FRAME, fly);
		}
		
		public function makeAMess():void //未点击，捣乱
		{
			addEventListener(Event.ENTER_FRAME, handleMess);
			_timer.start();
		}
		
		private function fly(event:Event):void
		{
			this.rotation+=60;
			this.width -= 10;
			this.height -= 10;
			if(this.width <10 || this.height<10)
			{
				this.visible = false;
			}
		}
		
		private function handleMess(event:Event):void
		{
			this.x += (Math.random()-0.5)*200;
			this.y += (Math.random()-0.5)*200;
		}
		private function removeMess(event:TimerEvent):void
		{
			this.removeEventListener(Event.ENTER_FRAME,handleMess);
			this.visible = false;
		}
		
		
	}
	
}
