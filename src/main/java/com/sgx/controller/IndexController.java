package com.sgx.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.sgx.pojo.Blog;
import com.sgx.pojo.Tag;
import com.sgx.pojo.Type;
import com.sgx.service.BlogService;
import com.sgx.service.TagService;
import com.sgx.service.TypeService;
import com.sgx.service.impl.BlogServiceImpl;
import org.hibernate.annotations.GeneratorType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller

public class IndexController {
    @Autowired
    private BlogService blogService;
    @Autowired
    private TypeService typeService;
    @Autowired
    private TagService tagService;

    @GetMapping()
    public String IndexNull(Model model){
        List<Blog> blogs = blogService.listRecommend();
        List<Type> types =typeService.listRecommend();
        List<Tag> tags=tagService.listRecommend();
        model.addAttribute("blogs",blogs);
        model.addAttribute("types",types);
        model.addAttribute("tags",tags);
        return "/index";
    }
    @GetMapping("/admin/index")
    public String adminIndex(){
        return "/admin/index";
    }
    @GetMapping("/index")
    public String index(Model model){
        List<Blog> blogs = blogService.listRecommend();
        List<Type> types =typeService.listRecommend();
        List<Tag> tags=tagService.listRecommend();
        model.addAttribute("blogs",blogs);
        model.addAttribute("types",types);
        model.addAttribute("tags",tags);
        return "/index";
    }
    @PostMapping("/search")
    public String search(@RequestParam String query,Model model){

        model.addAttribute("blogs",blogService.searchBlogs(query));
        model.addAttribute("query",query);
        return "/search";
    }

    @GetMapping("/blog/{id}")
    public String blog(@PathVariable Long id,Model model){
        Blog blog = blogService.getBlog(id);
        model.addAttribute("blog",blog);
        return "/blog";
    }

    @GetMapping("/types/{id}/{current}")
    public String type(@PathVariable Long id,@PathVariable int current,Model model){
        if(id==-1){
            List<Type> list = typeService.list();
            id=list.get(0).getId();
        }
        //拿到types
        List<Type> types = typeService.getTypes();
        IPage<Blog> page = blogService.indexList(id, current, 2);
        model.addAttribute("types",types);
        model.addAttribute("page",page);
        model.addAttribute("activeTypeId",id);
        return "/types";
    }
    @GetMapping("/tags/{id}/{current}")
    public String tags( @PathVariable Long id,@PathVariable int current,Model model){
        if(id==-1){
            List<Tag> list = tagService.list();
            id=list.get(0).getId();
        }
        //拿去tags
        List<Tag> tags = tagService.listTAgs();
        //拿blogs
        IPage<Blog> page = blogService.tbList(id, current, 2);
        model.addAttribute("tags",tags);
        model.addAttribute("page",page);
        model.addAttribute("activeTypeId",id);
        return"/tags";
    }
    @GetMapping("/about")
    public String about(){
        return"/about";
    }



}
