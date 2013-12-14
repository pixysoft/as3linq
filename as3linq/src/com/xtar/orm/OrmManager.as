package com.xtar.orm
{
	import com.xtar.orm.Linq.LinqArrayObject;
	import com.xtar.orm.Linq.LinqCommandObject;
	import com.xtar.orm.Linq.LinqContext;
	import com.xtar.orm.Linq.SelectLinq;
	import com.xtar.orm.controller.CacheController;
	import com.xtar.orm.core.OrmCommand;
	import com.xtar.orm.interfaces.ILinqObject;
	import com.xtar.orm.interfaces.IOrmCommand;
	import com.xtar.orm.interfaces.ISelectLinq;
	

	public class OrmManager
	{
		public static function createCommand(clz:Class):IOrmCommand{
			return new OrmCommand(clz);
		}
		
		public static function select(value:*):ISelectLinq{
			return new SelectLinq(new LinqContext(createLinqObject(value)));
		}
		
		public static function selectByCode(clz:Class, code:Number):*{
			return CacheController.getOrCreateCache(clz).tryGet(code);
		}

		public static function selectAll(clz:Class):Array{
			return CacheController.getOrCreateCache(clz).getAll();
		}
		
		public static function insertOrUpdate(clz:Class, ...values):Array{
			var params:Array = toParameters(values);
			return CacheController.insertOrUpdate(clz, params);
		}
		
		public static function remove(clz:Class, ...values):Array{
			var params:Array = toParameters(values);
			return CacheController.remove(clz, params);
		}
		
		
		public static function createLinqObject(value:*):ILinqObject{
			if(value is IOrmCommand)
				return new LinqCommandObject(value);
			else if(value is Array)
				return new LinqArrayObject(value);
			else if(value is ILinqObject)
				return value as ILinqObject;
			else
				throw new Error("unsupport type for " + value);
		}
		
		private static function toParameters(values:Array):Array{
			var params:Array = new Array;
			if(values == null || values.length <= 0)
				return params;
			for each(var value in values) 
			{
				if(value == null)
				{
					continue;
				}
				else if(value is Array)
				{
					for each(var subValue in toParameters(value as Array))
					{
						params.push(subValue);
					}
				}
				else
				{
					params.push(value);
				}
			}
			return params;
		}
	}
}