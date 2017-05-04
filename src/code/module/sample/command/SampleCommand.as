package code.module.sample.command
{
	import code.app.mvc.Command;
	
	
	/**
	 * 示例命令
	 * @author dom
	 */
	public class SampleCommand extends Command
	{
		public static const SAMPLE_COMMAND_TEST:String = "sampleCommandTest";
		
		public function SampleCommand(type:String, data:*)
		{
			super(type, data);
		}
	}
}