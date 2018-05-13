package cn.edu.pzhu.cg.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import cn.edu.pzhu.cg.bean.Employee;
import cn.edu.pzhu.cg.bean.EmployeeExample;
import cn.edu.pzhu.cg.bean.EmployeeExample.Criteria;
import cn.edu.pzhu.cg.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	private EmployeeMapper employeeMapper;
	
	public List<Employee> getAllEmps(){
		EmployeeExample example = new EmployeeExample();
		example.setOrderByClause("e.emp_id");
		return employeeMapper.selectByExampleWithDept(example);
	}

	public void addEmp(Employee employee) {
		employeeMapper.insertSelective(employee);
		
	}
	
	public Employee getEmpByName(String name) {
		return employeeMapper.getEmpByName(name);
	}
	
	public Employee getEmpById(Integer id) {
		return employeeMapper.selectByPrimaryKey(id);
	}

	
	public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}

	
	public void deleteEmpById(Integer id) {
		 employeeMapper.deleteByPrimaryKey(id);
	}
	
	public void deleteEmpBatch(List<Integer> ids) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpIdIn(ids);
		//delete from tbl_emp where emp_id in(...);
		employeeMapper.deleteByExample(example);
	}
}
  