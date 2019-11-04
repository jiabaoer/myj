package com.jiabaor.dao;

import com.jiabaor.pojo.Bill;
import com.jiabaor.pojo.BillExample;
import com.jiabaor.pojo.Provider;
import com.jiabaor.pojo.Search;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface BillMapper {
	List<Bill> selectByExampleWithDept(Integer id);

	List<Bill> selectFrom(Search search);

	List<Bill> getByIdDtail(Integer id);

	int updateDtailByid(Bill bill);

	int ordereDeleteDtail(Integer id);

	List<Provider> providListByName(Integer id);

	int addOrderById(Bill bill);

}