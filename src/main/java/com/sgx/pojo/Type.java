package com.sgx.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Data
//@Entity
@TableName(value="t_type")
public class Type {
    @Id
    @TableId(type= IdType.AUTO)
    private Long id;
    private String name;
    private boolean recommend;

    @TableField(exist = false)
    private List<Blog> blogs=new ArrayList<>();

    public List<Blog> getBlogs() {
        return blogs;
    }

    public void setBlogs(List<Blog> blogs) {
        this.blogs = blogs;
    }
}
