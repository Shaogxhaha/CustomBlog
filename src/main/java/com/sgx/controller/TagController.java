package com.sgx.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.sgx.pojo.Tag;
import com.sgx.pojo.Type;
import com.sgx.service.TagService;
import com.sgx.service.TypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class TagController {
    @Autowired
    private TagService tagService;
    /*列表页面*/
    @GetMapping("/tags")
    public ModelAndView types(@RequestParam(value = "current",required = false,defaultValue = "1") int current){
        IPage<Tag> page = tagService.listTag(current,5);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("page",page);
        modelAndView.setViewName("admin/tags");
        return modelAndView;
    }

    /*添加页面*/
    @GetMapping("/tags/input")
    public String input(){
        return "admin/tags-input";
    }
    /*添加*/
    @PostMapping("/tags/save")
    public String save(Tag tag, RedirectAttributes attributes){
        if(tagService.findByName(tag.getName())!=null){
            attributes.addFlashAttribute("message","该分类已存在!");
            return "redirect:/admin/tags";
        }
        int i = tagService.saveTag(tag);
        if(i==1){
            attributes.addFlashAttribute("message","添加成功!");
        }else{
            attributes.addFlashAttribute("message","添加失败!");
        }
        return "redirect:/admin/tags";
    }
    /*更新页面*/
    @GetMapping("/tags/update/{id}")
    public String editInput(@PathVariable Long id, Model model ){
        Tag tag = tagService.getById(id);
        model.addAttribute("tag",tag);
        return "admin/tags-input";
    }
    /*更新*/
    @PostMapping ("/tags/update/{id}")
    public String update(@PathVariable Long id,Tag tag, RedirectAttributes attributes){
        Tag t = tagService.findByName(tag.getName());
        if(t!=null&&t.getId()!=id){
            attributes.addFlashAttribute("message","该分类已存在!");
            return "redirect:/admin/tags";
        }
        int i = tagService.updateTag(tag);
        if(i==1){
            attributes.addFlashAttribute("message","更新成功!");
        }else{
            attributes.addFlashAttribute("message","更新失败!");
        }
        return "redirect:/admin/tags";
    }
    /*删除标签*/
    @GetMapping("/tags/delete/{id}")
    public String delete(@PathVariable Long id,RedirectAttributes attributes){
        tagService.deleteTag(id);
        attributes.addFlashAttribute("message","删除成功!");
        return "redirect:/admin/tags";
    }
}
