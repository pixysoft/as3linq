package com.xtar.orm.core
{
	import com.xtar.orm.Linq.LinqCommandObject;
	import com.xtar.orm.Linq.LinqContext;
	import com.xtar.orm.Linq.SelectLinq;
	import com.xtar.orm.OrmManager;
	import com.xtar.orm.interfaces.IOrmCommand;
	import com.xtar.orm.interfaces.ISelectLinq;

	public class OrmCommand implements IOrmCommand
	{
		private var clz:Class;
		
		public function OrmCommand(clz:Class)
		{
			this.clz = clz;
		}
		
		public function selectByCode(code:Number):*{
			return OrmManager.selectByCode(clz, code);
		}
		
		public function selectAll():Array{
			return OrmManager.selectAll(clz);
		}
		
		public function select():ISelectLinq{
			var context:LinqContext = new LinqContext(new LinqCommandObject(this));
			return new SelectLinq(context);
		}
		
		public function insertOrUpdate(...values):Array{
			return OrmManager.insertOrUpdate(clz, values);
		}
		
		public function remove(...values):Array{
			return OrmManager.remove(clz, values);
		}
		
		public function get type():Class{
			return this.clz;
		}
	}
}