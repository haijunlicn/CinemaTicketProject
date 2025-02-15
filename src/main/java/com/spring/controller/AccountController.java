package com.spring.controller;

import java.util.ArrayList;
import java.util.List;

import javax.management.relation.Role;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.model.AccountBean;
import com.spring.model.RoleBean;
import com.spring.repository.AccountRepository;
import com.spring.repository.RoleRepository;

@Controller
@RequestMapping("admin")
public class AccountController {
	
	@Autowired
	AccountRepository accRepo;
	
	@Autowired
	RoleRepository roleRepo;
	
	@GetMapping("/adminShell")
	public String showShell() {
		return "adminShell";
	}
	
	@GetMapping("/login")
	public ModelAndView showLogin() {
		return new ModelAndView("adminLogin", "accObj", new AccountBean());
	}
	
	@GetMapping("/adminRegister")
	public ModelAndView showRegister() {
	    ModelAndView mav = new ModelAndView("adminRegister");
	    mav.addObject("accObj", new AccountBean());   
	    mav.addObject("roleList", roleRepo.getAllRole());
	    return mav;
	}

	
	@PostMapping("/adminRegister")
	public String doRegister(@Validated @ModelAttribute("accObj") AccountBean obj, BindingResult br, Model m) {
		if(br.hasErrors()) {
			return "adminRegister";
		}
		
		boolean check = accRepo.checkEmailDuplicate(obj.getEmail());

		if (check) {
			m.addAttribute("error", "Duplicate email!");
			return "adminRegister";
		} else {
			obj.setPassword(BCrypt.hashpw(obj.getPassword(), BCrypt.gensalt(10)));
			// int result = accRepo.registerUser(obj);
			int result = 1;
			if (result == 1) {
				return "redirect:adminDashboard";
			} else {
				m.addAttribute("error", "Register failed!");
				return "adminRegister";
			}
		}
	}
	
	@GetMapping("/adminDashboard")
	public String showDashboard() {
		return "adminDashboard";
	}

	@PostMapping("/login")
	public String doLogin(@ModelAttribute("accObj") AccountBean account, Model m, HttpSession session) {

		AccountBean resAccount = accRepo.loginAccount(account);

		if (resAccount == null) {
			// check if email exists
			m.addAttribute("error", "Incorrect email!");
			return "adminLogin";
		} else if (resAccount.getStatus() == 0) {
			// check if inactive
			m.addAttribute("error", "Inactive account!");
			return "adminLogin";
		} else {
			// check password
			if (BCrypt.checkpw(account.getPassword(), resAccount.getPassword())) {
				session.setAttribute("accountInfo", resAccount);

				if (resAccount.getRoleId() == 1) {
					return "redirect:adminDashboard";
				} else {
					return "welcome";
				}

			} else {
				m.addAttribute("error", "Incorrect password!");
				return "adminLogin";
			}
		}
	}
}
