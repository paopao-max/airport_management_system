package com.cafuc.service.impl;

import com.cafuc.mapper.AdminMapper;
import com.cafuc.pojo.Admin;
import com.cafuc.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 管理员服务实现类
 */
@Service
public class AdminServiceImpl implements AdminService {
    
    @Autowired
    private AdminMapper adminMapper;
    
    @Override
    public Admin findAdminByNameAndPwd(String adminName, String adminPwd) {
        return adminMapper.findAdminByNameAndPwd(adminName, adminPwd);
    }
    
    @Override
    public Admin findAdminById(String adminId) {
        return adminMapper.findAdminById(adminId);
    }
}
