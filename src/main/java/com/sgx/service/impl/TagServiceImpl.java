package com.sgx.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sgx.mapper.TagDao;
import com.sgx.mapper.Tag_BlogDao;
import com.sgx.pojo.Blog;
import com.sgx.pojo.Tag;
import com.sgx.pojo.Tag_Blog;
import com.sgx.service.TagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TagServiceImpl extends ServiceImpl<TagDao, Tag> implements TagService {
    @Autowired
    private TagDao tagDao;
    @Autowired
    private Tag_BlogDao tag_blogDao;

    @Override
    public List<Tag> listRecommend() {
        QueryWrapper<Tag> wrapper = new QueryWrapper<>();
        wrapper.eq("recommend",true);
        List<Tag> tags = tagDao.selectList(wrapper);
        for(Tag t:tags){
            QueryWrapper<Tag_Blog> tbWrapper = new QueryWrapper<>();
            tbWrapper.eq("tag_id",t.getId());
            List<Tag_Blog> tbs = tag_blogDao.selectList(tbWrapper);
            t.setBlogCount(tbs.size());

        }
        return tags;
    }

    @Override
    public Tag findById(Long id) {
        return tagDao.selectById(id);
    }

    @Override
    public int saveTag(Tag tag) {
        int insert = tagDao.insert(tag);
        return insert;
    }

    @Override
    public int updateTag(Tag tag) {
        int update = tagDao.updateById(tag);
        return update;
    }

    @Override
    public int deleteTag(Long id) {
        int delete  = tagDao.deleteById(id);
        return delete;
    }

    @Override
    public IPage<Tag> listTag(int current, int size) {
        IPage<Tag> page = new Page(current, size);
        page = tagDao.selectPage(page, null);
        return page;
    }

    @Override
    public Tag findByName(String name) {
        QueryWrapper<Tag> wrapper = new QueryWrapper<>();
        wrapper.eq("name",name);
        Tag tag = tagDao.selectOne(wrapper);
        return tag;
    }

    @Override
    public List<Tag> listTAgs() {
        List<Tag> tags = tagDao.selectList(null);
        for(Tag t:tags){
            List<Tag_Blog> ts = tag_blogDao.selectList(new QueryWrapper<Tag_Blog>().eq("tag_id", t.getId()));
            t.setBlogCount(ts.size());
        }
        return tags;
    }
}
