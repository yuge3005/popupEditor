package gameUI{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import settings.EditorEvent;
	import settings.GameConfigObject;
	import settings.GameRes;

	public class BackgroundLayer extends GameArea{
		
		public function BackgroundLayer(){
			drawBackgroundOn( 0x888888 );
		}
		
		public function addBackgroundItem( name: String ):void{
			var sp: Sprite = GameRes.buildItemByName( name, !this.numChildren );
			addGameAreaItem( sp, new Point( sp.x, sp.y ), EditorEvent.ITEM_CHANGE );
		}
		
		protected override function onGameAreaItemEndDrag(event:MouseEvent):void{
			super.onGameAreaItemEndDrag( event );
			report( EditorEvent.ITEM_MOVE );
		}
		
		public function moveItem( i: int, pt: Point ): void{
			var item: Sprite = this.getChildAt( i ) as Sprite;
			item.x += pt.x;
			item.y += pt.y;
			report( EditorEvent.ITEM_MOVE );
		}
		
		public function removeItem(index:int):void{
			removeChildAt(index);
			report( EditorEvent.ITEM_CHANGE );
		}
		
		public function itemLayerUp(index:int):void{
			addChild(this.getChildAt(index));
			report( EditorEvent.ITEM_CHANGE );
		}
		
		public function clearBackground():void{
			removeChildren();
			report( EditorEvent.ITEM_CHANGE );
		}
		
		public function repositeTempItems():void{
			var items: Array = GameConfigObject.tempBackgroundItems;
			for( var i:int = 0; i<items.length; i++ ){
				var item: Sprite = this.getChildAt( i ) as Sprite;
				item.x = items[i].x;
				item.y = items[i].y;
			}
			report( EditorEvent.ITEM_CHANGE );
		}
	}
}