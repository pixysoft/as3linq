package com.xtar.orm.Linq
{
	import com.xtar.common.ArrayCoder;
	import com.xtar.orm.interfaces.ILinqObject;
	
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class LinqArrayObject implements ILinqObject
	{
		private var clz:Class;
		private var array:Array;
		
		public function LinqArrayObject(array:Array)
		{
			this.array = array;
			if(this.array.length <= 0)
				throw new Error('array is empty.');
			this.clz = getDefinitionByName(getQualifiedClassName(array[0])) as Class;
		}
		
		public function selectAll():Array{
			return ArrayCoder.arrayCopy(this.array);
		}
		
		public function get type():Class{
			return clz;
		}
	}
}