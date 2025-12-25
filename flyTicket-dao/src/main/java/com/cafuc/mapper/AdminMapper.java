package com.cafuc.mapper;

import com.cafuc.pojo.Admin;
import org.apache.ibatis.annotations.Param;

/**
 * 管理员数据访问接口
 */
public interface AdminMapper {
    
    /**
     * 根据用户名和密码查询管理员
     */
    Admin findAdminByNameAndPwd(@Param("adminName") String adminName, @Param("adminPwd") String adminPwd);
    
    /**
     * 根据ID查询管理员
     */
    Admin findAdminById(String adminId);
    
    /**
     * 添加管理员
     */
    void addAdmin(Admin admin);
    
    /**
     * 更新管理员信息
     */
    void updateAdmin(Admin admin);
    
    /**
     * 删除管理员
     */
    void deleteAdmin(String adminId);
}
