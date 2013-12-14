package com.xtar.orm.interfaces
{
	public interface IWhereLinq extends IResultLinq
	{
		function order(order:Class, by:String, desc:Boolean = false):IOrderLinq;
	}
}