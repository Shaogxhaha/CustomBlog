package com.sgx.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.sgx.pojo.Blog;

import java.util.List;

public interface BlogService extends IService<Blog> {
    /*通过id查找博客*/
    Blog getBlog(Long id);
    /*条件查找博客然后分页*/
    IPage<Blog> listBlog(int current,int size,Blog blog);
    /*更新博客*/
    int  updateBlog(Long id,Blog blog);
    /*删除博客*/
    void deleteBlog(Long id);
    Blog findByTitle(String title);

    IPage<Blog> listAll(int current, int size);

    Blog findById(Long id);
    /*查询推荐*/
    List<Blog> listRecommend();
    /*查找博客*/
    List<Blog> searchBlogs(String query);

    IPage<Blog> indexList(Long id, int current, int size);

    IPage<Blog> tbList(Long id, int current, int i);
}
