package cn.edu.pzhu.cg.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;

import cn.edu.pzhu.cg.bean.Employee;

/**  
* 使用 Spring 测试模块提供的测试请求功能，测试 crud 请求。
*/
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations= {"classpath:appliationContext.xml","classpath:springmvc.xml"})
public class MvcTest {
	
	//传入 SpringMVC 的 IOC,需要加上 @WebAppConfiguration
	@Autowired
	WebApplicationContext context;
	
	//虚拟的 MVC 请求
	MockMvc mockMvc;
	
	@Before
	public void initMock() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	public void testPage() throws Exception {
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pagenum", "10")).andReturn();
		MockHttpServletRequest request = result.getRequest();
		
		PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
		
		System.out.println("当前页码: " + pageInfo.getPageNum());
		System.out.println("总页数: " + pageInfo.getPages());
		System.out.println("每页显示的记录数: " + pageInfo.getPageSize());
		System.out.println("总记录数: " + pageInfo.getTotal());
		//System.out.println("最后一页: " + pageInfo.getNavigateLastPage());
		System.out.println("连续显示的页码: ");
		int[] nums = pageInfo.getNavigatepageNums();
		for (int i : nums) {
			System.out.print(i + " ");
		}
		
		System.out.println();
		
		List<Employee> emps = (List<Employee>)pageInfo.getList();
		for (Employee employee : emps) {
			System.out.println(employee );
		}
	}
}
  