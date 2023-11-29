package com.sgx.pojo;

import com.alibaba.fastjson.annotation.JSONField;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;


import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Data
//@Entity
@TableName(value="t_blog")
public class Blog {
    @Id
    @TableId(type= IdType.AUTO)
    private long id;
    //标题
    private String title;
    //描述
    private String description;
    //正文
    private String content;
    //首图
    private String firstPicture;
    //文章标志
    private String flag;
    //浏览次数
    private Integer views;
    //是否发布
    private boolean published;
    //是否推荐
    private boolean recommend;
    //创建时间
    private String createTime;
    //更新时间
    private String updateTime;
    private Long typeId;
    private Long userId;
    @TableField(exist = false)
    private Type type;
    @TableField(exist = false)
    private User user;
    @TableField(exist = false)
    List<Tag> tags=new ArrayList<>();
    @TableField(exist = false)
    List<Long> tagsId=new ArrayList<>();
    @TableField(exist = false)
    private String strTagsId;
    public String getStrTagsId() {
        return strTagsId;
    }
    public void setStrTagsId(String strTagsId) {
        this.strTagsId = strTagsId;
    }
    public List<Long> getTagsId() {
        return tagsId;
    }

    public void setTagsId(List<Long> tagsId) {
        this.tagsId = tagsId;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<Tag> getTags() {
        return tags;
    }

    public void setTags(List<Tag> tags) {
        this.tags = tags;
    }
}
