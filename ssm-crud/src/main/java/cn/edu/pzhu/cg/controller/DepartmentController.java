package cn.edu.pzhu.cg.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.edu.pzhu.cg.bean.Department;
import cn.edu.pzhu.cg.bean.Msg;
import cn.edu.pzhu.cg.service.DepartmentService;

/*
 * 处理 Department 的相关请求
 */
@Controller
public class DepartmentController {

	@Autowired
	DepartmentService departmentService;
	
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts() {
		List<Department> depts = departmentService.getDepts();
		return Msg.success().add("depts", depts);
	}
}
  