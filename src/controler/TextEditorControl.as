package controler
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import fl.controls.CheckBox;
	
	import settings.EditorEvent;

	public class TextEditorControl extends EditorControl
	{
		private var startPt: Point;
		private var graphicLayer: Shape;
		
		private var checkBox: CheckBox;
		private var textItems: Array = [];
		
		public function TextEditorControl()
		{
			drawBackground( 0xEEFFFF, new Rectangle( -20,0, 500, 250 ) );
			checkBox = addCheckBox( 0, 20, 130, "add Text", addTextItem );
		}
		
		private function addTextItem( event: Event ): void{
			if( event.target.selected ){
				stage.mouseChildren = false;
				stage.addEventListener( MouseEvent.MOUSE_DOWN, dragStart );
			}
		}
		
		private function dragStart( event: MouseEvent ): void{
			startPt = new Point( event.stageX, event.stageY );
			stage.addEventListener( MouseEvent.MOUSE_MOVE, dragMove );
			stage.addEventListener( MouseEvent.MOUSE_OUT, dragEnd );
			stage.addEventListener( MouseEvent.MOUSE_UP, dragEnd );
			graphicLayer = new Shape;
			stage.addChild( graphicLayer );
		}
		
		private function dragMove( event: MouseEvent ): void{
			var movePoint: Point = new Point( event.stageX, event.stageY );
			graphicLayer.graphics.clear();
			graphicLayer.graphics.beginFill( 0, 0.5 );
			graphicLayer.graphics.drawRect( startPt.x, startPt.y, movePoint.x - startPt.x, movePoint.y - startPt.y );
			graphicLayer.graphics.endFill();
		}
		
		private function dragEnd( event: MouseEvent ): void{
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, dragMove );
			stage.removeEventListener( MouseEvent.MOUSE_OUT, dragEnd );
			stage.removeEventListener( MouseEvent.MOUSE_UP, dragEnd );
			stage.removeEventListener( MouseEvent.MOUSE_DOWN, dragStart );
			stage.mouseChildren = true;
			checkBox.selected = false;
			
			if( graphicLayer.width < 10 || graphicLayer.height < 10 ){
				graphicLayer.parent.removeChild( graphicLayer );
			}
			else{
				var textItem: TextInfoItem = new TextInfoItem( graphicLayer );
				textItem.addEventListener( EditorEvent.DELETE_TEXT, onTextDelete );
				addChild( textItem );
				textItems.push( textItem );
				flushTextItems();
				report( EditorEvent.TEXT_CHANCGE, getItems() );
			}
		}
		
		private function onTextDelete( event: EditorEvent ): void{
			var textItem: TextInfoItem = event.target as TextInfoItem;
			textItem.removeEventListener( EditorEvent.DELETE_TEXT, onTextDelete );
			removeChild( textItem );
			textItems.splice( textItems.indexOf( textItem ), 1 );
			flushTextItems();
			report( EditorEvent.TEXT_CHANCGE, getItems() );
		}
		
		private function flushTextItems(): void{
			for( var i: int = 0; i < textItems.length; i++ ){
				textItems[i].y = 60 + i * 40;
			}
		}
		
		private function getItems(): Array{
			var ar: Array = [];
			for( var i: int = 0; i < textItems.length; i++ ){
				ar.push( textItems[i].textItemRange );
			}
			return ar;
		}
	}
}