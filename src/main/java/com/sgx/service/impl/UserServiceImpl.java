package com.sgx.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.sgx.mapper.UserDao;
import com.sgx.pojo.User;
import com.sgx.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import static com.sgx.utils.MD5Utils.code;
@Service
public class UserServiceImpl implements UserService{
    @Autowired
    private UserDao userDao;
    /*验证用户*/
    @Override
    public User findByUsernamePassword(String username, String password) {
        QueryWrapper<User> wrapper=new QueryWrapper<>();
        wrapper.eq("username",username).eq("password",code(password));
        User user = userDao.selectOne(wrapper);
        return user;
    }
}
