package com.jiabaor.controller;

import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonCreator.Mode;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiabaor.pojo.Bill;
import com.jiabaor.pojo.Msg;
import com.jiabaor.pojo.Provider;
import com.jiabaor.pojo.Search;
import com.jiabaor.service.BillService;

@Controller
public class BillController {

	@Autowired
	private BillService billService;

	/*
	 * ��ѯ��������
	 */
	@RequestMapping(value = "/orderListAll", method = RequestMethod.GET)
	public String getBillAll(@RequestParam(value = "pn", defaultValue = "1") Integer pn, HttpServletRequest request,Model model) {
		// ��ȡ�û�Ψһid
		Integer id = (Integer) request.getSession().getAttribute("id");
		PageHelper.startPage(pn, 5);
		List<Bill> list = billService.getBillAll(id);
		PageInfo pageInfo = new PageInfo(list, 5);
		model.addAttribute("pageInfo", pageInfo);
		return "orderlist";
	}

	// ��Ӧ����������������б�
	@ResponseBody
	@RequestMapping(value = "/provids", method = RequestMethod.GET)
	public Msg providListByName(HttpServletRequest request) {
		// ��ȡ�û�Ψһid
		Integer id = (Integer) request.getSession().getAttribute("id");
		List<Provider> provids = billService.providListByName(id);
		return Msg.success().add("provids", provids);
	}

	// ����������ѯ
	@ResponseBody
	@RequestMapping(value = "/selects", method = RequestMethod.GET)
	public Msg selectFrom(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Search search,
			HttpServletRequest request) {
		// ��ȡ�û�Ψһid
		Integer id = (Integer) request.getSession().getAttribute("id");
		search.setId(id);
		PageHelper.startPage(pn, 5);
		List<Bill> list = billService.selectFrom(search);
		PageInfo pageInfo = new PageInfo(list, 5);
		return Msg.success().add("pageInfo", pageInfo);
	}

	// ��Ʒ������ѯ
	@RequestMapping(value = "/ordereDtail", method = RequestMethod.GET)
	public ModelAndView ordereByIdDtail(Integer id) {
		List<Bill> list = billService.getByIdDtail(id);
		ModelAndView model = new ModelAndView("order_detail");
		model.addObject("list", list);
		return model;
	}

	// ��Ʒ�����޸�
	@RequestMapping(value = "/ordereUpdateDtail", method = RequestMethod.GET)
	public ModelAndView ordereUpdateDtail(Integer id) {
		List<Bill> list = billService.getByIdDtail(id);
		ModelAndView model = new ModelAndView("order_update");
		model.addObject("list", list);
		return model;
	}

	// �޸���Ʒ����
	@ResponseBody
	@RequestMapping(value = "/updateDtail", method = RequestMethod.POST)
	public Msg updateDtailByid(Bill bill) {
		boolean bl = billService.updateDtailByid(bill);
		if (bl) {
			return Msg.success();
		} else {
			return Msg.fail();
		}
	}

	// ��Ʒ����ɾ������Id
	@ResponseBody
	@RequestMapping(value = "/ordereDeleteDtail", method = RequestMethod.GET)
	public Msg ordereDeleteDtail(Integer id) {
		boolean bl = billService.ordereDeleteDtail(id);
		if (bl) {
			return Msg.success();
		} else {
			return Msg.fail();
		}
	}

	// ��ӽ�����
	@ResponseBody
	@RequestMapping(value = "/addOrder", method = RequestMethod.POST)
	public Msg addOrderById(@RequestParam(value="productImg")MultipartFile productImg,Bill bill, HttpServletRequest request) throws Exception {
		// ��ȡ�û�Ψһid
		Integer createdBy = (Integer) request.getSession().getAttribute("createdBy");
		bill.setCreatedByUser(createdBy);
		// ���ô���ʱ��
		bill.setCreationDateBl(new Date());
		if (productImg != null) {
			// ����ͼƬ
			// ʹ��UUID��ͼƬ��������ȥ���ĸ���-��
			// ת��ΪMultipartHttpRequest  
			String name = UUID.randomUUID().toString().replaceAll("-", "");
			// ��ȡͼƬ��·��
			String ext = FilenameUtils.getExtension(productImg.getOriginalFilename());
			// ����ͼƬ�ϴ�·��
			String url = request.getSession().getServletContext().getRealPath("/images");
			// �Ծ���·���������������ͼƬ
			productImg.transferTo(new File(url + "/" + name + "." + ext));
			// ��ͼƬ�洢·�����浽���ݿ�
			bill.setProductImg("images/" + name + "." + ext);
		} else {
			bill.setProductImg("images/buy.png");
		}
		boolean bl = billService.addOrderById(bill);
		if (bl) {
			return Msg.success();
		} else {
			return Msg.fail();
		}
	}

}
