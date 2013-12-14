package com.xtar.orm.Linq
{
	import com.xtar.orm.interfaces.IOrderLinq;
	import com.xtar.orm.interfaces.IWhereLinq;

	public class WhereLinq extends ResultLinq implements IWhereLinq
	{
		private var context:LinqContext;
		
		public function WhereLinq(context:LinqContext)
		{
			super(context);
			this.context = context;
		}
		
		public function order(order:Class, by:String, desc:Boolean = false):IOrderLinq{
			LinqContext.order(context, order, by, desc);
			return new OrderLinq(context);
		}
	}
}