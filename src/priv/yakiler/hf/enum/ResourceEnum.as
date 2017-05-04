package priv.yakiler.hf.enum
{
	/**
	 * 资源常量枚举
	 * */
	public class ResourceEnum
	{
		// ---------------------------------------------------------------------------------
		//
		//		静态常量
		//
		// ---------------------------------------------------------------------------------
		protected static const Image:String		 = "image";
		protected static const Icon:String			 = "icon";
		protected static const BitmapData:String 	 = "bitmapData";
		protected static const Bitmap:String 		 = "bitmap";
		protected static const HttpService:String  = "httoService";
		protected static const Xml:String         = "xml";
		protected static const ByteArray:String    = "byteArray";
		
		public static const IMAGE:ResourceEnum 	   = new ResourceEnum(Image);
		public static const ICON:ResourceEnum 		   = new ResourceEnum(Icon);
		public static const BITMAP:ResourceEnum 	   = new ResourceEnum(Bitmap);
		public static const BITMAPDATA:ResourceEnum  = new ResourceEnum(BitmapData);
		public static const HTTPSERVICE:ResourceEnum = new ResourceEnum(HttpService);
		public static const XML:ResourceEnum		   = new ResourceEnum(Xml);
		public static const BYTEARRAY:ResourceEnum   = new ResourceEnum(ByteArray);
		
		
		// ---------------------------------------------------------------------------------
		//
		//		属性
		//
		// ---------------------------------------------------------------------------------
		protected var _type:String;
		
		// ---------------------------------------------------------------------------------
		//
		//		构造函数
		//
		// ---------------------------------------------------------------------------------
		public function ResourceEnum( type:String )
		{
			this._type = type;	
		}
	}
}