package controler
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import fl.controls.CheckBox;
	
	import settings.EditorEvent;
	import settings.GameConfigObject;

	public class TextEditorControl extends EditorControl
	{
		private var startPt: Point;
		private var graphicLayer: Shape;
		
		private var checkBox: CheckBox;
		private var textItems: Vector.<TextInfoItem> = Vector.<TextInfoItem>([]);
		
		public static var instance: TextEditorControl;
		
		public function TextEditorControl()
		{
			drawBackground( 0xEEFFFF, new Rectangle( -20,0, 500, 460 ) );
			checkBox = addCheckBox( 0, 20, 130, "add Text", addTextItem );
			
			instance = this;
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
			graphicLayer.x = startPt.x;
			graphicLayer.y = startPt.y;
			stage.addChild( graphicLayer );
		}
		
		private function dragMove( event: MouseEvent ): void{
			drawRange( event.stageX, event.stageY );
		}
		
		private function drawRange( movePointX: int, movePointY: int ): void{
			graphicLayer.graphics.clear();
			graphicLayer.graphics.beginFill( 0, 0.5 );
			graphicLayer.graphics.drawRect( 0, 0, movePointX - startPt.x, movePointY - startPt.y );
			graphicLayer.graphics.endFill();
		}
		
		private function dragEnd( event: MouseEvent ): void{
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, dragMove );
			stage.removeEventListener( MouseEvent.MOUSE_OUT, dragEnd );
			stage.removeEventListener( MouseEvent.MOUSE_UP, dragEnd );
			stage.removeEventListener( MouseEvent.MOUSE_DOWN, dragStart );
			stage.mouseChildren = true;
			checkBox.selected = false;
			drawRange( event.stageX, event.stageY );
			
			if( graphicLayer.width < 10 || graphicLayer.height < 10 || textItems.length >= 5 ){
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
				textItems[i].y = 60 + i * 80;
			}
		}
		
		private function getItems(): Vector.<Shape>{
			var ar: Vector.<Shape> = Vector.<Shape>([]);
			for( var i: int = 0; i < textItems.length; i++ ){
				ar.push( textItems[i].textItemRange );
			}
			return ar;
		}
		
		private function getTextItemList(): Object{
			var list: Object = {};
			var count: int = 0;
			for( var i: int = 0; i < textItems.length; i++ ){
				var textItem: Object = textItems[i].getTextItem();
				if( textItem ){
					list[textItem.name] = textItem;
					delete textItem.name;
					count++;
				}
			}
			if( count ) return list;
			return null;
		}
		
		public static function getTextItems(): Object{
			return instance.getTextItemList();
		}
		
		public function adTempText(): void{
			var textItemList: Object = GameConfigObject.textItems;
			textItems.length = 0;
			for( var ob: Object in textItemList ){
				textItemList[ob].name = ob;
				var rect: Object = textItemList[ob].rect;
				var sp: Shape = new Shape;
				sp.graphics.beginFill( 0, 0.5 );
				sp.graphics.drawRect( 0, 0, rect.width, rect.height );
				sp.graphics.endFill();
				sp.x = rect.x;
				sp.y = rect.y;
				var textItem: TextInfoItem = new TextInfoItem( sp );
				textItem.addEventListener( EditorEvent.DELETE_TEXT, onTextDelete );
				addChild( textItem );
				textItems.push( textItem );
				textItem.setStatusByData( textItemList[ob] );
			}
			flushTextItems();
			report( EditorEvent.TEXT_CHANCGE, getItems() );
		}
	}
}