package controler
{
	import flash.display.Shape;
	import flash.events.MouseEvent;
	
	import settings.EditorEvent;
	
	public class TextInfoItem extends EditorControl{
		
		public var textItemRange: Shape;
		
		public function TextInfoItem( item: Shape ){
			this.textItemRange = item;
			
			addButtonAt( 0, 0, 60, "delete", onDeleteButtonClick );
		}
		
		private function onDeleteButtonClick( event: MouseEvent ):void
		{
			report( EditorEvent.DELETE_TEXT );
		}
	}
}