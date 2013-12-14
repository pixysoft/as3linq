package com.xtar.orm.interfaces
{
	public interface IJoinLinq extends IResultLinq
	{
		function join(value:*, on:Function):IJoinLinq;
		
		function joinOn(on:Function):IJoinLinq;
		
		function where(where:Function):IWhereLinq;
		
		function order(order:Class, by:String, desc:Boolean = false):IOrderLinq;
	}
}