package com.sgx.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sgx.mapper.BlogDao;
import com.sgx.mapper.TypeDao;
import com.sgx.pojo.Blog;
import com.sgx.pojo.Type;
import com.sgx.service.TypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TypeServiceImpl extends ServiceImpl<TypeDao,Type> implements TypeService  {
    @Autowired
    private TypeDao typeDao;
    @Autowired
    private BlogDao blogDao;
    @Override
    public IPage<Type> listType(int current, int size) {
        IPage<Type> page = new Page<>(current, 5);
        page = typeDao.selectPage(page, null);
        return page;

    }

    @Override
    public int saveType(Type type) {
        return typeDao.insert(type);
    }

    @Override
    public Type getType(Long id) {
        return typeDao.selectById(id);
    }

    @Override
    public int updateType(Long id, Type type) {
        int update = typeDao.updateById(type);
        return update;
    }

    @Override
    public void deleteType(Long id) {
        typeDao.deleteById(id);
    }

    @Override
    public Type findByName(String name) {
        QueryWrapper<Type> wrapper=new QueryWrapper<>();
        wrapper.eq("name", name);
        return typeDao.selectOne(wrapper);
    }

    @Override
    public List<Type> listRecommend() {
        QueryWrapper<Type> wrapper = new QueryWrapper<>();
        wrapper.eq("recommend",true);
        List<Type> types = typeDao.selectList(wrapper);
        for(Type t:types){
            QueryWrapper<Blog> blogWrapper = new QueryWrapper<>();
            blogWrapper.eq("type_id",t.getId());
            t.setBlogs(blogDao.selectList(blogWrapper));
        }

        return types;
    }

    @Override
    public List<Type> getTypes() {
        List<Type> types = typeDao.selectList(null);
        for(Type t:types){
            QueryWrapper<Blog> blogQueryWrapper=new QueryWrapper<>();
            blogQueryWrapper.eq("type_id",t.getId());
            t.setBlogs(blogDao.selectList(blogQueryWrapper));
        }
        return types;
    }
    @Override
    public IPage<Type> indexList(Long id,int current, int size) {
        IPage<Type> page = new Page<>(current, 5);
        page = typeDao.selectPage(page,new QueryWrapper<Type>().eq("id",id));
        return page;
    }
}
