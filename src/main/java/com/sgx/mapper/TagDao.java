package com.sgx.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.sgx.pojo.Tag;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface TagDao extends BaseMapper<Tag> {
}
