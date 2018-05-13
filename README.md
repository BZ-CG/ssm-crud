一、功能及涉及到的技术
====
**功能点：**

1. 分页 
2. 数据校验 
    - jquery前端校验+JSR303后端校验 
3. ajax 
4. Rest风格的URI；使用HTTP协议请求方式的动词，来表示对资 源的操作（GET（查询），POST（新增），PUT（修改），DELETE （删除））

**技术点：**

1. 基础框架 - ssm（SpringMVC+Spring+MyBatis） 
2. 数据库 - MySQL 
3. 前端框架 - bootstrap快速搭建简洁美观的界面 
4. 项目的依赖管理 - Maven 
5. 分页 - pagehelper 
6. 逆向工程 - MyBatis Generator

二、环境搭建：
====

1. 创建一个maven工程 
2. 引入项目依赖的jar包 
  - spring 
  - springmvc 
  - mybatis 
  - 数据库连接池，驱动包
  - 其他（jstl，servlet-api，junit）
3. 引入bootstrap前端框架 
4. 编写ssm整合的关键配置文件 • web.xml，spring,springmvc,mybatis，使用mybatis的逆向工程生成对应的bean以 及mapper
5. 测试mapper

三、操作流程及部分代码分析：
====

> 需要在 JSP 页面中导入 bootstrap 的 css 文件，以及 Jquery 文件。
> 
1.加载页面查询所有员工信息：
---
效果：
![](https://i.imgur.com/k0qBc81.png)


**步骤**：

1. index.jsp页面直接发送ajax请求进行员工分页数据的查询 
2. 服务器将查出的数据，以json字符串的形式返回给浏览器 
3. 浏览器收到js字符串。可以使用js对json进行解析，使用js通过 dom增删改改变页面。
4. 返回json。实现客户端的无关性

**构建表格数据：**

```jsp

    //构建表格数据
	var buildEempsTtable = function(data){
		//在绑定数据前先清除之前的数据。
		$("#emps_table tbody").empty();
		
		$.each(data.map.pageInfo.list,function(index,item){
			//alert(item.empName);
			var checkBoxTd = $("<td></td>").append($('<input type="checkbox" class="checkItem"/>'));
			var empIdTd = $("<td></td>").append(item.empId);
			var empNameTd = $("<td></td>").append(item.empName);
			var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
			var emailTd = $("<td></td>").append(item.email);
			var telTd = $("<td></td>").append(item.tel);
			var deptNameTd = $("<td></td>").append(item.dept.deptName);		
			//把当前员工的 ID 添加在编辑和删除按钮上，方便后面使用
            var editBnt = $("<button></button>").addClass("btn btn-info btn-sm edit-bnt")
							.append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
							.append("编辑").attr("empId",item.empId);
			var deleBnt = $("<button></button>").addClass("btn btn-danger btn-sm delete-bnt")
							.append($("<span></span>").addClass("glyphicon glyphicon-trash"))
							.append("删除").attr("empId",item.empId);
			var bntTd = $("<td></td>").append(editBnt).append(" ").append(deleBnt);
			$("<tr></tr>").append(checkBoxTd)
						.append(empIdTd)
						.append(empNameTd)
						.append(genderTd)
						.append(emailTd)
						.append(telTd)
						.append(deptNameTd)
						.append(bntTd)
						.appendTo($("#emps_table tbody"));
		});
	}

```


**构建导航栏：**

```jsp

    //构建导航栏
	var buildNavi = function(data){
		//清空
		$("#pageData").empty();
		var curPage = data.map.pageInfo.pageNum;
		var pageTotal = data.map.pageInfo.pages;
		var total = data.map.pageInfo.total;
		$("#pageData").append("当前<kbd>"+curPage+"</kbd>页,共有<kbd>"+pageTotal+"</kbd>页,一共有<kbd>"+total+"</kbd>条数据。");
		
		totalResult = total;
		//清空
		$("#navi").empty();
		var ul = $("<ul></ul>").addClass("pagination");
		var firstPage = $("<li></li>").append($("<a></a>").append("首页").attr("herf","#"));
		var endPage = $("<li></li>").append($("<a></a>").append("末页").attr("herf","#"));
		var lastPage = $("<li></li>").append($("<a></a>").attr("href","#")
						.append($("<span></span>").append("&laquo;")));
		var nextPage = $("<li></li>").append($("<a></a>").attr("href","#")
						.append($("<span></span>").append("&raquo;")));
		
		currentPage = curPage;
			
		if(curPage <= 1){
			lastPage.addClass("disabled");
		}
		if(curPage >= pageTotal){
			nextPage.addClass("disabled");
		}
		
		//为上一页、下一页、首页、末页添加点击事件。
		lastPage.click(function(){
			getEmpData(curPage-1);
		});
		nextPage.click(function(){
			getEmpData(curPage+1);
		});
		firstPage.click(function(){
			getEmpData(1);
		});
		endPage.click(function(){
			getEmpData(pageTotal);
		});
		
		
		//添加首页和上一页
		ul.append(firstPage).append(lastPage);
		//添加当前显示的导航页
		$.each(data.map.pageInfo.navigatepageNums,function(index,item){
			//var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href","emps?pagenum="+item+""));
			var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href","#"));
			if(item == curPage){
				numLi.addClass("active");
			}
			//添加点击事件
			numLi.click(function(){
				getEmpData(item);
			});
			ul.append(numLi);
		});
		//添加下一页和末页
		ul.append(nextPage).append(endPage);
		
		$("<nav></nav>").append(ul).appendTo($("#navi"));
	
	}

```

2.新增员工：
---

**效果：**

![](https://i.imgur.com/EaGh8Sv.png)

**步骤：**

1. 在index.jsp页面点击”新增” 
2. 弹出新增对话框 
3. 去数据库查询部门列表，显示在对话框中 
4. 用户输入数据，并进行校验
    - jquery前端校验，ajax用户名重复校验，重要数据（后端校验(JSR303)，唯一约束）；
5. 完成保存

- URI:
    -  /emp/{id} GET 查询员工
    -  /emp  POST 保存员工 
    -  /emp/{id}  PUT  修改员工
    -  /emp/{id}  DELETE 删除员工

3.修改员工信息：
---

**效果：**
![](https://i.imgur.com/9ECLwyT.png)

**步骤：**

1. 点击编辑 
2. 弹出用户修改的模态框（显示用户信息） 
3. 点击更新，完成用户修改

4.删除员工信息：
---

**效果：**
![](https://i.imgur.com/gyqQmSK.png)

**步骤：**

1. 批量删除：将要删除员工的 ID 拼凑成字符串传到后台去解析，再进行删除。
2. 单个删除：直接传 ID 删除。

**全选、全不选、复选框的单击事件：**

```jsp

    //全选/全部选
	$(document).on("click","#checkAll",function(){
		/**
			var flag = $(this).attr("checked");
			在这里获取的是 undefined，最好使用 prop 去获取控件原生的属性值；
			而 使用  attr 去获取自定义的属性值。 
		*/
		var flag = $(this).prop("checked");
		$(".checkItem").prop("checked",flag);
	});
	//为员工复选框添加单击事件，当全部选中时触发全选
	$(document).on("click",".checkItem",function(){
		//1.获取被选中的复选框个数
		var checkedItem = $(".checkItem:checked").length;
		//2.获取所有的员工复选框个数
		var allCheckItem = $(".checkItem").length;
		
		//3.如何相等就触发全选事件
		var flag = checkedItem == allCheckItem;
		
		$("#checkAll").prop("checked",flag);
	});

```


四、总结：
====

![](https://i.imgur.com/1DtAncw.png)
