package com.xtar.orm.interfaces
{
	public interface IOrmCommand
	{
		function selectByCode(code:Number):*;
		
		function selectAll():Array;
		
		function select():ISelectLinq;
		
		function insertOrUpdate(...values):Array;
		
		function remove(...values):Array;
		
		function get type():Class;
	}
}