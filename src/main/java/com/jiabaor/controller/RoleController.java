package com.jiabaor.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jiabaor.pojo.Role;
import com.jiabaor.service.RoleService;

@Controller
public class RoleController {

	@Autowired
	private RoleService roleService;
	
	@ResponseBody
	@RequestMapping(value="/roleNames",method=RequestMethod.GET)
	public Map<String, Object> getAllRoleNames(){
		List<Role> list=roleService.getAllRoleNames();
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("extend", list);
		return map;
	}
}
