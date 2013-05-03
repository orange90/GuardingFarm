package 
{

	import flash.display.MovieClip;
	import flash.ui.Mouse;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.Stage;

	public class test extends MovieClip
	{

		private var mc1:Shovel = new Shovel();
		public function test()
		{
			// constructor code
			flash.ui.Mouse.hide();
           // addChild(s);
			
			mc1.x = -20;
			mc1.y = -20;
			stage.addChild( mc1 );

			stage.addEventListener(Event.ENTER_FRAME,onframe);


			stage.addEventListener(Event.ENTER_FRAME,onframe);
			//stage.addEventListener( MouseEvent.CLICK, onStageClickHandler );


			//addEventListener(MouseEvent.MOUSE_MOVE, useShovel);
		}
		function onStageClickHandler( _e:MouseEvent ):void
		{
			mc1.play();
		}



		//stage.addEventListener( MouseEvent.CLICK, onStageClickHandler );
		function onframe(e:Event)
		{
			mc1.x = mouseX;
			mc1.y = mouseY;

		}
		

		/*function useShovel(e:MouseEvent)
		{
		s.x = mouseX;
		s.y = mouseX;
		//trace( e.target.x, e.target.y);
		
		}*/
	}

}