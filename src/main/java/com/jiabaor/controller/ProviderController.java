package com.jiabaor.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiabaor.pojo.Msg;
import com.jiabaor.pojo.Provider;
import com.jiabaor.service.ProviderService;

@Controller
public class ProviderController {

	@Autowired
	ProviderService providerService;

	// ��ѯ���й�Ӧ��
	@ResponseBody
	@RequestMapping(value = "/providerListAll", method = RequestMethod.GET)
	public ModelAndView providerListAll(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			HttpServletRequest request) {
		PageHelper.startPage(pn, 5);
		// ��ȡ�û�Ψһid
		Integer id = (Integer) request.getSession().getAttribute("id");
		List<Provider> list = providerService.providListByName(id);
		PageInfo pageInfo = new PageInfo(list, 5);
		ModelAndView model=new ModelAndView("provider_list");
		model.addObject("extend", pageInfo);
		return model;
	}

	// �鿴��Ӧ����Ϣ����Id��ѯ
	@RequestMapping(value = "/providerDtail", method = RequestMethod.GET)
	public ModelAndView providerDtailById(Integer id) {
		List<Provider> list = providerService.providerDtailById(id);
		ModelAndView modelAndView = new ModelAndView("provider_detail");
		modelAndView.addObject("list", list);
		return modelAndView;
	}

	// ���¹�Ӧ�̸���Id�޸�
	@RequestMapping(value = "/providerUpdateDtail", method = RequestMethod.GET)
	public ModelAndView providerUpdateDtailById(Integer id) {
		List<Provider> list = providerService.providerDtailById(id);
		ModelAndView modelAndView = new ModelAndView("provider_update");
		modelAndView.addObject("list", list);
		return modelAndView;
	}

	// �޸���Ʒ����
	@ResponseBody
	@RequestMapping(value = "/updatePrviderDtail", method = RequestMethod.POST)
	public Msg updatePrviderDtail(Provider provider) {
		boolean bl = providerService.updatePrviderDtail(provider);
		if (bl) {
			return Msg.success();
		} else {
			return Msg.fail();
		}
	}

	// ����Idɾ��
	@ResponseBody
	@RequestMapping(value = "/providerDeleteDtail", method = RequestMethod.POST)
	public Msg ordereDeleteDtailById(Integer id) {
		boolean bl = providerService.ordereDeleteDtailById(id);
		if (bl) {
			return Msg.success();
		} else {
			return Msg.fail();
		}
	}

	// ���ӹ�Ӧ��
	@ResponseBody
	@RequestMapping(value = "/addProvider", method = RequestMethod.POST)
	public Msg addProviderByUser(Provider provider, HttpServletRequest request) {
		// ��ȡ�û�createdBy
		Integer createdBy = (Integer) request.getSession().getAttribute("createdBy");
		provider.setCreatedByBill(createdBy);
		// ���ù�Ӧ�̴����ĵ�ǰʱ��
		Date date = new Date();
		provider.setCreationDatePro(date);
		boolean bl = providerService.addProviderByUser(provider);
		if (bl) {
			return Msg.success();
		} else {
			return Msg.fail();
		}
	}

	// ����������ѯ���й�Ӧ��
	@ResponseBody
	@RequestMapping(value = "/selectProviderConditions", method = RequestMethod.GET)
	public Map<String, Object> selectProviderConditionsById(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			String queryProCode, String queryProName, HttpServletRequest request) {
		PageHelper.startPage(pn, 5);
		// ��ȡ�û�Ψһid
		Integer id = (Integer) request.getSession().getAttribute("id");
		List<Provider> list = providerService.selectProviderConditionsById(id, queryProCode, queryProName);
		PageInfo pageInfo = new PageInfo(list, 5);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("extend", pageInfo);
		return map;
	}
}
