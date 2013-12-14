package com.xtar.orm.controller
{
	import com.xtar.orm.OrmBase;
	
	import flash.utils.Dictionary;
	
	public class CacheController
	{
		private static var caches:Dictionary = new Dictionary;
		
		public static function insertOrUpdate(clz:Class, values:Array):Array{
			var history:Array = new Array;
			var cacheItem:CacheItem = getOrCreateCache(clz);
			for each(var value:OrmBase in values)
			{
				var ovalue = cacheItem.insertOrUpdate(value);
				if(ovalue)
					history.push(ovalue);
			}
			return history;
		}
		
		public static function remove(clz:Class, values:Array):Array{
			var history:Array = new Array;
			var cacheItem:CacheItem = getOrCreateCache(clz);
			for each(var value:OrmBase in values)
			{
				var ovalue = cacheItem.remove(value.code);
				if(ovalue)
					history.push(ovalue);
			}
			return history;
		}
		
		public static function getOrCreateCache(clz:Class):CacheItem{
			var item:CacheItem = caches[clz];
			if(!item)
			{
				item = new CacheItem();
				caches[clz] = item;
			}
			return item;
		}
	}
}