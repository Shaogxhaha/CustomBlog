package com.sgx.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import org.springframework.data.annotation.Id;

import javax.persistence.GeneratedValue;
import java.util.ArrayList;
import java.util.List;

@Data
@TableName(value = "t_tag")
public class Tag {
    @Id
    @TableId(type= IdType.AUTO)
    private Long id;
    //标签名称
    private String name;
    //标签推荐
    private boolean recommend;

    //对应的博客集合
    @TableField(exist = false)
    List<Blog> blogs=new ArrayList<>();
    @TableField(exist = false)
    private int blogCount;
    public int getBlogCount() {
        return blogCount;
    }

    public void setBlogCount(int blogCount) {
        this.blogCount = blogCount;
    }


    public List<Blog> getBlogs() {
        return blogs;
    }

    public void setBlogs(List<Blog> blogs) {
        this.blogs = blogs;
    }
}
