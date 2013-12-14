package com.xtar.orm.interfaces
{
	public interface ILinqObject
	{
		function selectAll():Array;
		
		function get type():Class;
	}
}