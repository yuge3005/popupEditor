package settings{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;

	public class GameRes{

		/**素材配置对象*/
		public static var textureData: Object;
		/**素材图*/
		public static var texturePic: BitmapData;
		
		public function GameRes(){
		}
		
		public static function buildItemByName( name: String ): Sprite{
			var sp: Sprite = new Sprite;
			var obj: Object = GameRes.textureData[name];
			var matrix: Matrix = new Matrix( 1, 0, 0, 1, -obj.x, -obj.y );
			sp.graphics.beginBitmapFill( GameRes.texturePic, matrix, false, true );
			sp.graphics.drawRect( 0, 0, obj.w, obj.h );
			sp.name = name;
			return sp;
		}
	}
}