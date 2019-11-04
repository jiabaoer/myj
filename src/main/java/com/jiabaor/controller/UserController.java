package com.jiabaor.controller;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jiabaor.pojo.Msg;
import com.jiabaor.pojo.User;
import com.jiabaor.service.UserService;

@Controller
public class UserController {

	@Autowired
	private UserService userService;

	@RequestMapping("login")
	public String login() {
		return "login";
	}
	/**
	 * ��¼
	 */
	@RequestMapping(value = "/Userlogin", method = RequestMethod.POST)
	public String UserLogiWn(String userCode, String userPassword, Model model, HttpSession session) {
		User user = userService.UserLogin(userCode, userPassword);
		if (user != null) {
			// ����idȫ�ַ���
			session.setAttribute("id", user.getId());
			// ����ȫ��createdBy������
			session.setAttribute("createdBy", user.getCreatedBy());
			model.addAttribute("user", user);
			return "main";
		} else {
			model.addAttribute("loginInfo", "�û������������");
			return "login";
		}
	}

	// ��ѯ�û�
	@ResponseBody
	@RequestMapping(value = "/userById", method = RequestMethod.GET)
	public Map<String, Object> userListAll(HttpServletRequest request) {
		// PageHelper.startPage(pn, 5);
		// ��ȡ�û�Ψһid
		Integer id = (Integer) request.getSession().getAttribute("id");
		List<User> list = userService.userById(id);
		// PageInfo pageInfo = new PageInfo(list, 5);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("extend", list);
		return map;
	}

	// ��ѯ�����û���Ϣ
	// ��Ʒ������ѯ
	@RequestMapping(value = "/userDtail", method = RequestMethod.GET)
	public ModelAndView userByIdDtail(Integer id) {
		List<User> list = userService.userByIdDtail(id);
		ModelAndView model = new ModelAndView("user_detail");
		model.addObject("list", list);
		return model;
	}

	// ��ѯ�����޸��û���Ϣ
	@RequestMapping(value = "/userUpdateDtail", method = RequestMethod.GET)
	public ModelAndView userUpdateDtailById(Integer id) {
		List<User> list = userService.userByIdDtail(id);
		ModelAndView model = new ModelAndView("user_update");
		model.addObject("list", list);
		return model;
	}

	// �޸��û���Ϣ
	@RequestMapping(value = "/updateUser", method = RequestMethod.GET)
	public Msg updateUserById(User user) {
		boolean bl = userService.updateUserById(user);
		if (bl) {
			return Msg.success();
		} else {
			return Msg.fail();
		}
	}

	// �޸��û�����
	@ResponseBody
	@RequestMapping(value = "/updatePasswordById", method = RequestMethod.GET)
	public Msg updatePassword(String userPassword, HttpServletRequest request) {
		// ��ȡȫ���û���Id
		Integer id = (Integer) request.getSession().getAttribute("id");
		boolean bl = userService.updatePasswordById(id, userPassword);
		if (bl) {
			return Msg.success();
		} else {
			return Msg.fail();
		}
	}

	// ɾ��ȫ�ֱ���
	@RequestMapping(value = "/deleteSession")
	public String deleteSession(HttpServletRequest request) {
		request.getSession().removeAttribute("id");
		request.getSession().removeAttribute("createdBy");
		return "login";
	}
}
