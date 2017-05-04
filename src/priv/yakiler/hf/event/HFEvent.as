package priv.yakiler.hf.event
{
	import flash.events.Event;
	
	public class HFEvent extends Event
	{
		/**事件携带的交换数据，用于传递多个模块的数据通信**/
		public var data:* = null;
		public function HFEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.data = data;
			super(type, bubbles, cancelable);
		}
	}
}