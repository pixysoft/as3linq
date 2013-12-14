package com.xtar.orm.Linq
{
	import com.xtar.orm.interfaces.IResultLinq;

	public class ResultLinq implements IResultLinq
	{
		private var context:LinqContext;
		
		public function ResultLinq(context:LinqContext)
		{
			this.context = context;
		}
		
		public function result():Array{
			return context.getResult();
		}
		
		public function resultAny():*{
			var array:Array = result();
			if(array.length <= 0)
				return null;
			return array[0];
		}
	}
}