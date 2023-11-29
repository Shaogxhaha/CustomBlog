package com.sgx.controller;

import com.sgx.pojo.Blog;
import com.sgx.pojo.User;
import com.sgx.service.BlogService;
import com.sgx.service.TagService;
import com.sgx.service.Tag_BlogService;
import com.sgx.service.TypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.jws.WebParam;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class BlogController {
    @Autowired
    private BlogService blogService;
    @Autowired
    private TypeService typeService;
    @Autowired
    private TagService tagService;
    @Autowired
    private Tag_BlogService tag_blogService;
    /*展示列表*/
    @GetMapping("/blogs")
    public String blogs(@RequestParam(value = "current",required = false,defaultValue = "1") int current, Blog blog, Model model){
        model.addAttribute("types",typeService.list());
        model.addAttribute("page",blogService.listAll(current,5));
        return "admin/blogs";
    }
    /*查找后的列表*/
    @PostMapping("/blogs/search")
    public String search(@RequestParam(value = "current",required = false,defaultValue = "-1") int current, Blog blog, Model model){
        model.addAttribute("page",blogService.listBlog(current,-1,blog));
        return "admin/blogs :: blogList";
    }
    /*新增页面*/
    @GetMapping("/blogs/input")
    public String input(Model model){
        model.addAttribute("types",typeService.list());
        model.addAttribute("tags",tagService.list());
        return "admin/blogs-input";
    }

    @PostMapping("/blogs")
    public String post(Blog blog, RedirectAttributes attributes,HttpSession session) throws ParseException {
        Blog b = blogService.findByTitle(blog.getTitle());
        if(b!=null){
            attributes.addFlashAttribute("message","同标题文章已经发布!");
            return "redirect:/admin/blogs";
        }
        User user = (User)session.getAttribute("user");
        blog.setUser(user);
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String time = format.format(new Date());
        blog.setCreateTime(time);
        blog.setUpdateTime(time);
        blog.setViews(0);
        boolean save = blogService.save(blog);
        Blog saveBlog = blogService.findByTitle(blog.getTitle());
        //将tagsId写入到中间表中
        tag_blogService.savetbs(blog.getTagsId(),saveBlog.getId());
        if(save){
            attributes.addFlashAttribute("message","添加成功!");
        }else{
            attributes.addFlashAttribute("message","添加失败!");
        }
        return "redirect:/admin/blogs";
    }

    @GetMapping("/blogs/edit/{id}")
    public String edit(@PathVariable Long id, Model model){
        Blog blog = blogService.findById(id);
        String strTagsId = tag_blogService.findById(id);
        blog.setStrTagsId(strTagsId);
        System.out.println(blog.getStrTagsId());
        model.addAttribute("blog",blog);
        model.addAttribute("types",typeService.list());
        model.addAttribute("tags",tagService.list());
        return "/admin/blogs-input";
    }
    @PostMapping("/blogs/update")
    public String update(Blog blog,RedirectAttributes attributes){
        Blog updateBlog = blogService.findByTitle(blog.getTitle());
        if(updateBlog!=null&&updateBlog.getId()!=blog.getId()){
            attributes.addFlashAttribute("message","同标题文章已经发布!");
            return "redirect:/admin/blogs";
        }
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String time = format.format(new Date());
        blog.setUpdateTime(time);
        tag_blogService.updatetb(blog.getTagsId(),blog.getId());
        boolean update = blogService.updateById(blog);
        if(update){
            attributes.addFlashAttribute("message","更新成功!");
        }else{
            attributes.addFlashAttribute("message","更新失败!");
        }

        return "redirect:/admin/blogs";
    }
    @GetMapping("/blogs/delete/{id}")
    public String delete(@PathVariable Long id,RedirectAttributes attributes){
        blogService.deleteBlog(id);
        attributes.addFlashAttribute("message","删除成功!");
        return "redirect:/admin/blogs";
    }

}
