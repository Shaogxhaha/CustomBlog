package com.sgx.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sgx.NotFoundException;
import com.sgx.mapper.*;
import com.sgx.pojo.*;
import com.sgx.service.BlogService;
import com.sgx.utils.MarkDownUtils;
import org.apache.logging.log4j.util.Strings;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class BlogServiceImpl extends ServiceImpl<BlogDao,Blog> implements BlogService {
    @Autowired
    private BlogDao blogDao;

    @Autowired
    private UserDao userDao;
    @Autowired
    private TypeDao typeDao;
    @Autowired
    private TagDao tagDao;
    @Autowired
    private Tag_BlogDao tag_blogDao;

    @Override
    public Blog getBlog(Long id) {
        Blog blog = blogDao.selectById(id);
        if(blog==null){
            throw new NotFoundException("该博客不存在");
        }
        Integer views = blog.getViews();
        if(views==null){
           views=1;
        }else{
            views+=1;
        }
        blog.setViews(views);
        blogDao.updateById(blog);
        blog.setUser(userDao.selectById(blog.getUserId()));
        blog.setType(typeDao.selectById(blog.getTypeId()));
        List<Tag_Blog> tbs = tag_blogDao.selectList(new QueryWrapper<Tag_Blog>().eq("blog_id", blog.getId()));
        List<Tag> ts = new ArrayList<>();
        for(Tag_Blog tb:tbs){
            Tag t = tagDao.selectOne(new QueryWrapper<Tag>().eq("id", tb.getTagId()));
            ts.add(t);
        }
        blog.setTags(ts);

        Blog b = copyBlog(blog);
        String content=b.getContent();
        b.setContent(MarkDownUtils.markdownToHtmlExtensions(content));
        return b;
    }

    Blog copyBlog(Blog blog){
        Blog b = new Blog();
        /*id*/
        b.setId(blog.getId());
        /*内容*/
        b.setContent(blog.getContent());
        /*标题*/
        b.setTitle(blog.getTitle());
        /*更新*/
        b.setUpdateTime(blog.getUpdateTime());
        /*创作时间*/
        b.setCreateTime(blog.getCreateTime());
        /*类型*/
        b.setType(blog.getType());
        /*用户*/
        b.setUser(blog.getUser());
        /*typeid*/
        b.setTypeId(blog.getTypeId());
        /*userid*/
        b.setUserId(blog.getUserId());
        /*文章声明*/
        b.setFlag(blog.getFlag());
        /*标签*/
        b.setTags(blog.getTags());
        /*浏览次数*/
        b.setViews(blog.getViews());
        /*简介*/
        b.setDescription(blog.getDescription());
        /*是否推荐*/
        b.setRecommend(blog.isRecommend());
        /*是否发布*/
        b.setPublished(blog.isPublished());
        /*首图*/
        b.setFirstPicture(blog.getFirstPicture());
        return b;
    }

    @Override
    public IPage<Blog> listBlog(int current, int size, Blog blog) {
        LambdaQueryWrapper<Blog> wrapper=new LambdaQueryWrapper<>();
        wrapper.like(Strings.isNotEmpty(blog.getTitle()),Blog::getTitle,blog.getTitle());
        wrapper.eq( blog.getTypeId()!=null,Blog::getTypeId,blog.getTypeId());
        wrapper.eq(Blog::isRecommend,blog.isRecommend());
        wrapper.orderByDesc(Blog::getCreateTime);
        IPage<Blog> page = new Page<>(current,size);
        page = blogDao.selectPage(page, wrapper);
        for(Blog b:page.getRecords()){
            User user = userDao.selectById(1);
            Type type=typeDao.selectById(1);
            b.setUser(user);
            b.setType(type);
        }

        return page;
    }

    @Transactional
    @Override
    public int updateBlog(Long id, Blog blog) {
        int i = blogDao.updateById(blog);
        return i;
    }
    @Transactional
    @Override
    public void deleteBlog(Long id) {
        blogDao.deleteById(id);
    }

    @Override
    public Blog findByTitle(String title) {
        QueryWrapper<Blog> wrapper=new QueryWrapper<>();
        wrapper.eq("title",title);
        Blog blog = blogDao.selectOne(wrapper);
        return blog;
    }

    @Override
    public IPage<Blog> listAll(int current, int size) {
        IPage<Blog> page = new Page<>(current,size);
        page = blogDao.selectPage(page, null);
        for(Blog b:page.getRecords()){
            User user = userDao.selectById(1);
            Type type=typeDao.selectById(1);
            b.setUser(user);
            b.setType(type);
        }

        return page;
    }

    @Override
    public Blog findById(Long id) {
        Blog blog = blogDao.selectById(id);
        if(blog.getTypeId()!=null){
            blog.setType(typeDao.selectById(blog.getTypeId()));
        }
        return blog;
    }

    @Override
    public List<Blog> listRecommend() {
        QueryWrapper<Blog> wrapper = new QueryWrapper<>();
        wrapper.eq("recommend", true);
        List<Blog> blogs = blogDao.selectList(wrapper);
        for(Blog b:blogs){
            b.setType(typeDao.selectById(b.getTypeId()));
            b.setUser(userDao.selectById(b.getUserId()));
        }
        return blogs;
    }

    @Override
    public List<Blog> searchBlogs(String query) {
        QueryWrapper<Blog> wrapper = new QueryWrapper<>();
        wrapper.like("title",query).or().like("content",query);
        List<Blog> blogs = blogDao.selectList(wrapper);
        for(Blog b:blogs){
            b.setUser(userDao.selectById(b.getUserId()));
            b.setType( typeDao.selectById(b.getTypeId()));


        }
        return blogs;
    }

    @Override
    public IPage<Blog> indexList(Long id, int current, int size) {
        QueryWrapper<Blog> w = new QueryWrapper<>();
        w.eq("type_id",id);
        Page<Blog> page = new Page<>(current,2);
        blogDao.selectPage(page,w);
        for(Blog b: page.getRecords()){
            b.setType(typeDao.selectById(b.getTypeId()));
            b.setUser(userDao.selectById(b.getUserId()));
        }
        return page;
    }

    @Override
    public IPage<Blog> tbList(Long id, int current, int size) {
        List<Tag_Blog> blogsId = tag_blogDao.selectList(new QueryWrapper<Tag_Blog>().eq("tag_id", id));

        IPage<Blog> page = new Page<>(current, size);
        QueryWrapper<Blog> wrapper = new QueryWrapper<>();
        for(Tag_Blog tb:blogsId){
            wrapper.or().eq("id",tb.getBlogId());
        }
        if(blogsId.size()==0){
            wrapper.eq("id",-1);
        }
        page = blogDao.selectPage(page, wrapper);
        for(Blog b:page.getRecords()){
            b.setUser(userDao.selectById(b.getUserId()));
            b.setType(typeDao.selectById(b.getTypeId()));
        }
        return page;
    }

}
