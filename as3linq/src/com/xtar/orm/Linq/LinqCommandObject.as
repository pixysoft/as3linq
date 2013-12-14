package com.xtar.orm.Linq
{
	import com.xtar.orm.core.OrmCommand;
	import com.xtar.orm.interfaces.ILinqObject;
	import com.xtar.orm.interfaces.IOrmCommand;

	// 数组代表，可以根据主键查询
	public class LinqCommandObject implements ILinqObject
	{
		private var command:IOrmCommand;
		public function LinqCommandObject(command:IOrmCommand)
		{
			this.command = command;
		}
		
		public function selectAll():Array{
			return command.selectAll();
		}
		
		public function get type():Class{
			return command.type;
		}
	}
}