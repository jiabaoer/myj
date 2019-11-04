package com.jiabaor.service;

import java.util.List;

import com.jiabaor.pojo.Provider;

public interface ProviderService {
	List<Provider> providerDtailById(Integer id);

	boolean updatePrviderDtail(Provider provider);

	boolean ordereDeleteDtailById(Integer id);

	List<Provider> providListByName(Integer id);

	boolean addProviderByUser(Provider provider);

	List<Provider> selectProviderConditionsById(Integer id, String queryProCode, String queryProName);

}
