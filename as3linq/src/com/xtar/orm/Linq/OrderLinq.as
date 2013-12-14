package com.xtar.orm.Linq
{
	import com.xtar.orm.interfaces.IOrderLinq;

	public class OrderLinq extends ResultLinq implements IOrderLinq
	{
		private var context:LinqContext;
		
		public function OrderLinq(context:LinqContext)
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