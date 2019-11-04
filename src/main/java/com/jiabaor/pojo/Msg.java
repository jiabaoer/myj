package com.jiabaor.pojo;

import java.util.HashMap;
import java.util.Map;

import com.jiabaor.pojo.Msg;

/**
 * ͨ�õķ�����
 * 
 * @author lenovo
 *
 */
public class Msg {

	// ״̬�� 100-�ɹ� 200-ʧ��
	private int code;
	// ��ʾ��Ϣ
	private String msg;

	// �û�Ҫ���ظ������������
	private Map<String, Object> extend = new HashMap<String, Object>();

	public static Msg success() {
		Msg msg = new Msg();
		msg.setCode(100);
		msg.setMsg("����ɹ�!");
		return msg;
	}

	public static Msg fail() {
		Msg msg = new Msg();
		msg.setCode(200);
		msg.setMsg("����ʧ��!");
		return msg;
	}

	public Msg add(String key, Object value) {
		this.getExtend().put(key, value);
		return this;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Map<String, Object> getExtend() {
		return extend;
	}

	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}

}
