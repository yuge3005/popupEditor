package
{
	import controler.BakgroundEditorControl;
	
	import gameUI.BackgroundLayer;
	
	import settings.EditorEvent;
	import settings.EditorItem;
	
	[SWF(width = "1550", height = "1624", frameRate = "30", backgroundColor = "#ffffff")]	
	public class popupEditor extends EditorItem
	{
		/**背景区域*/
		private var backgroundArea: BackgroundLayer;
		
		/**背景编辑控制区*/
		private var backgroundControl: BakgroundEditorControl;

		public function popupEditor()
		{
			initBackgroundEditor();
		}
		
		private function initBackgroundEditor():void{
			
			backgroundArea = addItemAt( new BackgroundLayer, 0, 0 ) as BackgroundLayer;
//			backgroundArea.addEventListener( EditorEvent.ITEM_MOVE, onItemMove );
//			backgroundArea.addEventListener( EditorEvent.ITEM_CHANGE, onItemChange );
			
			backgroundControl = addItemAt( new BakgroundEditorControl, 770, 0 ) as BakgroundEditorControl;
//			backgroundControl.addEventListener( EditorEvent.TEXTURE_FILE_LOADED, onTextrueFileLoad );
//			backgroundControl.addEventListener( EditorEvent.TEXTURE_PICTURE_LOADED, onTexturePngLoaded );
////			backgroundControl.addEventListener( EditorEvent.ANIMATION_FILE_LOADED, onAnimationFileLoaded );
////			backgroundControl.addEventListener( EditorEvent.ANIMATION_PICTURE_LOADED, onAnimationPictureLoaded );
//			backgroundControl.addEventListener( EditorEvent.ADD_ITEM, onAddItem );
//			backgroundControl.addEventListener( EditorEvent.MOVE_ITEM, onMoveItem );
//			backgroundControl.addEventListener( EditorEvent.REMOVE_ITEM, onRemoveItem );
////			backgroundControl.addEventListener( EditorEvent.ADD_ANIMATION, onAddAnimation );
//			backgroundControl.addEventListener( EditorEvent.ITEM_LAYER_UP, onItemLayerUp );
//			backgroundControl.addEventListener( EditorEvent.CONFIG_LOADED, onLoadSuccess );
//			backgroundControl.addEventListener( EditorEvent.LOCK_BACKROUND, onLockBackground );
		}
	}
}