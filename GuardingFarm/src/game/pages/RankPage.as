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
	import flash.events.Event;
	import flash.net.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	public class RankPage extends BasePage
	{
		private var _rankPage:MovieClip
		
		/*
		 * 若要使用自己的服务器，请将下面的地址改为你的服务器地址
		 * 
		 * */
		private const _serverAddress:String = "http://www.liketocode.com/demo/database/read.php"
		/*************************************************************************/
		
		public function RankPage() 
		{
			_rankPage = new RankPageRes();
			
			TweenLite.from(_rankPage.world_ranking,1,{x:-100, y:22.65, ease:Power0.easeOut, alpha:0})
			TweenLite.to(_rankPage.world_ranking, 0.5, { x:14.2, y:22.65, ease:Power0.easeOut, alpha:1 } )
			TweenLite.from(_rankPage.my_ranking,1,{x:1000, y:10.65, ease:Power0.easeOut, alpha:0})
			TweenLite.to(_rankPage.my_ranking, 0.5, { x:432.2, y:10.65, ease:Power0.easeOut, alpha:1 } )
			TweenLite.from(_rankPage.ranking_friend,1,{x:1000, y:257, ease:Power0.easeOut, alpha:0})
			TweenLite.to(_rankPage.ranking_friend, 0.5, { x:432.2, y:257, ease:Power0.easeOut, alpha:1 } )
			
			initRankPage();
			addChild(_rankPage);
			
			super();
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		private function initRankPage():void
		{
			var urlLoader:URLLoader=new URLLoader();
            urlLoader.dataFormat=URLLoaderDataFormat.TEXT;
       		urlLoader.load(new URLRequest(_serverAddress+"?id="+Math.floor(Math.random()*10000).toString()));//后面这串随机数是为了防止URLLoader缓存对结果干扰
       		urlLoader.addEventListener(Event.COMPLETE,handleResponse);
		}
		private function handleResponse(event:Event):void
		{
			trace(event.target.data);
			var scoreData:XML = new XML(event.target.data);//源XML
			var records:Array = new Array();
			var numScores:uint = scoreData.record.length();
			if (numScores > 10) numScores = 10;//显示最大长度为10
			
			for (var i:uint = 0; i<numScores; i++){
				records.push(scoreData.record[i]);
			}

			
			try{
				//设置字体
				var tf:TextFormat = new TextFormat();
				tf.color = 0xffffff;
				tf.size = 20;
				
				//分别显示用户名和分数
				for(var j:uint = 0; j <= numScores; j++){
					var username:TextField = new TextField();
					username.text = scoreData.record[j].name;
					username.x = 88;
					username.y = 120 + 25*j;
					username.setTextFormat(tf);
					
					var userScore:TextField = new TextField();
					userScore.text = scoreData.record[j].score;
					userScore.x = 299;
					userScore.y = 120 + 25*j;
					_rankPage.addChild(username);
					_rankPage.addChild(userScore);
					userScore.setTextFormat(tf);
					
				}
			    
			}
			catch (e:Error){}
			
		}
	}

}