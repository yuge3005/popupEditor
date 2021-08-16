package controler
{
	import fl.controls.TextInput;
	
	import settings.GameConfigObject;

	public class NikeNameControl extends EditorControl
	{
		private var nikeNameList: Vector.<Vector.<TextInput>>;
		public static var instance: NikeNameControl;
		
		public function NikeNameControl()
		{
			super();
			addTipAt( 0, 20, 130, "nike name:", 60 );
			
			nikeNameList = new Vector.<Vector.<TextInput>>;
			
			nikeNameList[0] = addNikeNameItem( 60, "nike1:" );
			nikeNameList[1] = addNikeNameItem( 100,"nike2:" );
			nikeNameList[2] = addNikeNameItem( 140,"nike3:" );
			nikeNameList[3] = addNikeNameItem( 180,"nike4:" );
			
			instance = this;
		}
		
		private function addNikeNameItem( y: int, tip: String ): Vector.<TextInput>{
			var vt: Vector.<TextInput> = new Vector.<TextInput>;
			vt[0] = addTextInputWithLabel( 0, y, 130, tip, 80 );
			vt[1] = addTextInputWithLabel( 100, y, 130, "", 80 );
			return vt;
		}
		
		public static function getNikeNameList(): Object{
			return instance.getNikeNames();
		}
		
		private function getNikeNames(): Object{
			var vs: Object = {};
			for( var i: int = 0; i < nikeNameList.length; i++ ){
				var nikeNameItem: Vector.<String> = stringFromInput(i);
				if( nikeNameItem ) vs[nikeNameItem[0]] = nikeNameItem[1];
			}
			return vs;
		}
		
		private function stringFromInput( index: int ): Vector.<String>{
			var key: String = nikeNameList[index][0].text;
			var value: String = nikeNameList[index][1].text;
			if( key && value ) return Vector.<String>([key, value]);
			return null;
		}
		
		public function adTempItems(): void{
			for( var i: int = 0; i < nikeNameList.length; i++ ){
				nikeNameList[i][0].text = "";
				nikeNameList[i][1].text = "";
			}
			var nms: Object = GameConfigObject.nikeNames;
			var index: int = 0;
			for( var ob: Object in nms ){
				nikeNameList[index][0].text = ob;
				nikeNameList[index][1].text = nms[ob];
			}
		}
	}
}