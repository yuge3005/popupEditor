package controler
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import fl.controls.ColorPicker;
	import fl.controls.ComboBox;
	import fl.controls.NumericStepper;
	import fl.controls.TextInput;
	import fl.events.ColorPickerEvent;
	
	import settings.EditorEvent;
	
	public class TextInfoItem extends EditorControl{
		
		public var textItemRange: Shape;
		private var nameInput: TextInput;
		private var colorChooser: ColorPicker;
		private var textSize: NumericStepper;
		private var fontList: ComboBox;
		private var alignList: ComboBox;
		private var strokeColorChooser: ColorPicker;
		private var strokeSize: NumericStepper;
		
		public function TextInfoItem( item: Shape ){
			this.textItemRange = item;
			
			nameInput = addTextInputWithLabel( 0, 0, 120, "name:", 80 );
			colorChooser = addColorChooser( 130, 0, 85, "text color:", onColorChange );
			textSize = addNumericStepper( 220, 0, 100, "text size:", onSetSize, 150 );
			alignList = createAlignComboBox();
			addButtonAt( 410, 0, 60, "delete", onDeleteButtonClick );
			
			var rect: Rectangle = new Rectangle( item.x, item.y, item.width, item.height );
			addTipAt( 0, 40, 180, rect.toString(), 20 );
			strokeColorChooser = addColorChooser( 165, 40, 90, "stroke color:", onColorChange );
			strokeSize = addNumericStepper( 260, 40, 100, "stroke size:", onSetSize, 5 );
			strokeSize.value = 0;
			fontList = createFontComboBox();
		}
		
		private function createFontComboBox(): ComboBox{
			var cmb: ComboBox = createComboBox( 370, 40, 100 );
			cmb.addItem( { label: "arial" } );
			cmb.addItem( { label: "FRAHV_0" } );
			cmb.addItem( { label: "bahnschrift" } );
			cmb.addItem( { label: "FRABK_0" } );
			cmb.addItem( { label: "FRABKIT_0" } );
			cmb.addItem( { label: "FRADM_0" } );
			cmb.addItem( { label: "rifficfree" } );
			cmb.addItem( { label: "luckiest" } );
			cmb.addItem( { label: "framd" } );
			cmb.enabled = true;
			return cmb;
		}
		
		private function createAlignComboBox(): ComboBox{
			var cmb: ComboBox = createComboBox( 330, 0, 70 );
			cmb.addItem( { label: "center" } );
			cmb.addItem( { label: "left" } );
			cmb.addItem( { label: "right" } );
			cmb.enabled = true;
			return cmb;
		}
		
		private function onDeleteButtonClick( event: MouseEvent ):void{
			report( EditorEvent.DELETE_TEXT );
		}
		
		protected function onColorChange(event:ColorPickerEvent):void{
			//do nothing
		}
		
		private function onSetSize( event: Event ):void{
			//do nothing
		}
		
		public function getTextItem(): Object{
			if( nameInput.text == "" )	return null;
			var obj: Object = {};
			obj.name = nameInput.text;
			var item: Shape = textItemRange;
			obj.rect = { x: item.x, y: item.y, width: item.width, height: item.height };
			obj.color = colorChooser.selectedColor;
			obj.size = textSize.value;
			obj.font = fontList.selectedItem.label;
			obj.align = alignList.selectedItem.label;
			obj.stroke = strokeSize.value;
			obj.strokeColor = strokeColorChooser.selectedColor;
			return obj;
		}
	}
}