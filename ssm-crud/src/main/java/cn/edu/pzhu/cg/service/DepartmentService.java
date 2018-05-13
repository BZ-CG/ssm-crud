package cn.edu.pzhu.cg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.edu.pzhu.cg.bean.Department;
import cn.edu.pzhu.cg.dao.DepartmentMapper;

@Service
public class DepartmentService {
	
	@Autowired
	private DepartmentMapper departmentMapper;
	
	public List<Department> getDepts(){
		return departmentMapper.selectByExample(null);
	}
}
  