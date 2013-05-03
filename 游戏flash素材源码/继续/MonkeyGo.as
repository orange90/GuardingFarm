package  {
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.MovieClip;


	public class MonkeyGo extends MovieClip
	{
		
        private const point1:Point = new Point(20,40);
		private const point2:Point = new Point(150,100);
		private const point3:Point = new Point(260,0);
		private const point4:Point = new Point(320,100);
		private var thisLevel:uint = 1;
		private var _PointVector:Vector.<Point> = new Vector.<Point>();
		private var _moveStep:uint = 10;
		public function MonkeyGo()
		{
			//_PointVector = new Vector[point1,point2,point3,point4];
		    _PointVector.push(point1);
			_PointVector.push(point2);
			_PointVector.push(point3);
			_PointVector.push(point4);
			//moveToLevel(3);//仅可移动到第2，3，4关，其他关无效
		}
		public function moveToLevel(level:uint):void
		{
			/*if (level < 2 || level >4)
			{
				throw new Error("小哲温馨提醒：没那么多关喔");
			}*/
			monkey.x = _PointVector[level-2].x;
			monkey.y = _PointVector[level-2].y;
			thisLevel = level;
			var timer:Timer = new Timer(100,_moveStep)
			timer.addEventListener(TimerEvent.TIMER, handleMonkeyGo)
			timer.start();
		}
		private function handleMonkeyGo(event:TimerEvent):void
		{
			var thisPoint:Point = _PointVector[thisLevel-2]
			var nextPoint:Point = _PointVector[thisLevel-1];
			_moveStep--;
			monkey.x =thisPoint.x + (nextPoint.x - thisPoint.x)/10 * (10 - _moveStep);
			monkey.y =thisPoint.y + (nextPoint.y - thisPoint.y)/10 * (10 - _moveStep);
		}

	}
	
}
