package  {
	import flash.geom.Point;
	public class HolePosition {

		//地鼠出现的位置（下面六个坐标对应图中六个洞，其坐标位置经过测试有效）
		public static const holes:Array = new Array(
		    (new Hole(new Point(25,250), false,0.7)),
		    (new Hole(new Point(165,230),false,0.6)),
		    (new Hole(new Point(375,245),false,0.5)),
	        (new Hole(new Point(225,255),false,0.9)),
	        (new Hole(new Point(85,310), false,0.9)),
	        (new Hole(new Point(375,290),false,0.9))
			)
		

	}
	
}
