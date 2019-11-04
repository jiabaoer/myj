package com.jiabaor.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jiabaor.dao.RoleMapper;
import com.jiabaor.pojo.Role;

@Service
public class RoleServiceImpl implements RoleService {

	@Autowired
	private RoleMapper roleMapper;

	public List<Role> getAllRoleNames() {
		return roleMapper.getAllRoleNames(null);
	}

}
