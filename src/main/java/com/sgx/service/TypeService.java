package com.sgx.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.sgx.pojo.Type;

import java.util.List;

public interface TypeService extends IService<Type> {
    /*添加分类*/
    int saveType(Type type);
    /*id查找分类*/
    Type getType(Long id);
    /*分类分页*/
    IPage<Type> listType(int current, int size);

    /*分类更新*/
    int updateType(Long id,Type type);
    /*删除分类*/
    void deleteType(Long id);
    /*name查询分类*/
    Type findByName(String name);
    /*添加推荐*/
    List<Type> listRecommend();

    List<Type> getTypes();

    IPage<Type> indexList(Long id,int current,int size);
}
