package com.cafuc.service;

import com.cafuc.pojo.Admin;

/**
 * 管理员服务接口
 */
public interface AdminService {
    
    /**
     * 根据用户名和密码查询管理员
     */
    Admin findAdminByNameAndPwd(String adminName, String adminPwd);
    
    /**
     * 根据ID查询管理员
     */
    Admin findAdminById(String adminId);
}
