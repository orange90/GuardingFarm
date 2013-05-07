package game.pages 
{
	/**
	 * ...
	 * @author orange
	 */
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import game.event.*;
	public class Index extends BasePage
	{
		private var _indexPage:MovieClip
		public function Index() 
		{
			_indexPage = new IndexRes();
			addChild(_indexPage);
			super();
			_indexPage.start_btn.addEventListener(MouseEvent.CLICK, onClick);
			_indexPage.rules_btn.addEventListener(MouseEvent.CLICK, onClick);
			_indexPage.ranking_btn.addEventListener(MouseEvent.CLICK, onClick);
		}	
	}

}