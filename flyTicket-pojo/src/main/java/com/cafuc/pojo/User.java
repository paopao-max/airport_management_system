package com.cafuc.pojo;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * 用户实体类
 */
public class User implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private String userId;       // 用户ID
    private String userName;     // 用户名
    private String userPwd;      // 用户密码
    private String userEmail;    // 用户邮箱
    private String userPhone;    // 用户电话
    private String userSex;      // 用户性别
    private Integer userAge;     // 用户年龄
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;     // 创建时间
    
    public User() {
    }
    
    public User(String userName, String userPwd) {
        this.userName = userName;
        this.userPwd = userPwd;
    }
    
    public String getUserId() {
        return userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    public String getUserName() {
        return userName;
    }
    
    public void setUserName(String userName) {
        this.userName = userName;
    }
    
    public String getUserPwd() {
        return userPwd;
    }
    
    public void setUserPwd(String userPwd) {
        this.userPwd = userPwd;
    }
    
    public String getUserEmail() {
        return userEmail;
    }
    
    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }
    
    public String getUserPhone() {
        return userPhone;
    }
    
    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }
    
    public String getUserSex() {
        return userSex;
    }
    
    public void setUserSex(String userSex) {
        this.userSex = userSex;
    }
    
    public Integer getUserAge() {
        return userAge;
    }
    
    public void setUserAge(Integer userAge) {
        this.userAge = userAge;
    }
    
    public Date getCreateTime() {
        return createTime;
    }
    
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
    
    @Override
    public String toString() {
        return "User{" +
                "userId='" + userId + '\'' +
                ", userName='" + userName + '\'' +
                ", userPwd='" + userPwd + '\'' +
                ", userEmail='" + userEmail + '\'' +
                ", userPhone='" + userPhone + '\'' +
                ", userSex='" + userSex + '\'' +
                ", userAge=" + userAge +
                ", createTime=" + createTime +
                '}';
    }
}
