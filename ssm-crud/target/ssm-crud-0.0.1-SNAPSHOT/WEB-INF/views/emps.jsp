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

</head>
<body>
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
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		
		<!-- 显示表格信息 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<td>#</td>
						<td>EmpName</td>
						<td>Gender</td>
						<td>Email</td>
						<td>Tel</td>
						<td>DeptName</td>
						<td>操作</td>
					</tr>
					<c:forEach items="${pageInfo.list }" var="temp">
						<tr>
							<td>${temp.empId }</td>
							<td>${temp.empName }</td>
							<td>${temp.gender == "M" ? "男":"女" }</td>
							<td>${temp.email }</td>
							<td>${temp.tel }</td>
							<td>${temp.dept.deptName }</td>
							<td>
								<button class="btn btn-info btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
									修改
								</button>
								<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
								</button>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 显示分页文字信息 -->
			<div class="col-md-6">
				当前${pageInfo.pageNum }页,共有${pageInfo.pages }页,一共有 ${pageInfo.total} 条数据。
			</div>
			<!-- 显示分页条 -->
			<div class="clo-md-6">
				<nav aria-label="Page navigation">
				  <ul class="pagination">
				    <li><a href="emps?pagenum=1">首页</a></li>
				   
				   	<!-- 如果当前为第一页不能点击上一页 -->
				    <c:if test="${pageInfo.pageNum <= 1 }">
				      	<li class="disabled">
					      <span> 
					        <span aria-hidden="true">&laquo;</span>
					      </span>
					    </li>
				    </c:if>
				    <c:if test="${pageInfo.hasPreviousPage}"><!-- 有上一页才能点击上一页 -->
				    	<li>
				    		 <a href="emps?pagenum=${pageInfo.pageNum-1 }" aria-label="Previous">
						        <span aria-hidden="true">&laquo;</span>
						     </a>
				    	</li>
				    </c:if>
				    
				    <c:forEach items="${pageInfo.navigatepageNums }" var="i">
					    <c:if test="${i==pageInfo.pageNum }">
						    <li class="active"><a href="#">${i }</a></li>
					    </c:if>
					    <c:if test="${i!=pageInfo.pageNum }">
						    <li><a href="emps?pagenum=${i }">${i }</a></li>
					    </c:if>
				    </c:forEach>
				    
				    <!-- 最后一页，不能再点击下一页 -->
				    <c:if test="${pageInfo.pageNum >= pageInfo.pages }">
				    	<li class="disabled">
					      <span>
					        <span aria-hidden="true">&raquo;</span>
					      </span>
					    </li>
				    </c:if>
				    <c:if test="${pageInfo.pageNum < pageInfo.pages }">
				    	<li>
				    		<a href="emps?pagenum=${pageInfo.pageNum+1 }" aria-label="Next">
						        <span aria-hidden="true">&raquo;</span>
						    </a>
				    	</li>
				    </c:if>
				    
				    <li><a href="emps?pagenum=${pageInfo.pages }">末页</a></li>
				  </ul>
				</nav>
			</div>
		</div>
	
	</div>
</body>
</html>