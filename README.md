As3Linq is an EASY to use data insert/update/delete/select framework. 

here is the demo:

			var demo1:Array = new Array;
			for(var i:int = 0;i<100;i++)
			{
				var x1:OrmDemo = new OrmDemo;
				x1.code = i;
				x1.age = i;
				x1.name = "name" + i;
				demo1.push(x1);
			}
			
			var result:Array = OrmManager.select(demo1)
				.where(function(x:OrmDemo):Boolean{
					return x.age % 3 == 0;
				})
				.result();
				
By using the OrmManager.select above, we can query/filter/join/order the Data very easy and fast.

Here is a complex DEMO:

			var demo1:Array = new Array;
			for(var i:int = 0;i<100;i++)
			{
				var x1:OrmDemo = new OrmDemo;
				x1.code = i;
				x1.age = i;
				x1.name = "name" + i;
				demo1.push(x1);
			}
			
			var demo2:Array = new Array;
			var demo22:Dictionary = new Dictionary;
			for(var i:int = 0;i<100;i++)
			{
				var x2:OrmDemo2 = new OrmDemo2;
				x2.code = i;
				x2.type = i;
				demo2.push(x2);
				demo22[x2.code] = x2;
			}
			
			// 入门demo
			var result:Array = OrmManager.select(demo1)
				.joinOn(function(x:OrmDemo):*
				{ return demo22[x.code]; })
				.where(function(x:OrmDemo, y:OrmDemo2):Boolean
				{ return x.age % 3 == 0 || y.type % 3 == 0; })
				.order(OrmDemo2, "type", true)
				.order(OrmDemo, "age")
				.result();

Further information, your can just download the source code.
