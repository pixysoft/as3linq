package
{
	import com.xtar.orm.OrmManager;
	import com.xtar.orm.interfaces.IOrmCommand;
	
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	public class as3linqTest extends Sprite
	{
		public function as3linqTest()
		{
			var demo1:Array = new Array;
			for(var i:int = 0;i<100;i++)
			{
				var x1:OrmDemo = new OrmDemo;
				x1.code = i;
				x1.age = i;
				x1.name = "name" + i;
				demo1.push(x1);
			}
			
			var command:IOrmCommand = OrmManager.createCommand(OrmDemo);
			command.insertOrUpdate(demo1);
			
			trace(command.selectAll().length);
			trace(command.selectByCode(0).name);
			trace(command.insertOrUpdate(demo1).length);
			trace(command.remove(demo1[0]).length);
			
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
			
			
			trace('-----------------------');
			
			// 条件查询
			trace(command.select()
				.where(function(x:OrmDemo):Boolean
				{ return x.age % 2 == 0;})
				.result().length);
			
			// 连表查询
			trace(command.select()
				.join(demo2, function(x:OrmDemo, y:OrmDemo2):Boolean
				{ return x.code == y.code; })
				.result().length);
			
			// 连表复合查询
			for each(var x:OrmDemo in command.select()
				.join(demo2, function(x:OrmDemo, y:OrmDemo2):Boolean
				{ return x.code == y.code; })
				.where(function(x:OrmDemo, y:OrmDemo2):Boolean
				{ return x.age % 3 == 0 || y.type % 3 == 0; })
				.result())
			{
				trace(x.name);
			}
			
			trace('-----------------------');
			
			// 连表排序查询
			for each(var x:OrmDemo in command.select()
				.join(demo2, function(x:OrmDemo, y:OrmDemo2):Boolean
				{ return x.code == y.code; })
				.where(function(x:OrmDemo, y:OrmDemo2):Boolean
				{ return x.age % 3 == 0 || y.type % 3 == 0; })
				.order(OrmDemo2, "type", true)
				.order(OrmDemo, "age")
				.result())
			{
				trace(x.name);
			}
			
			trace('-----------------------');
			
			//主键查询
			for each(var x:OrmDemo in command.select()
				.joinOn(function(x:OrmDemo):*
				{ return demo22[x.code]; })
				.where(function(x:OrmDemo, y:OrmDemo2):Boolean
				{ return x.age % 3 == 0 || y.type % 3 == 0; })
				.order(OrmDemo2, "type", true)
				.order(OrmDemo, "age")
				.result())
			{
				trace(x.name);
			}
		}
	}
}