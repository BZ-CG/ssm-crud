<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />
<script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery-3.2.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
</head>
<body>
	<!-- 修改员工信息的模态框 -->
	<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">修改员工</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal" id="updateForm">
				  <input type="hidden" name="empId" id="empId"/>
				  <div class="form-group">
				    <label  class="col-sm-2 control-label">EmpName</label>
				    <div class="col-sm-10">
				      <p class="form-control-static" id="updateEmpName"></p>
				    </div>
				  </div>
				  <div class="form-group">
				    <label  class="col-sm-2 control-label">Tel</label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control"  name="tel" id="updateTel" placeholder="Tel">
				      <span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label  class="col-sm-2 control-label">Email</label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control"  name="email" id="updateEmail" placeholder="Email">
				      <span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
					    <label  class="col-sm-2 control-label">Gender</label>
					    <div class="col-sm-10">
					        <label class="radio-inline">
							  <input type="radio" name="gender" id="gender1" value="M" checked="checked"> 男
							</label>
							<label class="radio-inline">
							  <input type="radio" name="gender" id="gender2" value="F"> 女
							</label>
					    </div>
				  </div>
				  <div class="form-group">
				  	<label  class="col-sm-2 control-label">DeptName</label>
				    <div class="col-sm-4">
						<select class="form-control" name="deptId" id="updateSelectId">
						</select>
					</div>
				  </div>
				</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal" id="closeUpdateModal">关闭</button>
	        <button type="button" class="btn btn-primary" id="updateButton">修改</button>
	      </div>
	    </div>
	  </div>
	</div>

	<!-- 员工添加的模态框 -->
	<div class="modal fade" id="empModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">新增员工</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal" id="add">
				  <div class="form-group">
				    <label  class="col-sm-2 control-label">EmpName</label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control"  name="empName" id="empName" placeholder="EmpName">
				      <span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label  class="col-sm-2 control-label">Tel</label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control"  name="tel" id="tel" placeholder="Tel">
				      <span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label  class="col-sm-2 control-label">Email</label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control"  name="email" id="email" placeholder="Email">
				      <span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
					    <label  class="col-sm-2 control-label">Gender</label>
					    <div class="col-sm-10">
					        <label class="radio-inline">
							  <input type="radio" name="gender" id="gender1" value="M" checked="checked"> 男
							</label>
							<label class="radio-inline">
							  <input type="radio" name="gender" id="gender2" value="F"> 女
							</label>
					    </div>
				  </div>
				  <div class="form-group">
				  	<label  class="col-sm-2 control-label">DeptName</label>
				    <div class="col-sm-4">
						<select class="form-control" name="deptId" id="deptId">
						</select>
					</div>
				  </div>
				</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal" id="closeModal">关闭</button>
	        <button type="button" class="btn btn-primary" id="saveModal">保存</button>
	      </div>
	    </div>
	  </div>
	</div>

	<div class="container ">
		<!-- 显示标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		
		<!-- 显示按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="addEmp">新增</button>
				<button class="btn btn-danger" id="deleteEmps">删除</button>
			</div>
		</div>
		
		<!-- 显示表格信息 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<td><input type="checkbox" id="checkAll"/></td>
							<td>#</td>
							<td>EmpName</td>
							<td>Gender</td>
							<td>Email</td>
							<td>Tel</td>
							<td>DeptName</td>
							<td>操作</td>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 显示分页文字信息 -->
			<div class="col-md-6" id="pageData"></div>
			<!-- 显示分页条 -->
			<div class="clo-md-6" id="navi"></div>
		</div>
	</div>
</body>
<script type="text/javascript">
		$(function(){
			getEmpData(1);
		});
		
		var totalResult;
		var currentPage;
		var checkEmpName = false;
		//获取表格数据
		var getEmpData = function(pagenum){
			$.ajax({
				url:"emps",
				data:{"pagenum":pagenum},
				success:function(data){
					//console.log(data);
					buildEempsTtable(data);
					buildNavi(data);
				}
			});
		}
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
		//弹出模态框，向数据库中获取部门信息
		$("#addEmp").click(function(){
			//1.每次弹出模态框前应该将其内容清除(表单重置)防止其跳过某些验证
			resetForm("#add");
			
			//2.获取部门信息
			getDepts("#deptId");
			//3.弹出模态框
			$("#empModal").modal({
				backdrop:"static"
			});
		});
		
		var resetForm = function(ele){
			//1.清除数据
			$(ele)[0].reset();//JQuery 中没有 reset 方法，其属于 DOM
			//2.清除所有的 class
			$(ele).find("*").removeClass("has-success has-error");
			//3.清空辅助元素的值
			$(ele).find(".help-block").text("");
		}
		//获取部门信息
		var getDepts = function(ele){
			$(ele).empty();
			$.ajax({
				url:"depts",
				type:"GET",
				success:function(data){
					$.each(data.map.depts,function(index,item){
						$(ele).append($("<option></option>").append(item.deptName).attr("value",item.deptId));
					});
					//console.log(data);
				}
			});
		}
		$("#saveModal").click(function(){
			//校验表单数据
			 if(!validateForm()){
				return false;
			} 
			//验证用户名是否可用
			if(!checkEmpName){
				return false;
			}
			
			//当用户名和表单信息都合法时尝试向数据库中保存信息
			$.ajax({
				url:"add",
				type:"POST",
				data:$("#add").serialize(),
				success:function(data){
					//后台检验结果
					if(data.code == 100){
						//提示信息
						alert(data.msg);
						//关闭模态框
						$('#empModal').modal('hide');
						/**
							显示添加的数据，即显示最后一页，这里有一个小细节，传一个大于总页数值，
							pageHelper 插件会帮我们自动查询最后一页的值，所以这里只需传入一个
							较大值即可，我这里传入数据的总数量。
						*/
						getEmpData(totalResult);
					}else{
						if(data.map.error.email != undefined){
							showValidateMsg("#email","error",data.map.error.email);
						}
						/*...*/
					}
				}			
			});
		});
		
		//验证表单数据
		var validateForm = function(){
			var name = $("#empName").val();
			var regName = /(^[a-zA-Z0-9_-]{5,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if(!regName.test(name)){
				showValidateMsg("#empName","error","用户名可以为2-5位中文或者5-16字母和数字的组合!");
				//alert("用户名可以为2-5位中文或者5-16字母和数字的组合!");
				return false;
			}else{
				showValidateMsg("#empName","success","");
			}
			var tel = $("#tel").val();
			var regTel = /^[0-9]{5,11}$/;
			if(!regTel.test(tel)){
				showValidateMsg("#tel","error","电话号码不合法!");
				//alert("电话号码不合法");
				return false;
			}else{
				showValidateMsg("#tel","success","");
			}
			
			var email = $("#email").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				showValidateMsg("#email","error","邮箱不合法!");
				//alert("邮箱不合法");
				return false;
			}else{
				showValidateMsg("#email","success","");
			}
			return true;
		};
		
		var showValidateMsg = function(ele,status,msg){
			//每次校验前先要移除以前的校验状态
			$(ele).parent().removeClass("has-success has-error");
			if(status == "success"){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if(status == "error"){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		//检验用户名是否可用
		$("#empName").change(function(){
			var name = $("#empName").val().trim();
			var regName = /(^[a-zA-Z0-9_-]{5,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			//1.先判断 name 是否满足正则表达式，再说用户名是否可用
			if(!regName.test(name)){
				showValidateMsg("#empName","error","用户名可以为2-5位中文或者5-16字母和数字的组合!");
				return false;
			}
			//2.当用户名满足要求时，判断用户名是否可用
			$.ajax({
				url:"checkEmpName",
				type:"POST",
				data:{"name":name,"time":new Date()},
				success:function(data){
					if(data.code == 100){
						showValidateMsg("#empName","success","用户名可用");
						checkEmpName = true;
					}else{
						showValidateMsg("#empName","error","用户名不可用");
						checkEmpName = false;
					}
				}
				
			});
		});
		
		//为编辑按钮绑定单击事件
		$(document).on("click",".edit-bnt",function(){
			//1.清除表单样式
			resetForm("#updateModal form");
			//2.获取部门信息，并显示
			getDepts("#updateModal select");
			//3.获取当前员工信息，并显示
			getEmp($(this).attr("empId"));
			//4.将当前员工的 id 传递到 更新 按钮上，方便更新数据
			$("#updateButton").attr("empId",$(this).attr("empId"));
			$("#updateModal").modal({
				backdrop:"static"
			});
		});
		var getEmp = function(id){
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(data){
					var empData = data.map.emp;
					$("#empId").val(empData.empId);
					$("#updateEmpName").text(empData.empName);
					$("#updateTel").val(empData.tel);
					$("#updateEmail").val(empData.email);
					$("#updateModal input[name=gender]").val([empData.gender]);
					$("#updateSelectId").val([empData.deptId]);
					//console.log(data);
				}
			});
		}
		$("#updateButton").click(function(){
			var tel = $("#updateTel").val();
			var regTel = /^[0-9]{5,11}$/;
			if(!regTel.test(tel)){
				showValidateMsg("#updateTel","error","电话号码不合法!");
				return false;
			}else{
				showValidateMsg("#updateTel","success","");
			}
			
			var email = $("#updateEmail").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				showValidateMsg("#updateEmail","error","邮箱不合法!");
				return false;
			}else{
				showValidateMsg("#updateEmail","success","");
			}
			
			$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("empId"),
				type:"PUT",
				data:$("#updateForm").serialize(),
				/* type:"POST",
				data:$("#updateForm").serialize()+"&_method=PUT", */
				success:function(data){
					$('#updateModal').modal('hide');currentPage
					getEmpData(currentPage);
				}
			});
		});
		
		//为删除按钮添加单击事件
		$(document).on("click",".delete-bnt",function(){
			//1.获取当前删除的名字
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			//2.弹出确认框
			if(confirm("确定要删除 "+empName+" 信息吗")){
				//3.确认删除，执行删除操作
				//alert($(this).attr("empId"));
				$.ajax({
					url:"${APP_PATH}/emp/" + $(this).attr("empId"),
					type:"DELETE",
					success:function(data){
						//alert(data.msg);
						getEmpData(currentPage);
					}
				});
			}
		});
		
		//全选/全部选
		$(document).on("click","#checkAll",function(){
			/**
				var flag = $(this).attr("checked");
				在这里获取的是 undefined，最好使用 prop 去获取控件原生的属性值；
				而  使用 attr 去获取自定义的属性值。 
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
		
		//删除多个员工
		$(document).on("click","#deleteEmps",function(){
			var delNames = "";
			var delIds = "";
			var checkItems = $(".checkItem:checked");
			$.each(checkItems,function(index,item){
				delNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
				delIds += $(this).parents("tr").find("td:eq(1)").text() + "-";
			});
			//去除末尾多余的 ","
			delNames = delNames.substring(0,delNames.length-1);
			//去除末尾多余的 "-"
			delIds = delIds.substring(0,delIds.length-1);
			
			if(confirm("确定要删除 "+delNames+" 的信息吗?")){
				
				$.ajax({
					url:"${APP_PATH}/emp/" + delIds,
					type:"DELETE",
					success:function(data){
						alert(data.msg);
						getEmpData(currentPage);
					}
				});
			}
		});
		
</script>
</html>