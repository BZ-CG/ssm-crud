package cn.edu.pzhu.cg.bean;

import java.util.HashMap;
import java.util.Map;

/**  
* 自定义处理 JSON 结果  :
* 	1.返回用户当前操作的状态。
* 	2.携带当前操作的数据。
*/
public class Msg {

	//返回的状态码 ，100-成功 ，200-失败
	private Integer code;
	
	//需要给用户的提示信息
	private String msg;
	
	private Map<String, Object> map = new HashMap<String, Object>();

	
	public static Msg success() {
		return new Msg(100, "操作成功");
	}
	
	public static Msg fail() {
		return new Msg(200, "操作失败");
	}
	
	public Msg add(String key,Object value) {
		this.map.put(key, value);
		return this;
	}
	
	public Msg() {
		super();
	}

	public Msg(Integer code, String msg) {
		super();
		this.code = code;
		this.msg = msg;
	}

	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Map<String, Object> getMap() {
		return map;
	}

	public void setMap(Map<String, Object> map) {
		this.map = map;
	}
	
}
  