package com.cafuc.pojo;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * 管理员实体类
 */
public class Admin implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private String adminId;           // 管理员ID
    private String adminName;         // 管理员姓名
    private String adminPwd;          // 管理员密码
    private String adminEmail;        // 管理员邮箱
    private String adminPhone;        // 管理员电话
    
    public Admin() {
    }
    
    public Admin(String adminId, String adminName, String adminPwd) {
        this.adminId = adminId;
        this.adminName = adminName;
        this.adminPwd = adminPwd;
    }
    
    public String getAdminId() {
        return adminId;
    }
    
    public void setAdminId(String adminId) {
        this.adminId = adminId;
    }
    
    public String getAdminName() {
        return adminName;
    }
    
    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }
    
    public String getAdminPwd() {
        return adminPwd;
    }
    
    public void setAdminPwd(String adminPwd) {
        this.adminPwd = adminPwd;
    }
    
    public String getAdminEmail() {
        return adminEmail;
    }
    
    public void setAdminEmail(String adminEmail) {
        this.adminEmail = adminEmail;
    }
    
    public String getAdminPhone() {
        return adminPhone;
    }
    
    public void setAdminPhone(String adminPhone) {
        this.adminPhone = adminPhone;
    }
    
    @Override
    public String toString() {
        return "Admin{" +
                "adminId='" + adminId + '\'' +
                ", adminName='" + adminName + '\'' +
                ", adminPwd='" + adminPwd + '\'' +
                ", adminEmail='" + adminEmail + '\'' +
                ", adminPhone='" + adminPhone + '\'' +
                '}';
    }
}
