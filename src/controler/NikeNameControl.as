package controler
{
	import fl.controls.TextInput;

	public class NikeNameControl extends EditorControl
	{
		private var nikeNameList: Vector.<Vector.<TextInput>>;
		
		public function NikeNameControl()
		{
			super();
			addTipAt( 0, 20, 130, "nike name:", 60 );
			
			nikeNameList = new Vector.<Vector.<TextInput>>;
			
			nikeNameList[0] = addNikeNameItem( 60, "nike1:" );
			nikeNameList[1] = addNikeNameItem( 100,"nike2:" );
			nikeNameList[1] = addNikeNameItem( 140,"nike3:" );
			nikeNameList[1] = addNikeNameItem( 180,"nike4:" );
		}
		
		private function addNikeNameItem( y: int, tip: String ): Vector.<TextInput>{
			var vt: Vector.<TextInput> = new Vector.<TextInput>;
			vt[0] = addTextInputWithLabel( 0, y, 130, tip, 80 );
			vt[1] = addTextInputWithLabel( 100, y, 130, "", 80 );
			return vt;
		}
	}
}