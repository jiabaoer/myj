package com.jiabaor.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jiabaor.dao.BillMapper;
import com.jiabaor.pojo.Bill;
import com.jiabaor.pojo.Provider;
import com.jiabaor.pojo.Search;

@Service
public class BillServiceImpl implements BillService {

	@Autowired
	private BillMapper billMapper;

	public List<Bill> getBillAll(Integer id) {
		return billMapper.selectByExampleWithDept(id);
	}

	public List<Bill> selectFrom(Search search) {
		return billMapper.selectFrom(search);
	}

	public List<Bill> getByIdDtail(Integer id) {
		return billMapper.getByIdDtail(id);
	}

	public boolean updateDtailByid(Bill bill) {
		int row = billMapper.updateDtailByid(bill);
		if (row > 0) {
			return true;
		} else {
			return false;
		}
	}

	public boolean ordereDeleteDtail(Integer id) {
		int row=billMapper.ordereDeleteDtail(id);
		if (row>0) {
			return true;
		}else {
			return false;
		}
	}

	public List<Provider> providListByName(Integer id) {
		return billMapper.providListByName(id);
	}

	public boolean addOrderById(Bill bill) {
		int row=billMapper.addOrderById(bill);
		if (row>0) {
			return true;
		}else {
			return false;
		}
	}

}
