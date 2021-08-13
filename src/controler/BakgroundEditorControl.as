package controler{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	
	import fl.controls.CheckBox;
	import fl.controls.ComboBox;
	import fl.controls.List;
	import fl.controls.TextInput;
	import fl.events.ColorPickerEvent;
	
	import settings.EditorEvent;
	import settings.FilesLoader;
	import settings.GameConfigObject;
	import settings.GameRes;

	public class BakgroundEditorControl extends EditorControl{
		
		/**背景物体表*/
		private var backgroundItems: List;
		
		public function BakgroundEditorControl(){
			
			drawBackground( 0xFFEEFF, new Rectangle( -20,0, 500, 270 ) );

			addTextureChooser();
			
			addButtonAt( 0, 100, 130, "save", onSaveButtonClick );
			addButtonAt( 0, 140, 130, "load", onLoadButtonClick );
		}
		
		private function onSaveButtonClick(event:MouseEvent):void{
			GameConfigObject.save();
		}
		
		private function onLoadButtonClick(event:MouseEvent):void{
			GameConfigObject.load( onLoadSuccess );
		}
		
		private function onLoadSuccess():void	{
			report( EditorEvent.CONFIG_LOADED );
		}
		
		private function addTextureChooser():void	{
			
			textureList = createComboBox( 0, 60 );
			
			addButtonAt( 0, 20, 130, "choose texture file", onTextureButton );
//			addButtonAt( 0, 100, 130, "choose Animation file", onAnimationButton );
//			addButtonAt( 0, 140, 130, "choose Animation PNG", onAnimationPicButton );
			
//			animationList = createComboBox( 0, 180, 130 );
			
			backgroundItems = addItemAt( new List, 150, 20, 300 ) as List;
			backgroundItems.height = 190;
			backgroundItems.addEventListener( KeyboardEvent.KEY_DOWN, onItemKeyDown );
		}
		
		protected function onTextureButton(event:MouseEvent):void{
			new FilesLoader().selectFile( onTextureFileSellect, "json" );
		}
		
//		protected function onAnimationButton(event:MouseEvent):void{
//			new FilesLoader().selectFile( onAnimationFileSellect, "json" );
//		}
//		
//		protected function onAnimationPicButton(event:MouseEvent):void{
//			new FilesLoader().selectFile( onAnimationPictureSellect, "png" );
//		}
		
		protected function onTextureFileSellect(event:Event):void{
			GameConfigObject.textureRelativePath = event.target.name;
			loadTextureFile();
		}
		
//		protected function onAnimationFileSellect(event:Event):void{
//			GameConfigObject.animationRelativePath = event.target.name;
//			loadAnimationFile();
//		}
//		
//		private function onAnimationPictureSellect(event:Event):void{
//			GameConfigObject.animationPicturePath = event.target.name;
//			loadAnimationPicture();
//		}
		
		public function loadTextureFile():void{
			new FilesLoader().loadFile( GameConfigObject.textureRelativePath, onTextureJsonLoaded );
		}
		
//		public function loadAnimationFile():void{
//			new FilesLoader().loadFile( GameConfigObject.animationRelativePath, onAnmationJsonLoaded );
//		}
//		
//		public function loadAnimationPicture():void{
//			new FilesLoader().loadPicture( GameConfigObject.animationPicturePath, onAnmationPngLoaded );
//		}
		
		protected function onTextureJsonLoaded(event:Event):void{
			var textureObject: Object = JSON.parse( event.target.data );
			var textureName: String = textureObject.file;
			var frames: Object =  textureObject.frames;
			GameRes.textureData = frames;
			
			report( EditorEvent.TEXTURE_FILE_LOADED );
			new FilesLoader().loadPicture( textureName, onTexturePngLoaded );
		}
		
		private function onAnmationJsonLoaded( event:Event ):void{
			var mcObject: Object = JSON.parse( event.target.data );
			
			GameRes.movieClipFrameData = mcObject.mc;
			GameRes.movieClipFrameRes = mcObject.res;
			
			report( EditorEvent.ANIMATION_FILE_LOADED );
		}
		
		protected function onTexturePngLoaded(event:Event):void{
			GameRes.texturePic = event.target.loader.content.bitmapData;
			report( EditorEvent.TEXTURE_PICTURE_LOADED );
		}
		
		private function onAnmationPngLoaded(event:Event):void{
			GameRes.movieClipPic = event.target.loader.content.bitmapData;
			report( EditorEvent.ANIMATION_PICTURE_LOADED );
		}
		
		override protected function onTextureItemSellect(event:Event):void{
			var item: Object = (event.currentTarget as ComboBox).selectedItem.label;
			report( EditorEvent.ADD_ITEM, item );
		}
		
		override protected function onAnimationComboxItemSellect(event:Event):void{
			var item: Object = (event.currentTarget as ComboBox).selectedItem;
			report( EditorEvent.ADD_ANIMATION, item.label );
		}
		
		public function refreshItemList(items:Array):void{
			backgroundItems.removeAll();
			GameConfigObject.clearBackgroundItems();
			for( var i: int = 0; i < items.length; i++ ){
				backgroundItems.addItem( { label: items[i].name + " ( x=" + items[i].x +", y=" + items[i].y + ")" } );
				GameConfigObject.addBackgroundItem( items[i] );
			}
		}		
		
		protected function onItemKeyDown(event:KeyboardEvent):void{
			var selectedIndex: int = ( event.target as List ).selectedIndex;
			if( selectedIndex < 0 )return;
			if( [ Keyboard.A, Keyboard.S, Keyboard.F, Keyboard.W ].indexOf( event.keyCode ) >= 0 ){
				var movePoint: Point = new Point;
				if( event.keyCode == Keyboard.A )movePoint.x = -1;
				else if( event.keyCode == Keyboard.W )movePoint.y = -1;
				else if( event.keyCode == Keyboard.F )movePoint.x = 1;
				else if( event.keyCode == Keyboard.S )movePoint.y = 1;
				report( EditorEvent.MOVE_ITEM, { i: selectedIndex, pt: movePoint } );
				( event.target as List ).selectedIndex = selectedIndex;
			}
			else if( event.keyCode == Keyboard.DELETE ){
				report( EditorEvent.REMOVE_ITEM, selectedIndex );
			}
			else if( event.keyCode == Keyboard.ENTER ){
				report( EditorEvent.ITEM_LAYER_UP, selectedIndex );
			}
		}
		
		public function adTempItems():void{
			var items: Array = GameConfigObject.tempBackgroundItems;
			var j: int;
			for( var i:int = 0; i<items.length; i++ ){
				for( j = 0; j < textureList.length; j++ ){
					textureList.selectedIndex = j;
					if( textureList.selectedItem.label == items[i].name ){
						report( EditorEvent.ADD_ITEM, textureList.selectedItem.label );
						break;
					}
				}
				for( j = 0; j < animationList.length; j++ ){
					animationList.selectedIndex = j;
					if( animationList.selectedItem.label == items[i].name ){
						report( EditorEvent.ADD_ANIMATION, animationList.selectedItem.label );
						break;
					}
				}
			}
		}
		
		protected function onCheckBoxChange(event:Event):void{
			report( EditorEvent.LOCK_BACKROUND, event.target.selected );
		}
	}
}