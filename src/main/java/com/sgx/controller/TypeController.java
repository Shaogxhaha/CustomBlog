package com.sgx.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;


import com.sgx.pojo.Type;
import com.sgx.service.TypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.thymeleaf.templateresolver.TemplateResolution;

@Controller
@RequestMapping("/admin")
public class TypeController {
    @Autowired
    private TypeService typeService;
    /*列表页面*/
    @GetMapping("/types")
    public ModelAndView types(@RequestParam(value = "current",required = false,defaultValue = "1") int current){
        IPage<Type> page = typeService.listType(current, 5);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("page",page);
        modelAndView.setViewName("admin/types");
        return modelAndView;
    }
    /*添加页面*/
    @GetMapping("/types-input")
    public String input(){

        return "admin/types-input";
    }
    /*添加*/
    @PostMapping ("/types-save")
    public String save(Type type, RedirectAttributes attributes){
        if(typeService.findByName(type.getName())!=null){
            attributes.addFlashAttribute("message","该分类已存在!");
            return "redirect:/admin/types";
        }
        boolean b = typeService.save(type);
        if(b){
            attributes.addFlashAttribute("message","添加成功!");
        }else{
            attributes.addFlashAttribute("message","添加失败!");
        }
        return "redirect:/admin/types";
    }

    /*更新页面*/
    @GetMapping("/types-update/{id}")
    public String editInput(@PathVariable Long id, Model model ){
        Type type = typeService.getType(id);
        model.addAttribute("type",type);
        return "admin/types-input";
    }
    /*更新*/
    @PostMapping ("/types-update/save/{id}")
    public String save(@PathVariable Long id,Type type, RedirectAttributes attributes){
        Type find = typeService.findByName(type.getName());
        if(find!=null&&find.getId()!=id){
            attributes.addFlashAttribute("message","该分类已存在!");
            return "redirect:/admin/types";
        }
        int t = typeService.updateType(id, type);
        if(t==1){
            attributes.addFlashAttribute("message","更新成功!");
        }else{
            attributes.addFlashAttribute("message","更新失败!");
        }
        return "redirect:/admin/types";
    }

    @GetMapping("/types-delete/{id}")
    public String delete(@PathVariable Long id,RedirectAttributes attributes){
        typeService.deleteType(id);
        attributes.addFlashAttribute("message","删除成功!");
        return "redirect:/admin/types";
    }
}
