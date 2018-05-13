package cn.edu.pzhu.cg.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import cn.edu.pzhu.cg.bean.Employee;
import cn.edu.pzhu.cg.bean.Msg;
import cn.edu.pzhu.cg.service.EmployeeService;

@Controller
public class EmployeeController {

	@Autowired
	private EmployeeService empService;
	
	
	/**
	 * 
	    * @Title: 删除单个、批量二合一
	    * @param @param 带有 ID 的字符串
	    * @param @return    参数
	    * @return Msg    返回类型
	 */
	@RequestMapping(value="/emp/{id}",method=RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmpById(@PathVariable("id") String idStr) {
		//System.out.println(idStr);
		//批量删除;
		if(idStr.contains("-")) {
			List<Integer> ids = new ArrayList<Integer>();
			String[] deleIdStr = idStr.split("-");
			for (String id : deleIdStr) {
				ids.add(Integer.parseInt(id));
			}
			empService.deleteEmpBatch(ids);
		}else {
			empService.deleteEmpById(Integer.parseInt(idStr));
		}
		return Msg.success();
	}
	
	
	
	/**
	 * 
	    * @Title: 前端发送 PUT 请求，修改员工信息。
	    * @param @param employee
	    * @param @return    参数
	    * @return Msg    返回类型
	    * 如果使用 JQuery 直接发送 PUT 请求，需要添加上 org.springframework.web.filter.HttpPutFormContentFilter
	    *   否则，Tomcat 不会将给 PUT 请求的参数传送到后台，该过滤器的作用就是重新将数据包装到 request 中。
	 */
	@RequestMapping(value="/emp/{id}",method=RequestMethod.PUT)
	@ResponseBody
	public Msg updateEmp(Employee employee) {
		empService.updateEmp(employee);
		return Msg.success();
	}
	
	/**
	 * 
	 * @Description: TODO(根据 ID 返回员工信息)
	 * @param @param id
	 * @param @return    参数
	 * @return Msg    返回类型
	 * @throws
	 */
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmpById(@PathVariable("id") Integer id) {
		Employee emp = empService.getEmpById(id);
		return Msg.success().add("emp", emp);
	}
	
	@RequestMapping("/checkEmpName")
	@ResponseBody
	public Msg checkEmpName(String name) {
		Employee empByName = empService.getEmpByName(name);
		if(empByName == null) {
			return Msg.success();
		}
		return Msg.fail();
	}
	
	@RequestMapping(value="/add",method=RequestMethod.POST)
	@ResponseBody
	public Msg addEmp(@Valid Employee employee,BindingResult result) {
		if(result.hasErrors()) {
			Map<String, Object> errorMap = new HashMap<String, Object>();
			List<FieldError> fieldErrors = result.getFieldErrors();
			for (FieldError error : fieldErrors) {
//				System.out.println("出错的属性名: " + error.getField());
//				System.out.println("出错的信息: " + error.getDefaultMessage());
				errorMap.put(error.getField(), error.getDefaultMessage());
			}
			return Msg.fail().add("error", errorMap);
		}
		System.out.println(employee);
		empService.addEmp(employee);
		return Msg.success();
	}
	
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value=("pagenum"),defaultValue="1") Integer pagenum) {
		//每页显示5条
		PageHelper.startPage(pagenum, 5);
		List<Employee> emps = empService.getAllEmps();
		//连续显示5页
		PageInfo pageInfo = new PageInfo(emps,5);
		
		return Msg.success().add("pageInfo", pageInfo);
	}
	
	//@RequestMapping("/emps")
	public String emps(@RequestParam(value=("pagenum"),defaultValue="1") Integer pagenum,Model model) {
		//每页显示5条
		PageHelper.startPage(pagenum, 5);
		List<Employee> emps = empService.getAllEmps();
		//连续显示5页
		PageInfo pageInfo = new PageInfo(emps,5);
		model.addAttribute("pageInfo", pageInfo);
		
		return "emps";
	}
}
  