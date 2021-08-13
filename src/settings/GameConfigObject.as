package settings{
	import flash.events.Event;
	import flash.net.FileReference;

	public class GameConfigObject{
		
		public static var extraUIName: String;
		
		public static var textureRelativePath: String;
		
		public static var backgroundItems: Array = [];
		
		public static var tempBackgroundItems: Array;
		
		public static var balls: Array;
		public static var ballSize: Number;
		public static var ballTextSize: Number;
		public static var ballNumber: int;
		
		public static var payTables: Object = {};
		
		public static var card: Object = {};
		
		private static var successCallback: Function;
		
		public function GameConfigObject(){
		}
		
		private static function getConfigObject():Object{
			var obj: Object = {};
			obj.textureRelativePath = textureRelativePath;
			obj.backgroundItems = backgroundItems;
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
		
		public static function createBalls():void{
			balls = [];
			for( var i:int = 0; i < 90; i++ ){
				balls.push( { index:i } );
			}
		}
		
		public static function clearBallPath(currentIndex:int):void{
			balls[ currentIndex ].path = [];
		}
		
		public static function addPathPoint(currentIndex:int,point:Object):void{
			balls[ currentIndex ].path.push( point );
		}
		
		public static function editPaytable(name:String, obj:Object):void{
			payTables[name] = obj;
		}
		
		public static function deletePaytable(name:String):void{
			payTables[name] = null;
			delete payTables[name];
		}
	}
}