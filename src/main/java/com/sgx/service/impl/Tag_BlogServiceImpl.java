package com.sgx.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sgx.mapper.Tag_BlogDao;
import com.sgx.pojo.Tag;
import com.sgx.pojo.Tag_Blog;
import com.sgx.service.Tag_BlogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class Tag_BlogServiceImpl extends ServiceImpl<Tag_BlogDao, Tag_Blog> implements Tag_BlogService {
    @Autowired
    private Tag_BlogDao tag_blogDao;
    @Override
    public void savetbs(List<Long> tagsId, long id) {
        Tag_Blog tb=new Tag_Blog();
        tb.setBlogId(id);
        for(Long i:tagsId){
            tb.setTagId(i);
            tag_blogDao.insert(tb);
        }
    }

    @Override
    public void updatetb(List<Long> tagsId, Long blogId) {
        QueryWrapper<Tag_Blog> wrapper = new QueryWrapper<>();
        wrapper.eq("blog_id",blogId);
        tag_blogDao.delete(wrapper);
        tag_blogDao.deleteById(blogId);
        Tag_Blog tb=new Tag_Blog();
        tb.setBlogId(blogId);
        for(Long i:tagsId){
            tb.setTagId(i);
            tag_blogDao.insert(tb);
        }
    }

    @Override
    public String findById(Long id) {
        QueryWrapper<Tag_Blog> wrapper = new QueryWrapper<>();
        wrapper.eq("blog_id",id);
        List<Tag_Blog> tbs = tag_blogDao.selectList(wrapper);
        if(tbs.size()==0){
            return "";
        }
        String strTagsId="";
        for(Tag_Blog tb:tbs){
           strTagsId+=String.valueOf(tb.getTagId());
           strTagsId+=",";
        }
        System.out.println(strTagsId.substring(0,strTagsId.length()-1));
        return strTagsId.substring(0,strTagsId.length()-1);
    }
}
