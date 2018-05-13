package cn.edu.pzhu.cg.bean;

import javax.validation.constraints.Pattern;

public class Employee {
    private Integer empId;

    @Pattern(regexp="(^[a-zA-Z0-9_-]{5,16}$)|(^[\\u2E80-\\u9FFF]{2,5})",
    		 message="用户名可以为2-5位中文或者5-16字母和数字的组合!")
    private String empName;

    private String gender;

    @Pattern(regexp="^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$",
    		 message="邮箱不合法!")
    private String email;

    //@Pattern(regexp="^[0-9]{5,6}$",message="电话号码不合法!")
    private Integer tel;

    private Integer deptId;

    private Department dept;
    
    
    public Employee() {
		super();
		// TODO Auto-generated constructor stub
	}

    
	public Employee(Integer empId, String empName, String gender, String email, Integer tel, Integer deptId) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.gender = gender;
		this.email = email;
		this.tel = tel;
		this.deptId = deptId;
	}


	public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender == null ? null : gender.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Integer getTel() {
        return tel;
    }

    public void setTel(Integer tel) {
        this.tel = tel;
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

	public Department getDept() {
		return dept;
	}

	public void setDept(Department dept) {
		this.dept = dept;
	}

	@Override
	public String toString() {
		return "Employee [empId=" + empId + ", empName=" + empName + ", gender=" + gender + ", email=" + email
				+ ", tel=" + tel + ", deptId=" + deptId + ", dept=" + dept + "]";
	}


    
}