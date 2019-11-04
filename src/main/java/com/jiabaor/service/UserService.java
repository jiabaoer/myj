package com.jiabaor.service;

import java.util.List;

import com.jiabaor.pojo.User;

public interface UserService {

	User UserLogin(String userCode,String userPassword);

	List<User> userById(Integer id);

	List<User> userByIdDtail(Integer id);

	boolean updateUserById(User user);

	boolean updatePasswordById(Integer id, String userPassword);
}
