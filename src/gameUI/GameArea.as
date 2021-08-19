package gameUI{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import settings.EditorItem;
	
	public class GameArea extends EditorItem{
		
		public static const gameAreaWidth: int = 750;
		public static const gameAreaHeight: int = 1624;
		
		/**当前选中物体*/
		protected var currentItem: Sprite;
		
		public function GameArea(){
			addEventListener( Event.ADDED_TO_STAGE, onAdd );
		}
		
		private function onAdd( event: Event ): void{
			var msk: Sprite = new Sprite;
			drawBackgroundOn( 0, msk );
			this.mask = msk;
			this.parent.addChild( this.mask );
		}
		
		protected function drawBackgroundOn( color: uint, target: Sprite = null ):void{
			if( !target )target = this;
			target.graphics.beginFill( color );
			target.graphics.drawRect( 0, 0, gameAreaWidth, gameAreaHeight );
			target.graphics.endFill();
		}
		
		protected function addGameAreaItem( sp: DisplayObject, pt: Point, eventName: String ): void{
			sp.x = pt.x;
			sp.y = pt.y;
			addChild( sp );
			sp.addEventListener( MouseEvent.MOUSE_DOWN, onGameAreaItemDrag );
			report( eventName );
		}
		
		public function getItemList():Array{
			var items: Array = [];
			for( var i: int = 0; i < this.numChildren; i++ ){
				var sp: Sprite = this.getChildAt( i ) as Sprite;
				items.push( { name: sp.name, x: sp.x, y: sp.y } );
			}
			return items;
		}
		
		protected function onGameAreaItemDrag(event:MouseEvent):void{
			currentItem = event.currentTarget as Sprite;
			currentItem.startDrag();
			stage.addEventListener( MouseEvent.MOUSE_UP, onGameAreaItemEndDrag );
		}
		
		protected function onGameAreaItemEndDrag(event:MouseEvent):void{
			currentItem.stopDrag();
			currentItem = null;
			stage.removeEventListener( MouseEvent.MOUSE_UP, onGameAreaItemEndDrag );
		}
	}
}