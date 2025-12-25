package com.cafuc.service;

import com.cafuc.pojo.User;

import java.util.List;

/**
 * 用户服务接口
 */
public interface UserService {
    
    /**
     * 根据用户名和密码查询用户
     */
    User findUserByNameAndPwd(String userName, String userPwd);
    
    /**
     * 根据用户名查询用户
     */
    User findUserByName(String userName);
    
    /**
     * 根据ID查询用户
     */
    User findUserById(String userId);
    
    /**
     * 添加用户
     */
    void addUser(User user) throws Exception;
    
    /**
     * 更新用户信息
     */
    void updateUser(User user) throws Exception;
    
    /**
     * 删除用户
     */
    void deleteUser(String userId) throws Exception;
    
    /**
     * 查询所有用户
     */
    List<User> getAllUsers();
    
    /**
     * 分页查询用户
     */
    List<User> getUsersByPage(int pageNum, int pageSize);
    
    /**
     * 获取用户总数
     */
    int getUserCount();
}
