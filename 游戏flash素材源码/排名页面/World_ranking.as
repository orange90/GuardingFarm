package  {
	
	import flash.display.MovieClip;
	import flash.net.URLLoader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;
	import flash.sampler.NewObjectSample;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class World_ranking extends MovieClip {
		
		
		public function World_ranking() {
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE,handleComplete);
			loader.load(new URLRequest("http://www.liketocode.com/demo/Scores.xml"));
		}
		private function handleComplete(event:Event){
			
			var scoreData:XML = new XML(event.target.data);//源XML
			var records:Array = new Array();
			var numScores:uint = scoreData.record.length();
			if (numScores > 10) numScores = 10;//显示最大长度为10
			
			for (var i:uint = 0; i<numScores; i++){
				records.push(scoreData.record[i]);
			}
			records.sort(xmlSort);
			var rankedXML:XML = new XML("<Scores>"+records+"</Scores>");//排序后的XML
			//trace(rankedXML.toString());
			
			try{
				//设置字体
				var tf:TextFormat = new TextFormat();
				tf.color = 0xffffff;
				tf.size = 20;
				
				//分别显示用户名和分数
				for(var j:uint = 0; j < numScores; j++){
					var username:TextField = new TextField();
					username.text = rankedXML.record[j].name;
					username.x = 88;
					username.y = 110 + 27*j;
					username.setTextFormat(tf);
					
					var userScore:TextField = new TextField();
					userScore.text = rankedXML.record[j].score;
					userScore.x = 299;
					userScore.y = 110 + 27*j;
					this.addChild(username);
					this.addChild(userScore);
					userScore.setTextFormat(tf);
				}
			    
			}
			catch (e:Error){}
		}
		//排序规则	
		private function xmlSort(x1:XML,x2:XML):int{
			if (int(x1.score) > int(x2.score)) return -1;//分值大的在前
			if (int(x1.score) < int(x2.score)) return 1;
			else{
				if (x1.time <x2.time){
					return -1;//时间小的在前
				}
				else {
					return -1;
				}
				
			}
		}
	}

}
