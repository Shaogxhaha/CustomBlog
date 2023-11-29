package com.sgx.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.sgx.pojo.Tag;

import java.util.List;

public interface TagService extends IService<Tag>{
    /*查询推荐*/
    List<Tag> listRecommend();
    /*查找标签*/
    Tag findById(Long id);
    /*添加标签*/
    int saveTag(Tag tag);
    /*更新标签*/
    int updateTag(Tag tag);
    /*删除标签*/
    int deleteTag(Long id);
    /*分页展示数据*/
    IPage<Tag> listTag(int current,int size);

    Tag findByName(String name);

    List<Tag> listTAgs();
}
