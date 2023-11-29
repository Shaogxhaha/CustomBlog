package com.sgx.pojo;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName(value = "t_tag_blog")
public class Tag_Blog {
    private Long blogId;
    private Long tagId;
}
