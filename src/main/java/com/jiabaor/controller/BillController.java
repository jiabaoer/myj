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
	 * 查询所有数据
	 */
	@RequestMapping(value = "/orderListAll", method = RequestMethod.GET)
	public String getBillAll(@RequestParam(value = "pn", defaultValue = "1") Integer pn, HttpServletRequest request,Model model) {
		// 获取用户唯一id
		Integer id = (Integer) request.getSession().getAttribute("id");
		PageHelper.startPage(pn, 5);
		List<Bill> list = billService.getBillAll(id);
		PageInfo pageInfo = new PageInfo(list, 5);
		model.addAttribute("pageInfo", pageInfo);
		return "orderlist";
	}

	// 供应商搜索界面的下拉列表
	@ResponseBody
	@RequestMapping(value = "/provids", method = RequestMethod.GET)
	public Msg providListByName(HttpServletRequest request) {
		// 获取用户唯一id
		Integer id = (Integer) request.getSession().getAttribute("id");
		List<Provider> provids = billService.providListByName(id);
		return Msg.success().add("provids", provids);
	}

	// 根据条件查询
	@ResponseBody
	@RequestMapping(value = "/selects", method = RequestMethod.GET)
	public Msg selectFrom(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Search search,
			HttpServletRequest request) {
		// 获取用户唯一id
		Integer id = (Integer) request.getSession().getAttribute("id");
		search.setId(id);
		PageHelper.startPage(pn, 5);
		List<Bill> list = billService.selectFrom(search);
		PageInfo pageInfo = new PageInfo(list, 5);
		return Msg.success().add("pageInfo", pageInfo);
	}

	// 商品单个查询
	@RequestMapping(value = "/ordereDtail", method = RequestMethod.GET)
	public ModelAndView ordereByIdDtail(Integer id) {
		List<Bill> list = billService.getByIdDtail(id);
		ModelAndView model = new ModelAndView("order_detail");
		model.addObject("list", list);
		return model;
	}

	// 商品单个修改
	@RequestMapping(value = "/ordereUpdateDtail", method = RequestMethod.GET)
	public ModelAndView ordereUpdateDtail(Integer id) {
		List<Bill> list = billService.getByIdDtail(id);
		ModelAndView model = new ModelAndView("order_update");
		model.addObject("list", list);
		return model;
	}

	// 修改商品内容
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

	// 商品单个删除根据Id
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

	// 添加进货单
	@ResponseBody
	@RequestMapping(value = "/addOrder", method = RequestMethod.POST)
	public Msg addOrderById(@RequestParam(value="productImg")MultipartFile productImg,Bill bill, HttpServletRequest request) throws Exception {
		// 获取用户唯一id
		Integer createdBy = (Integer) request.getSession().getAttribute("createdBy");
		bill.setCreatedByUser(createdBy);
		// 设置创建时间
		bill.setCreationDateBl(new Date());
		if (productImg != null) {
			// 设置图片
			// 使用UUID给图片命名，并去掉四个“-”
			// 转型为MultipartHttpRequest  
			String name = UUID.randomUUID().toString().replaceAll("-", "");
			// 获取图片的路径
			String ext = FilenameUtils.getExtension(productImg.getOriginalFilename());
			// 设置图片上传路径
			String url = request.getSession().getServletContext().getRealPath("/images");
			// 以绝对路径保存重命名后的图片
			productImg.transferTo(new File(url + "/" + name + "." + ext));
			// 把图片存储路径保存到数据库
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
