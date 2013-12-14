package com.xtar.common
{
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;

	public class ArrayCoder
	{
		public static function arrayContains(a:Array, target:*):Boolean{
			for each(var t:* in a)
			{
				if(t == target)
					return true;
			}
			return false;
		}
		
		public static function arrayRemove(a:Array, target:*):void{
			
			if(a.indexOf(target)<0)
				return;
			
			a.splice(a.indexOf(target),1);
		}
		
		public static function arrayRemoveAt(a:Array, index:int):*{
			var rlist:Array = a.splice(index, 1);
			if(rlist.length ==0)
				return null;
			return rlist[0];
		}
		
		//		http://www.beautifycode.com/array-prototypes-insertindexvalue-removeindex
		//		http://help.adobe.com/en_US/ActionScript/3.0_ProgrammingAS3/WS5b3ccc516d4fbf351e63e3d118a9b90204-7ee0.html
		public static function arrayInsert(a:Array, target:*, index:int):void{
			if(index <=0)
				index = 0;
			if(index >= a.length)
				index = a.length;
			
			for(var i:int = a.length; i>index; i--)
			{
				a[i] = a[i-1];
			}
			a[index] = target;
		}
		
		public static function arrayMove(a:Array, target:*, index:int):void{
			var fromIndex:int = a.indexOf(target);
			if(fromIndex >= 0)
			{
				arrayRemove(a, target);
			}
			
			arrayInsert(a, target, index);
		}
		
		//		ControlHelper.arraySort(equipments, 
		//			[new SortField('equipmentserialcode'), 
		//				new SortField('gradelevel')]);
		public static function arraySort(a:Array, sorts:Array):void{
			//			Array.sortOn
			
			var array:ArrayCollection = new ArrayCollection(a);
			var sort:Sort = new Sort();
			sort.fields = sorts;
			array.sort = sort;
			array.refresh();
			var result:Array = new Array;
			for each(var o:* in array)
			{
				result.push(o);
			}
			while(a.length>0)
				a.shift();
			for each(var o2:* in result)
			a.push(o2);
		}
		
		public static function arrayReverse(a:Array):Array{
			var b:Array = new Array;
			for(var i:int = a.length-1;i>=0;i--)
			{
				b.push(a[i]);
			}
			return b;
		}
		
		public static function arrayCopy(a:Array):Array{
			var b:Array = new Array;
			for each(var item:* in a)
			{
				b.push(item);
			}
			return b;
		}
		
		public static function dictCopy(a:Dictionary):Array{
			var b:Array = new Array;
			for each(var item:* in a)
			{
				b.push(item);
			}
			return b;
		}
		
	}
}