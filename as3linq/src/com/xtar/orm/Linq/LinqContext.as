package com.xtar.orm.Linq
{
	import com.xtar.common.ArrayCoder;
	import com.xtar.orm.OrmManager;
	import com.xtar.orm.interfaces.ILinqObject;
	
	import flash.utils.Dictionary;
	
	import mx.collections.SortField;
	
	public class LinqContext
	{
		// 数据缓存 [[x1,x2],[y1,y2],...]
		private var linq:Array = new Array;
		
		// 查询结果[[ix1,y1],[x2,y2]]
		private var result:Array = new Array;
		
		//排序 [class, by, desc]
		private var orders:Array = new Array;
		
		public function LinqContext(values:ILinqObject)
		{
			// init iinq
			linq.push(values);
			
			// init result
			for each(var value:* in values.selectAll())
			{
				if(value == null)
					throw new Error('null element existed.');
				result.push([value]);
			}
		}
		
		public function joinLinq(values:ILinqObject):void{
			linq.push(values);
		}
		
		public function addOrderBy(clz:Class, name:String, desc:Boolean):void{
			orders.push([clz, name, desc]);
		}
		
		public function replaceResult(values:Array):void{
			this.result = values;
		}
		
		public function copyResult():Array{
			return ArrayCoder.arrayCopy(result);
		}
		
		public function getResult():Array{
			// orderby
			_orderBy();
			// getresults
			var array:Array = new Array;
			for each(var value:* in result)
			{
				array.push(value[0]);
			}
			return array;
		}
		
		public function get linqCount():int{
			return linq.length;
		}
		
		// ----------- private -------------
		
		private function _orderBy():void
		{
			if(orders.length <= 0)
				return;
			var orderResult:Array = new Array;
			var orderIndexs:Dictionary = new Dictionary;
			for each(var item:Array in copyResult())
			{
				var orderItem:Object = new Object;
				for each(var orderby:Array in orders)
				{
					var classN:String = orderby[0].toString().replace('[','').replace(']','').replace(' ','_');
					var name:String = classN+"_"+orderby[1];
					orderItem[name] = item[getLinqIndex(orderIndexs, orderby[0])][orderby[1]];
				}
				orderItem["__$item$"] = item;
				orderResult.push(orderItem);
			}
			var sorters:Array = new Array;
			for each(var orderby:Array in orders)
			{
				var classN:String = orderby[0].toString().replace('[','').replace(']','').replace(' ','_');
				var name:String = classN+"_"+orderby[1];
				sorters.push(new SortField(name, false, orderby[2]));
			}
			ArrayCoder.arraySort(orderResult, sorters);
			var orderResult2:Array = new Array;
			for each(var item2:* in orderResult)
			{
				orderResult2.push(item2["__$item$"]);
			}
			replaceResult(orderResult2);
		}
		
		private function getLinqIndex(orderIndexs:Dictionary, clz:Class):int{
			if(orderIndexs[clz])
				return orderIndexs[clz];
			for each(var array:ILinqObject in linq)
			{
				if(array.type == clz)
				{
					orderIndexs[clz] = linq.indexOf(array);
					return orderIndexs[clz];
				}
			}
			orderIndexs[clz] = -1;
			return orderIndexs[clz];
		}
		
		// ----------- helper -------------
		
		public static function where(context:LinqContext, where:Function):void
		{
			var argsCount:int = where.length;
			if(argsCount <= 0 || argsCount > context.linqCount)
				throw new Error('where args count error, ' + argsCount + ', expected ' + context.linqCount);
			
			var whereResult:Array = new Array;
			for each(var item:Array in context.copyResult())
			{
				var args:Array = createApplyArgs(argsCount, item);
				if(!where.apply(null, args))
					continue;
				whereResult.push(item);
			}
			context.replaceResult(whereResult);
		}
		
		public static function join(context:LinqContext, value:ILinqObject, on:Function):void{
			var argsCount:int = on.length;
			if(argsCount != context.linqCount + 1)
				throw new Error('where args count error, ' + argsCount + ', expected ' + context.linqCount + 1);
			context.joinLinq(value);
			var joinResult:Array = new Array;
			for each(var item:Array in context.copyResult())
			{
				for each(var valueItem:* in value.selectAll())
				{
					if(valueItem == null)
						throw new Error('null element existed in join.');
					var args:Array = createApplyArgs(argsCount - 1, item);
					args.push(valueItem);
					if(!on.apply(null, args))
						continue;
					joinResult.push(args);
					break;
				}
				
			}
			context.replaceResult(joinResult);
		}
		
		public static function joinOn(context:LinqContext, on:Function):void{
			var argsCount:int = on.length;
			if(argsCount <= 0 || argsCount > context.linqCount)
				throw new Error('where args count error, ' + argsCount + ', expected ' + context.linqCount);
			
			var linqResult:Array = new Array;
			var joinResult:Array = new Array;
			for each(var item:Array in context.copyResult())
			{
				var args:Array = createApplyArgs(argsCount, item);
				var _join:* = on.apply(null, args);
				if(_join == null)
					throw new Error('null element existed in join.');
				linqResult.push(_join);
				item.push(_join);
				joinResult.push(item);
			}
			context.joinLinq(OrmManager.createLinqObject(linqResult));
			context.replaceResult(joinResult);
		}
		
		public static function order(context:LinqContext, order:Class, by:String, desc:Boolean):void{
			context.addOrderBy(order, by, desc);
		}
		
		private static function createApplyArgs(argsCount:int, item:Array):Array{
			var args:Array = new Array;
			for(var i:int = 0;i<argsCount;i++)
				args.push(item[i]);
			return args;
		}
	}
}