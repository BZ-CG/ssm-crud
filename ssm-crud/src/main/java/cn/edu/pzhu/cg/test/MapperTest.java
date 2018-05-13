package cn.edu.pzhu.cg.test;


import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.edu.pzhu.cg.bean.Department;
import cn.edu.pzhu.cg.bean.DepartmentExample;
import cn.edu.pzhu.cg.bean.Employee;
import cn.edu.pzhu.cg.bean.EmployeeExample;
import cn.edu.pzhu.cg.bean.DepartmentExample.Criteria;
import cn.edu.pzhu.cg.dao.DepartmentMapper;
import cn.edu.pzhu.cg.dao.EmployeeMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:appliationContext.xml"})
public class MapperTest {
	
	@Autowired
	public DepartmentMapper departmentMapper;
	
	@Autowired
	public EmployeeMapper employeeMapper;
	
	@Autowired
	SqlSession sqlsession;
	
	@Test
	public void testQueryDept2() {
		List<Department> depts = departmentMapper.selectByExample(null);
		for (Department department : depts) {
			System.out.println(department);
		}
	}
	
	@Test
	public void testUpdateEmp() {
		//employeeMapper.updateByPrimaryKeySelective(new Employee(26, "emp_26", null, "emp_26@163.com", null, 2));
		
		Employee record = new Employee(null, "update", null, null, null, null);
		EmployeeExample example = new EmployeeExample();
		example.createCriteria().andDeptIdEqualTo(3);
		employeeMapper.updateByExampleSelective(record, example);
	}
	
	@Test
	public void testDeleteEmp() {
		//employeeMapper.deleteByPrimaryKey(28);
		EmployeeExample example = new EmployeeExample();
		example.createCriteria().andEmpNameEqualTo("d4a57");
		
		employeeMapper.deleteByExample(example);
	}
	
	@Test
	public void testQueryEmpWithDept() {
		List<Employee> selectByExampleWithDept = employeeMapper.selectByExampleWithDept(null);
		for (Employee employee : selectByExampleWithDept) {
			System.out.println(employee);
		}
		System.out.println("--------------");
		
		EmployeeExample example = new EmployeeExample();
		example.createCriteria().andGenderEqualTo("F");
		List<Employee> emp = employeeMapper.selectByExampleWithDept(example);
		for (Employee employee : emp) {
			System.out.println(employee);
		}
		System.out.println("--------------");
		
		Employee selectByPrimaryKey = employeeMapper.selectByPrimaryKeyWithDept(1);
		System.out.println(selectByPrimaryKey);
	}
	
	@Test
	public void testInsertBatch() {
		EmployeeMapper mapper = sqlsession.getMapper(EmployeeMapper.class);
		for (int i = 0;i < 500;i++) {
			String name = UUID.randomUUID().toString().substring(0, 5);
			Random random = new Random();
			int did = random.nextInt(4) + 1;
			mapper.insertSelective(new Employee(null, name, "M", name+"@qq.com", 5590, did));
		}
	}
	
	@Test
	public void testInsertEmp() {
		List<Employee> emps = new ArrayList<Employee>();
		emps.add(new Employee(null, "AA", "M", "aa@qq.com", 5590374, 1));
		emps.add(new Employee(null, "BB", "F", "bb@qq.com", 5590372, 2));
		emps.add(new Employee(null, "CC", "M", "cc@qq.com", 5590373, 1));
		emps.add(new Employee(null, "DD", "M", "dd@qq.com", 5590371, 2));
		emps.add(new Employee(null, "EE", "F", "ee@qq.com", 5590375, 4));
		emps.add(new Employee(null, "FF", "F", "ff@qq.com", 5590376, 1));
		emps.add(new Employee(null, "张超", "F", "cg@qq.com", 5590377, 1));
		emps.add(new Employee(null, "李四", "M", "ss@qq.com", 5590378, 2));
		
		for (Employee employee : emps) {
			employeeMapper.insertSelective(employee);
		}
	}
	
	@Test
	public void testQueryDept() {
		DepartmentExample example = new DepartmentExample();
		Criteria createCriteria = example.createCriteria();
		createCriteria.andDeptIdEqualTo(1);
		
		List<Department> depts = departmentMapper.selectByExample(example);
		for (Department department : depts) {
			System.out.println(department);
		}
	}
	@Test
	public void test() {
		departmentMapper.insertSelective(new Department(null, "开发部"));
		departmentMapper.insertSelective(new Department(null, "测试部"));
		departmentMapper.insertSelective(new Department(null, "销售部"));
		departmentMapper.insertSelective(new Department(null, "人事部"));
	} 
	
}
  