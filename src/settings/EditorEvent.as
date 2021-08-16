package settings{
	import flash.events.Event;
	
	public class EditorEvent extends Event{
	
		public var data: *;
		
		/**纹理图集配置文件加载完毕json*/
		public static const TEXTURE_FILE_LOADED: String = "textureFileLoaded";
		/**纹理图集图片文件加载完毕png*/
		public static const TEXTURE_PICTURE_LOADED: String = "texturePictureLoaded";
		/**添加物体*/
		public static const ADD_ITEM: String = "addItem";
		/**轻移物体*/
		public static const MOVE_ITEM: String = "moveItem";
		/**移除物体*/
		public static const REMOVE_ITEM: String = "removeItem";
		/**物体层级上升*/
		public static const ITEM_LAYER_UP: String = "itemLayerUp";
		/**配置文件加载完毕*/	
		public static const CONFIG_LOADED:String = "configLoaded";

		/**背景物体移动*/
		public static const ITEM_MOVE:String = "itemMove";
		/**物体发生变化，移除、添加，层级上升时*/
		public static const ITEM_CHANGE:String = "itemChange";
		
		/**添加文本框*/
		public static const TEXT_ADD: String = "textAdd";
		
		public function EditorEvent(type:String, data: * = null ){
			super( type );
			this.data = data;
		}
	}
}