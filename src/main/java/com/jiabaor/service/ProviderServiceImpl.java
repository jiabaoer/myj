package com.jiabaor.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jiabaor.dao.ProviderMapper;
import com.jiabaor.pojo.Bill;
import com.jiabaor.pojo.Provider;

@Service
public class ProviderServiceImpl implements ProviderService {

	@Autowired
	ProviderMapper providerMapper;

	public List<Provider> providerDtailById(Integer id) {
		return providerMapper.providerDtailById(id);
	}

	public boolean updatePrviderDtail(Provider provider) {
		int row = providerMapper.updateDtailByid(provider);
		if (row > 0) {
			return true;
		} else {
			return false;
		}
	}

	public boolean ordereDeleteDtailById(Integer id) {
		int row = providerMapper.ordereDeleteDtailById(id);
		if (row > 0) {
			return true;
		} else {
			return false;
		}
	}

	public List<Provider> providListByName(Integer id) {
		return providerMapper.getProvidListByName(id);
	}

	public boolean addProviderByUser(Provider provider) {
		int row = providerMapper.addProviderByUser(provider);
		if (row > 0) {
			return true;
		} else {
			return false;
		}
	}

	public List<Provider> selectProviderConditionsById(Integer id, String queryProCode, String queryProName) {
		return providerMapper.selectProviderConditionsById(id,queryProCode,queryProName);
	}
}
