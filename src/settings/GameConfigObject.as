package settings{
	import flash.events.Event;
	import flash.net.FileReference;

	public class GameConfigObject{
		
		public static var extraUIName: String;
		
		public static var textureRelativePath: String;
		
		public static var backgroundItems: Array = [];
		
		public static var tempBackgroundItems: Array;
		
		private static var successCallback: Function;
		
		public function GameConfigObject(){
		}
		
		private static function getConfigObject():Object{
			var obj: Object = {};
			obj.textureRelativePath = textureRelativePath;
			obj.backgroundItems = backgroundItems;
			return obj;
		}
		
		private static function getExporteObject():Object{
			var obj: Object = {};
//			obj.textureRelativePath = textureRelativePath;
//			obj.backgroundItems = backgroundItems;
			return obj;
		}
		
		public static function clearBackgroundItems():void{
			backgroundItems = [];
		}
		
		public static function addBackgroundItem(item:Object):void{
			backgroundItems.push( item );
		}
		
		public static function save():void{
			var str: String = JSON.stringify( getConfigObject() );
			var file: FileReference = new FileReference;
			file.save( str, "game config file name.conf" );
		}
		
		public static function exporte():void{
			var str: String = JSON.stringify( getExporteObject() );
			var file: FileReference = new FileReference;
			file.save( str, "exported file name.json" );
		}
		
		public static function load( successCallback: Function ):void{
			new FilesLoader().selectFile( onFileSellect, "conf" );
			GameConfigObject.successCallback = successCallback;
		}
		
		protected static function onFileSellect(event:Event):void{
			new FilesLoader().loadFile( event.target.name, onFileLoaded );
		}
		
		protected static function onFileLoaded(event:Event):void	{
			trace( "load success" )
			var obj: Object = JSON.parse( event.target.data );
			trace( event.target.data )
			textureRelativePath = obj.textureRelativePath;
			successCallback();
			
			tempBackgroundItems = obj.backgroundItems;
		}
	}
}