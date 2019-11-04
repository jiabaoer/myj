package com.jiabaor.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jiabaor.dao.UserMapper;
import com.jiabaor.pojo.User;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userMapper;

	/**
	 * µÇÂ¼
	 */
	public User UserLogin(String userCode, String userPassword) {
		return userMapper.UserLogin(userCode,userPassword);
	}

	public List<User> userById(Integer id) {
		return userMapper.userById(id);
	}

	public List<User> userByIdDtail(Integer id) {
		return userMapper.userByIdDtail(id);
	}

	public boolean updateUserById(User user) {
		int row=userMapper.updateUserById(user);
		if (row>0) {
			return true;
		}else {
			return false;
		}
	}

	public boolean updatePasswordById(Integer id, String userPassword) {
		int row=userMapper.updatePasswordById(id,userPassword);
		if (row>0) {
			return true;
		}else {
			return false;
		}
	}

}
