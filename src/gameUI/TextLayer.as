package gameUI
{
	public class TextLayer extends GameArea
	{
		public function TextLayer()
		{
			super();
		}
		
		public function resetItemPosition( textItemList: Array ): void{
			removeChildren();
			if( !textItemList ) return;
			for( var i: int = 0; i < textItemList.length; i++ ){
				addChild( textItemList[i] );
			}
		}
	}
}