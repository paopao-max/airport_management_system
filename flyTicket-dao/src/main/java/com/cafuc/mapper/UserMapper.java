package com.cafuc.mapper;

import com.cafuc.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 用户数据访问接口
 */
public interface UserMapper {
    
    /**
     * 根据用户名和密码查询用户
     */
    User findUserByNameAndPwd(@Param("userName") String userName, @Param("userPwd") String userPwd);
    
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
    void addUser(User user);
    
    /**
     * 更新用户信息
     */
    void updateUser(User user);
    
    /**
     * 删除用户
     */
    void deleteUser(String userId);
    
    /**
     * 查询所有用户
     */
    List<User> getAllUsers();
    
    /**
     * 分页查询用户
     */
    List<User> getUsersByPage(@Param("start") int start, @Param("pageSize") int pageSize);
    
    /**
     * 获取用户总数
     */
    int getUserCount();
}
