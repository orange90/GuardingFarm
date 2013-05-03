package  {
	import flash.geom.Point;
	public class gameProcess {
		public static var level:uint = 1;
		public static var total_score:uint = 0;;
		//地鼠出现的位置（下面六个坐标对应图中六个洞，其坐标位置经过测试有效）
		public static const holes:Array = new Array(
		    (new Hole(new Point(25,250), false,0.7)),
		    (new Hole(new Point(165,230),false,0.6)),
		    (new Hole(new Point(375,245),false,0.5)),
	        (new Hole(new Point(225,255),false,0.9)),
	        (new Hole(new Point(85,310), false,0.9)),
	        (new Hole(new Point(375,290),false,0.9))
        );
		public static var appleScore:uint = 0;
		public static var cabbageScore:uint = 0;
		public static var pearScore:uint = 0;
		public static var ternipScore:uint = 0;
		public static var carrotScore:uint = 0;
		public static var pumpkidsScore:uint = 0;
		public static var mangoScore:uint = 0;
		public static var watermelonScore:uint = 0;
		public static var eggplantScore:uint = 0;
	}
	
}
