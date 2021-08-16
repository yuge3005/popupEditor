package controler
{
	import flash.display.Shape;
	
	import settings.EditorItem;
	
	public class TextInfoItem extends EditorItem{
		
		public var textItemRange: Shape;
		
		public function TextInfoItem( item: Shape ){
			this.textItemRange = item;
			
			graphics.beginFill(0);
			graphics.drawRect( 0, 0, 120, 20 );
			graphics.endFill();
		}
	}
}