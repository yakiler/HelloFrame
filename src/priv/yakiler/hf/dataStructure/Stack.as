package priv.yakiler.hf.dataStructure
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.logging.LogLogger;
	
	import priv.yakiler.hf.uitl.LogUtil;

	/**
	 * 栈（数组形式）的简单实现。与队列不同的是它总是后进先出
	 * */
	public class Stack implements IEventDispatcher 
	{
		// ---------------------------------------------------------------------------------
		//
		//		属性
		//
		// ---------------------------------------------------------------------------------
		protected var logger:LogLogger = LogUtil.getLogger("priv.yakiler.hf.dataStructure.Stack");
		/**维持栈的数组*/
		protected var datas:Array = [];
		/**如果构造函数传入限定长度，则表示此栈的最大长度*/
		protected var $length:uint = 0;
		/**
		 *  事件驱动器
		 */
		private var eventDispatcher:EventDispatcher;
		
		
		
		// ---------------------------------------------------------------------------------
		//
		//		构造函数
		//
		// ---------------------------------------------------------------------------------
		
		/**
		 * @param length:栈的最大长度，默认为0表示不限制栈
		 * */
		public function Stack( length:uint = 0 )
		{
			if( length > -1 )
			{
				$length = length;
			}
			eventDispatcher = new EventDispatcher( this );
		}
		
		/**初始化栈，用于将数组转化为栈的快捷方式。<br/>
		 * 注意如果给的参数数组长度超出初始化栈的长度则会抛出异常<br/>
		 * 注意如果参数数组是非连续性的（数组内部有空值）会自动去除
		 * */
		public function initStack( datas:Array ):void
		{
			if( datas && ( limit && datas.length > $length ) )
			{
				// todo 将错误加入错误枚举常量
				throw new Error("参数数组长度超出预定栈长度");
				return;
			}
			if( datas && datas.length )
			{
				for (var i:int = 0; i < datas.length; i++) 
				{
					if(datas[i])
					{
						this.datas.push( datas[i] );
					}
				}
			}
		}
		
		/**清空栈*/
		public function removeAll():void
		{
			datas = [];
		}
		
		/**入栈*/
		public function intoStack( data:* ):void
		{
			if( limit && datas.length >= $length )
			{
				logger.debug("此操作将导致栈溢出");
				return;
			}
			if( data )
			{
				datas.push( data );
			}
		}
		
		/**出栈，如果返回Null则说明操作前是空栈*/
		public function outStack():*
		{
			if( datas.length )
			{
				var value:* = datas[ datas.length - 1  ];
				datas.pop();
				return value;
			}
			return null;
		}
		
		/**栈中是否存在该元素,isComparePointer是否比较指针*/
		public function hasOne( data:*, isComparePointer:Boolean = false ):Boolean
		{
			if( data )
			{
				for each (var i:* in datas) 
				{
					if( isComparePointer )
					{
						if( data == i )
						{
							return true;
						}
					}else
					{
						if( data === i )
						{
							return true;
						}
					}
				}
			}
			return false;
		}
		
		/**克隆一个栈*/
		public function clone():Stack
		{
			var stack:Stack = new Stack;
			stack.initStack( datas );
			return stack;
		}
		
		
		
		// ---------------------------------------------------------------------------------
		//
		//		getter and setter
		//
		// ---------------------------------------------------------------------------------
		
		/**维持栈的数组。注意返回的是一个浅表克隆的数组*/
		public function get stack():Array
		{
			return datas.concat();
		}
		
		/**栈头,返回null表示空栈*/
		public function get head():*
		{
			return datas[0] || null;
		}
		
		/**栈尾，返回null表示空栈*/
		public function get tail():*
		{
			return datas[ datas.length - 1 ] || null;
		}
		
		/**栈当前的实际长度*/
		public function get length():uint
		{
			return datas.length;
		}
		
		/**栈的最大长度*/
		public function get maxLength():uint
		{
			return $length || length;
		}
		
		/**栈长度是否受限制*/
		protected function get limit():Boolean
		{
			return $length != 0;
		}
		
		//--------------------------------------------------------------------------
		//
		// EventDispatcher methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public function addEventListener(type:String,
										 listener:Function,
										 useCapture:Boolean = false,
										 priority:int = 0,
										 useWeakReference:Boolean = false):void
		{
			eventDispatcher.addEventListener(type, listener, useCapture,
				priority, useWeakReference);
		}
		
		/**
		 *  @inheritDoc
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public function removeEventListener(type:String,
											listener:Function,
											useCapture:Boolean = false):void
		{
			eventDispatcher.removeEventListener(type, listener, useCapture);
		}
		
		/**
		 *  @inheritDoc
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public function dispatchEvent(event:Event):Boolean
		{
			return eventDispatcher.dispatchEvent(event);
		}
		
		/**
		 *  @inheritDoc
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public function hasEventListener(type:String):Boolean
		{
			return eventDispatcher.hasEventListener(type);
		}
		
		/**
		 *  @inheritDoc
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public function willTrigger(type:String):Boolean
		{
			return eventDispatcher.willTrigger(type);
		}
	}
}