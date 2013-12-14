package com.xtar.orm.interfaces
{
	public interface ISelectLinq extends IResultLinq
	{
		function where(where:Function):IWhereLinq;
		
		function join(value:*, on:Function):IJoinLinq;
		
		function joinOn(on:Function):IJoinLinq;
		
		function order(order:Class, by:String, desc:Boolean = false):IOrderLinq;
	}
}