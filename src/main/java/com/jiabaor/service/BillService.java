package com.jiabaor.service;

import java.util.List;

import com.jiabaor.pojo.Bill;
import com.jiabaor.pojo.Provider;
import com.jiabaor.pojo.Search;

public interface BillService {

	List<Bill> getBillAll(Integer id);

	List<Bill> selectFrom(Search search);

	List<Bill> getByIdDtail(Integer id);

	boolean updateDtailByid(Bill bill);

	boolean ordereDeleteDtail(Integer id);

	List<Provider> providListByName(Integer id);

	boolean addOrderById(Bill bill);

}
