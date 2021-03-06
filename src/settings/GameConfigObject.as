package settings{
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.FileReference;
	
	import controler.NikeNameControl;
	import controler.TextEditorControl;

	public class GameConfigObject{
		
		public static var extraUIName: String;
		
		public static var textureRelativePath: String;
		
		public static var backgroundItems: Array = [];
		
		public static var tempBackgroundItems: Array;
		public static var nikeNames: Object;
		public static var textItems: Object;
		
		private static var successCallback: Function;
		
		public function GameConfigObject(){
		}
		
		private static function getConfigObject():Object{
			var obj: Object = {};
			obj.textureRelativePath = textureRelativePath;
			obj.backgroundItems = backgroundItems;
			obj.nikeNames = NikeNameControl.getNikeNameList();
			obj.textItems = TextEditorControl.getTextItems();
			return obj;
		}
		
		private static function getExporteString():String{
			var obj: Object = {};
			var originStr: String = GameRes.textureOrigen.substring( 0, GameRes.textureOrigen.length - 1 );
			var nikeNameString: String = getNikeNamesString( NikeNameControl.getNikeNameList(), backgroundItems );
			if( nikeNameString ){
				originStr += ",\n" + nikeNameString;
			}
			var textDataString: String = getTextDataString( TextEditorControl.getTextItems() );
			if( textDataString ){
				originStr += ",\n" + textDataString;
			}
			originStr += "}";
			return originStr;
		}
		
		private static function getNikeNamesString( nikeObj: Object, ar: Array ): String{
			var assetsObj: Object = {};
			var bgPt: Point = GameRes.bgPosition;
			for( var ob: Object in nikeObj ){
				for( var i: int = 0; i < ar.length; i++ ){
					if( ar[i].name == ob ){
						ar[i].x = Math.round(ar[i].x - bgPt.x);
						ar[i].y = Math.round(ar[i].y - bgPt.y);
						assetsObj[nikeObj[ob]] = ar[i];
					}
				}
			}
			var str: String = JSON.stringify( assetsObj );
			return str.substring( 1, str.length - 1 );
		}
		
		private static function getTextDataString( textItems: Object ): String{
			var textObj: Object = {};
			if( textItems ){
				textObj = textItems;
				var bgPt: Point = GameRes.bgPosition;
				for( var ob: Object in textObj ){
					var rect: Object = textObj[ob].rect;
					rect.x = Math.round(rect.x - bgPt.x);
					rect.y = Math.round(rect.y - bgPt.y);
					rect.w = Math.round( rect.width );
					rect.h = Math.round( rect.height );
					delete rect.width;
					delete rect.height;
				}
			}
			var str: String = JSON.stringify( textObj );
			return str.substring( 1, str.length - 1 );
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
			var str: String = getExporteString();
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
			
			nikeNames = obj.nikeNames;
			textItems = obj.textItems;
			tempBackgroundItems = obj.backgroundItems;
		}
	}
}