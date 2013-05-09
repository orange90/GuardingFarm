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
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	public class Index extends BasePage
	{
		private var _indexPage:MovieClip
		public function Index() 
		{
			_indexPage = new IndexRes();
			addChild(_indexPage);
			super();
			_indexPage.start_btn.addEventListener(Event.ADDED_TO_STAGE,flyin);
			_indexPage.rules_btn.addEventListener(Event.ADDED_TO_STAGE,flyin);
			_indexPage.ranking_btn.addEventListener(Event.ADDED_TO_STAGE,flyin);
			_indexPage.start_btn.addEventListener(MouseEvent.CLICK, this.onClick);
			_indexPage.rules_btn.addEventListener(MouseEvent.CLICK, this.onClick);
			_indexPage.ranking_btn.addEventListener(MouseEvent.CLICK, this.onClick);
			
			TweenLite.from(_indexPage.title,1,{x:220, y:-200, ease:Power0.easeOut, alpha:0})
			TweenLite.to(_indexPage.title,1,{x:220, y:50, ease:Power0.easeOut, alpha:1})
			
		}
		private function flyin(event:Event):void
		{
			TweenLite.from(event.target,1,{x:-100, y:event.target.y, ease:Power0.easeOut, alpha:0})
			TweenLite.to(event.target, 0.5, { x:20, y:event.target.y, ease:Power0.easeOut, alpha:1 } )
			/*TweenLite.from(_indexPage.title,1,{x:_indexPage.title.x, y:_indexPage.title.y-200, ease:Power0.easeOut, alpha:0})
			TweenLite.to(_indexPage.title, 0.5, { x:_indexPage.title.x, y:_indexPage.title.y + 200, ease:Power0.easeOut, alpha:1 } )*/
			
		}
		override protected function onClick(event:MouseEvent):void
		{
			TweenLite.from(_indexPage.title,1,{x:220, y:50, ease:Power0.easeOut, alpha:1})
			TweenLite.to(_indexPage.title,0.5,{x:220, y:-200, ease:Power0.easeOut, alpha:0})
			TweenLite.from([_indexPage.start_btn,_indexPage.rules_btn,_indexPage.ranking_btn],0.5,{ ease:Power0.easeOut, alpha:1})
			TweenLite.to([_indexPage.start_btn, _indexPage.rules_btn, _indexPage.ranking_btn], 1, { ease:Power0.easeOut, alpha:0,onComplete:super.onClick, onCompleteParams:[event] } )
																					//动画效果完成后，调用了super.onClick(event)
		}
	}

}