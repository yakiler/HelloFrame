package priv.yakiler.hf.mvc.command
{
	import priv.yakiler.hf.interfaces.ICommand;
	
	/**
	 * 多命令执行<br/>
	 * 它可以为您按顺序执行一系列命令集合，通过<code>initSubCommands()</code>添加子命令<br/>
	 * 注意：通常您不应该覆盖<code>excute()</code>方法，但您应该覆盖<code>undo(), redo()</code>方法
	 * */
	public class MultiCommand extends CommandBase implements ICommand
	{
		protected var subCommands:Array;
		protected var params:Array;
		
		public function MultiCommand()
		{
			super();
			subCommands = [];
			params      = [];
		}
		
		/**
		 * 通过调用此方法添加子命令，注意保持命令和产生的一一对应。如果某个命令不需要参数可以使用null占位。
		 * @param subCommands 一个命令类型的集合
		 * @param params 命令携带的参数集合
		 * */
		public function addSubCommands( subCommands:Array,params:Array ):void
		{
			this.subCommands.concat( subCommands );
			this.params.concat(params);
		}
		
		override public final function excute():void
		{
			for each (var cmd_clazz:Class in subCommands) 
			{
				for each (var ce:CommandData in this.params) 
				{
					var cmd:ICommand = (new cmd_clazz) as ICommand;
					if( cmd )
					{
						cmd.initCommandData( ce );
						cmd.excute();
					}
				}
			}
		}
		
		override public function redo():void
		{
			super.redo();
		}
		
		override public function undo():void
		{
			super.undo();
		}
		
	}
}