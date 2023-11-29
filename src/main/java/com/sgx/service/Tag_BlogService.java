package com.sgx.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.sgx.pojo.Tag;
import com.sgx.pojo.Tag_Blog;

import java.util.List;

public interface Tag_BlogService extends IService<Tag_Blog> {

    void savetbs(List<Long> tagsId, long id);

    void updatetb(List<Long> tagsId, Long typeId);

    String findById(Long blogId);
}
