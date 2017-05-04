package priv.yakiler.hf.event
{
	import flash.events.Event;
	
	public class CommandEvent extends Event
	{
		/**
		 * 命令携带的数据
		 * */
		public var data:Object;
		public function CommandEvent(type:String, data:Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
	}
}