package  
{
	/**
	 * ...
	 * @author orange
	 * 此乃一个静态类，用于存储从XML中读取的数据，免除在每个用到的地方再重新加载
	 */
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;
	public class XMLSaver extends EventDispatcher
	{
		private static var _settingFile:XML;
		
		public function XMLSaver() 
		{
			//loadData();
		}
	
		public static function getXMLdata():XML
		{
		    return _settingFile;
		}
		public static function setXMLdata(xml:XML):void
		{
		    _settingFile = xml;
		}
	
	}

}