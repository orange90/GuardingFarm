package 
{
	import game.pages.*;
	import game.popups.NextLevelPopup;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event; 
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;
	import flash.system.Security;
	
	
	/**
	 * ...
	 * @author orange
	 * 首先载入xml，传给静态类XMLSaver，用于存储整个游戏都需要的关卡数据
	 * 然后再载入游戏的第一页，开始游戏流程
	 */
	public class Main extends MovieClip 
	{
		
		public function Main():void 
		{
			
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, handleLoadXMLComplete);
			
			loader.load(new URLRequest("http://www.liketocode.com/demo/gameSetting.xml"));
			Security.allowDomain("*")
			Security.loadPolicyFile("CrossDomain.xml");
		}
		private function handleLoadXMLComplete(event:Event):void
		{
			XMLSaver.setXMLdata(new XML(event.target.data));
			createIndexPage();
		}
		private function createIndexPage():void 
		{
			var currentLevel:uint = gameProcess.level;
			this.addChild(new Index());
			
		}
		
	}
	
}