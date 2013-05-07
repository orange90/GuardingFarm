package  {
	
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	import flash.geom.Point;
	
	public class Mouse extends MovieClip  {
		/*public const holes:Array = new Array(
		            (new Hole(new Point(25,250), false,0.7)),
		            (new Hole(new Point(165,230),false,0.6)),
		            (new Hole(new Point(375,245),false,0.5)),
	                (new Hole(new Point(225,255),false,0.9)),
	                (new Hole(new Point(85,310), false,0.9)),
	                (new Hole(new Point(375,290),false,0.9))
					);*/
		public var inWhichHole:uint;
		public var addTime:int = getTimer();
		public var stayTime:Number;
		
		public function Mouse(hole:Hole) {
			
			inWhichHole = HolePosition.holes.indexOf(hole);
			
			// 按洞大小缩放老鼠
			this.width *=hole.scale;
			this.height *=hole.scale;
			this.x = hole.position.x;
			this.y = hole.position.y;
			
		}
		
		
	}
	
	
}
