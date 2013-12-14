package com.xtar.orm.Linq
{
	import com.xtar.orm.OrmManager;
	import com.xtar.orm.interfaces.IJoinLinq;
	import com.xtar.orm.interfaces.IOrderLinq;
	import com.xtar.orm.interfaces.ISelectLinq;
	import com.xtar.orm.interfaces.IWhereLinq;

	public class SelectLinq extends ResultLinq implements ISelectLinq
	{
		private var context:LinqContext;
		
		public function SelectLinq(context:LinqContext)
		{
			super(context);
			this.context = context;
		}
		
		public function where(where:Function):IWhereLinq{
			LinqContext.where(context, where);
			return new WhereLinq(context);
		}
		
		public function join(value:*, on:Function):IJoinLinq{
			LinqContext.join(context, OrmManager.createLinqObject(value), on);
			return new JoinLinq(context);
		}
		
		public function joinOn(on:Function):IJoinLinq{
			LinqContext.joinOn(context, on);
			return new JoinLinq(context);
		}
		
		public function order(order:Class, by:String, desc:Boolean = false):IOrderLinq{
			LinqContext.order(context, order, by, desc);
			return new OrderLinq(context);
		}
	}
}