package controler
{
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import settings.EditorEvent;
	
	public class TextInfoItem extends EditorControl{
		
		public var textItemRange: Shape;
		
		public function TextInfoItem( item: Shape ){
			this.textItemRange = item;
			
			addButtonAt( 0, 0, 60, "delete", onDeleteButtonClick );
			var rect: Rectangle = new Rectangle( item.x, item.y, item.width, item.height );
			addTipAt( 70, 0, 180, rect.toString(), 20 );
		}
		
		private function onDeleteButtonClick( event: MouseEvent ):void
		{
			report( EditorEvent.DELETE_TEXT );
		}
	}
}