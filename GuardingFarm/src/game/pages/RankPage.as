package game.pages 
{
	/**
	 * ...
	 * @author orange
	 */
    import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	public class RankPage extends BasePage
	{
		private var _rankPage:MovieClip
		public function RankPage() 
		{
			_rankPage = new RankPageRes();
			
			TweenLite.from(_rankPage.world_ranking,1,{x:-100, y:22.65, ease:Power0.easeOut, alpha:0})
			TweenLite.to(_rankPage.world_ranking, 0.5, { x:14.2, y:22.65, ease:Power0.easeOut, alpha:1 } )
			TweenLite.from(_rankPage.my_ranking,1,{x:1000, y:10.65, ease:Power0.easeOut, alpha:0})
			TweenLite.to(_rankPage.my_ranking, 0.5, { x:432.2, y:10.65, ease:Power0.easeOut, alpha:1 } )
			TweenLite.from(_rankPage.ranking_friend,1,{x:1000, y:257, ease:Power0.easeOut, alpha:0})
			TweenLite.to(_rankPage.ranking_friend, 0.5, { x:432.2, y:257, ease:Power0.easeOut, alpha:1 } )
			
			addChild(_rankPage);
			super();
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
	}

}