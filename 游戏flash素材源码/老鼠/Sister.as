package  {
	
	import flash.display.MovieClip;
	
	
	public class Sister extends Mouse {
		
		
		public function Sister(hole:Hole) {
			// constructor code
			super(hole);
			gotoAndStop(1);
		}
		public function cry():void
		{
			gotoAndStop(2);
		}
	}
	
}
