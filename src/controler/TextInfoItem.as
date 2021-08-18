package controler
{
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import fl.events.ColorPickerEvent;
	
	import settings.EditorEvent;
	
	public class TextInfoItem extends EditorControl{
		
		public var textItemRange: Shape;
		
		public function TextInfoItem( item: Shape ){
			this.textItemRange = item;
			
			addTextInputWithLabel( 0, 0, 120, "name:", 80 );
			addColorChooser( 140, 0, 90, "text color:", onColorChange );
			
			addButtonAt( 0, 40, 60, "delete", onDeleteButtonClick );
			var rect: Rectangle = new Rectangle( item.x, item.y, item.width, item.height );
			addTipAt( 70, 40, 180, rect.toString(), 20 );
		}
		
		private function onDeleteButtonClick( event: MouseEvent ):void
		{
			report( EditorEvent.DELETE_TEXT );
		}
		
		protected function onColorChange(event:ColorPickerEvent):void{
			
		}
	}
}