package com.sgx.controller;

import com.sgx.pojo.User;
import com.sgx.service.impl.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class loginController {

    @Autowired
    private UserServiceImpl userService;

    /*
    * 登录页面
    * */
    @GetMapping
    public String loginPage(){
        return "admin/login";
    }

    /*
    * 登录验证
    * */
    @PostMapping("/login")
    private String login(@RequestParam String username, @RequestParam String password, HttpSession session, RedirectAttributes attributes){
        User user = userService.findByUsernamePassword(username, password);
        if(user!=null){
            user.setPassword(null);
            session.setAttribute("user",user);
            return "admin/index";
        }else{
            attributes.addFlashAttribute("message","用户名或密码错误");
            return "redirect:/admin";
        }

    }

    /*
    * 注销
    * */
    @GetMapping("/logout")
    public String logout(HttpSession session){
        session.removeAttribute("user");
        return "redirect:/admin";

    }
}
