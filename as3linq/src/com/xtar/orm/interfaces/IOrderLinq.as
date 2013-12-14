package com.xtar.orm.interfaces
{
	public interface IOrderLinq extends IResultLinq
	{
		function order(order:Class, by:String, desc:Boolean = false):IOrderLinq;
	}
}