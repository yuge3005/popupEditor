package
{
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import controler.BakgroundEditorControl;
	import controler.NikeNameControl;
	import controler.TextEditorControl;
	
	import gameUI.BackgroundLayer;
	import gameUI.TextLayer;
	
	import settings.EditorEvent;
	import settings.EditorItem;
	import settings.GameConfigObject;
	
	[SWF(width = "1250", height = "1624", frameRate = "30", backgroundColor = "#ffffff")]	
	public class popupEditor extends EditorItem
	{
		/**背景区域*/
		private var backgroundArea: BackgroundLayer;
		
		/**背景编辑控制区*/
		private var backgroundControl: BakgroundEditorControl;

		/**文本区域*/		
		private var textArea: TextLayer;
		
		/**文本编辑控制区*/		
		private var textControl: TextEditorControl;

		public function popupEditor()
		{
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			stage.align = StageAlign.TOP;
			initBackgroundEditor();
			
			addItemAt( new NikeNameControl, 770, 220 );
			initTextEditor();
		}
		
		private function initBackgroundEditor():void{
			
			backgroundArea = addItemAt( new BackgroundLayer, 0, 0 ) as BackgroundLayer;
			backgroundArea.addEventListener( EditorEvent.ITEM_MOVE, onItemMove );
			backgroundArea.addEventListener( EditorEvent.ITEM_CHANGE, onItemChange );
			
			backgroundControl = addItemAt( new BakgroundEditorControl, 770, 0 ) as BakgroundEditorControl;
			backgroundControl.addEventListener( EditorEvent.TEXTURE_FILE_LOADED, onTextrueFileLoad );
			backgroundControl.addEventListener( EditorEvent.TEXTURE_PICTURE_LOADED, onTexturePngLoaded );
			backgroundControl.addEventListener( EditorEvent.ADD_ITEM, onAddItem );
			backgroundControl.addEventListener( EditorEvent.MOVE_ITEM, onMoveItem );
			backgroundControl.addEventListener( EditorEvent.REMOVE_ITEM, onRemoveItem );
			backgroundControl.addEventListener( EditorEvent.ITEM_LAYER_UP, onItemLayerUp );
			backgroundControl.addEventListener( EditorEvent.CONFIG_LOADED, onLoadSuccess );
		}
		
		private function initTextEditor(): void{
			textArea = addItemAt( new TextLayer, 0, 0 ) as TextLayer;
			textControl = addItemAt( new TextEditorControl, 770, 450 ) as TextEditorControl;
			textControl.addEventListener( EditorEvent.TEXT_ADD, onTextAdd );
		}
		
		protected function onItemMove(event:EditorEvent):void{
			refreshItemList();
		}
		
		protected function onItemChange(event:EditorEvent):void{
			refreshItemList();
		}
		
		private function refreshItemList():void{
			backgroundControl.refreshItemList( backgroundArea.getItemList() );
		}
		
		protected function onAddItem(event:EditorEvent):void{
			backgroundArea.addBackgroundItem( event.data );
		}
		
		protected function onTextrueFileLoad(event:EditorEvent):void{
			backgroundArea.clearBackground();
			backgroundControl.onTextureLoaded();
		}
		
		protected function onTexturePngLoaded(event:EditorEvent):void{
			if( GameConfigObject.tempBackgroundItems ){//是load配置文件后的加载过程
				buildTempItems();
			}
		}
		
		private function buildTempItems():void{
			backgroundControl.adTempItems();
			backgroundArea.repositeTempItems();
			NikeNameControl.instance.adTempItems();
			GameConfigObject.tempBackgroundItems = null;
		}
		
		protected function onMoveItem(event: EditorEvent):void{
			backgroundArea.moveItem( event.data.i, event.data.pt );
		}
		
		protected function onRemoveItem(event:EditorEvent):void{
			backgroundArea.removeItem( event.data );
		}
		
		protected function onItemLayerUp(event:EditorEvent):void{
			backgroundArea.itemLayerUp( event.data );
		}
		
		private function onLoadSuccess( event: EditorEvent ):void{
			backgroundControl.loadTextureFile();
		}
		
		private function onTextAdd( event: EditorEvent ):void{
			textArea.resetItemPosition( event.data );
		}
	}
}