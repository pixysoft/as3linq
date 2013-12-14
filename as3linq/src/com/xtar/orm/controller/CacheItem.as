package com.xtar.orm.controller
{
	import com.xtar.orm.OrmBase;
	
	import flash.utils.Dictionary;

	public class CacheItem
	{
		// pk<>value
		private var dict:Dictionary = new Dictionary;
		
		public function insertOrUpdate(value:OrmBase):OrmBase{
			var ovalue:OrmBase = dict[value.code];
			dict[value.code] = value;
			return ovalue;
		}
		
		public function remove(code:Number):OrmBase{
			var value:OrmBase = dict[code];
			delete dict[code];	
			return value;
		}
		
		public function tryGet(code:Number):OrmBase
		{
			for(var key:* in dict)
			{
				if(key == code)
					return dict[key];
			}
			return null;
		}
		
		public function get(code:Number):OrmBase{
			var value:OrmBase = tryGet(code);
			if(value == null)
				throw new Error("missing value for " + code);
			return value;
		}
		
		public function getAll():Array{
			var result:Array = new Array;
			for each(var value:OrmBase in dict)
			{
				result.push(value);
			}
			return result;
		}
	}
}