package com.pages 
{
	/**
	 * ...
	 * @author orange
	 */
    import flash.display.MovieClip;
	import flash.events.MouseEvent;
	public class RankPage extends basePage
	{
		private var _rankPage:MovieClip
		public function RankPage() 
		{
			_rankPage = new RankPageRes();
			addChild(_rankPage);
			super();
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
	}

}