package com.jiabaor.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.jiabaor.pojo.User;

public interface UserMapper {
	User UserLogin(@Param("userCode") String userCode, @Param("userPassword") String userPassword);

	List<User> userById(Integer id);

	List<User> userByIdDtail(Integer id);

	int updateUserById(User user);

	int updatePasswordById(@Param("id")Integer id, @Param("userPassword")String userPassword);
}