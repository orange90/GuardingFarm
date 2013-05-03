package  {
	import flash.geom.Point;
	
	public class Hole {
        public var position:Point;//坐标
		public var is_taken:Boolean;// 判断此洞是否有地鼠占着
		public var scale:Number;//根据洞的大小来缩放地鼠
		public function Hole(position:Point,is_taken:Boolean = false,scale:Number = 1) {
			// constructor code
			this.position = position;
			this.is_taken = is_taken;
			this.scale = scale;
			
		}

	}
	
}
