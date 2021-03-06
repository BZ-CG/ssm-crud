package cn.edu.pzhu.cg.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import cn.edu.pzhu.cg.service.EmployeeService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:appliationContext.xml"})
public class ServiceTest {
	
	@Autowired
	private EmployeeService employeeService;
	
	@Test
	public void testQueryByName() {
		String name = "张超";
		System.out.println(employeeService.getEmpByName(name));
	}
}
  