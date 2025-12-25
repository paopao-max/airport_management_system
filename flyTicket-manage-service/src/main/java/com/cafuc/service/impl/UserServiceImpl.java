package com.cafuc.service.impl;

import com.cafuc.mapper.UserMapper;
import com.cafuc.pojo.User;
import com.cafuc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * 用户服务实现类
 */
@Service
@Transactional
public class UserServiceImpl implements UserService {
    
    @Autowired
    private UserMapper userMapper;
    
    @Override
    public User findUserByNameAndPwd(String userName, String userPwd) {
        return userMapper.findUserByNameAndPwd(userName, userPwd);
    }
    
    @Override
    public User findUserByName(String userName) {
        return userMapper.findUserByName(userName);
    }
    
    @Override
    public User findUserById(String userId) {
        return userMapper.findUserById(userId);
    }
    
    @Override
    public void addUser(User user) throws Exception {
        // 检查用户名是否已存在
        User existUser = userMapper.findUserByName(user.getUserName());
        if (existUser != null) {
            throw new Exception("用户名已存在");
        }
        
        // 生成用户ID
        String userId = "U" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + 
                       UUID.randomUUID().toString().substring(0, 4);
        user.setUserId(userId);
        
        // 设置创建时间
        if (user.getCreateTime() == null) {
            user.setCreateTime(new Date());
        }
        
        // 插入数据库
        userMapper.addUser(user);
    }
    
    @Override
    public void updateUser(User user) throws Exception {
        userMapper.updateUser(user);
    }
    
    @Override
    public void deleteUser(String userId) throws Exception {
        userMapper.deleteUser(userId);
    }
    
    @Override
    public List<User> getAllUsers() {
        return userMapper.getAllUsers();
    }
    
    @Override
    public List<User> getUsersByPage(int pageNum, int pageSize) {
        int start = (pageNum - 1) * pageSize;
        return userMapper.getUsersByPage(start, pageSize);
    }
    
    @Override
    public int getUserCount() {
        return userMapper.getUserCount();
    }
}
