package com.sgx.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Data

@TableName(value = "t_user")

public class User {
    @Id
    @TableId(type= IdType.AUTO)
    private Long id;
    //昵称
    private String nickname;
    //用户名
    private String username;
    //密码
    private String password;
    //邮箱
    private String email;
    //头像
    private String avatar;
    //类型
    private Integer type;
    //创建时间
    @Temporal(TemporalType.DATE)
    private Date createTime;
    //修改时间
    @Temporal(TemporalType.DATE)
    private Date updateTime;

    public void setId(Long id) {
        this.id = id;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    @TableField(exist = false)
    private List<Blog> blogs = new ArrayList<>();

    public List<Blog> getBlogs() {
        return blogs;
    }

    public void setBlogs(List<Blog> blogs) {
        this.blogs = blogs;
    }
}
