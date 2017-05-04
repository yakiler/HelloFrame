package priv.yakiler.hf.error
{
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	import priv.yakiler.hf.enum.HFErrorEnum;

	public class HFError extends Error
	{
		public function HFError(message:String, id:uint)
		{
			if( HFErrorEnum.exists(id) )
			{
				super(message, id);
				addError(message, id);
			}else
			{
				throw new Error( HFErrorEnum.ERROR_ID_REPEAT.message, HFErrorEnum.ERROR_ID_REPEAT.errorID );
			}
		}
		
		protected function addError(message:String, id:uint):void
		{
			HFErrorEnum.errorIDs.push(id);
		}
		
		public function toString():String
		{
			return "Error.id:" + errorID +"\n Error.message:" + message;
		}
	}
}