package game.pages 
{
	/**
	 * ...
	 * @author orange
	 */
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	import flash.events.MouseEvent;
	import game.event.*;
	import flash.events.Event;
	import flash.net.*;
	public class WinPage extends BasePage
	{
		private var _win:Win = new Win();
		private var _submit:SubmitRecordRes = new SubmitRecordRes();
		public function WinPage() 
		{
			this.addChild(_win);
			_win.total_score.text = gameProcess.total_score.toString();
			_submit.x = (_win.width - _submit.width) / 2;
			_submit.y = (_win.height - _submit.height) / 2;
			TweenLite.from(_submit, 3, { alpha:0 } );
			TweenLite.to(_submit, 3, { alpha:1 } );
			this.addChild(_submit);
			var _eventHandler:EventHandler = new EventHandler();
			_submit.addEventListener(GameEvent.TO_MAIN, _eventHandler.HandleEvent)
			_submit.confirm.addEventListener(MouseEvent.CLICK, submitScoreHandler)
			_submit.cancel.addEventListener(MouseEvent.CLICK,toMainHandler)
			
		}
		
		private function toMainHandler(event:MouseEvent):void
		{
			_submit.dispatchEvent(new Event(GameEvent.TO_MAIN))
		}
		private function submitScoreHandler(event:MouseEvent):void
		{
			var loader:URLLoader = new URLLoader();
			var postVars:URLVariables = new URLVariables();
			var postReq:URLRequest = new URLRequest();
			if (_submit.your_name.text == "" ||_submit.your_name.text == null)
			{
				postVars.username = "NoName";
			}
			postVars.username = _submit.your_name.text;
			postVars.score = gameProcess.total_score;

			postReq.url = "http://www.liketocode.com/demo/database/store.php";
			postReq.method = URLRequestMethod.POST;
			postReq.data = postVars;

			loader.load(postReq);
			loader.addEventListener(Event.COMPLETE, handleResponse);
			_submit.dispatchEvent(new Event(GameEvent.TO_MAIN))
		}
		private function handleResponse(event:Event):void
		{
			trace(event.target.data);
		}
		
		
		
	}

}