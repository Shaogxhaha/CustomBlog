package com.sgx.service;

import com.sgx.pojo.User;

public interface UserService  {

    /*
    * 查找用户是否存在
    * */
    User findByUsernamePassword(String username,String password);

}
