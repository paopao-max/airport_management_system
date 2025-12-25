package com.cafuc.pojo;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * 留言评论实体类
 */
public class Discuss implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private String discussId;       // 评论ID
    private String userId;          // 用户ID
    private String userName;        // 用户名
    private String discussContent;  // 评论内容
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date discussDate;       // 评论日期
    
    public Discuss() {
    }
    
    public String getDiscussId() {
        return discussId;
    }
    
    public void setDiscussId(String discussId) {
        this.discussId = discussId;
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
    
    public String getDiscussContent() {
        return discussContent;
    }
    
    public void setDiscussContent(String discussContent) {
        this.discussContent = discussContent;
    }
    
    public Date getDiscussDate() {
        return discussDate;
    }
    
    public void setDiscussDate(Date discussDate) {
        this.discussDate = discussDate;
    }
    
    @Override
    public String toString() {
        return "Discuss{" +
                "discussId='" + discussId + '\'' +
                ", userId='" + userId + '\'' +
                ", userName='" + userName + '\'' +
                ", discussContent='" + discussContent + '\'' +
                ", discussDate=" + discussDate +
                '}';
    }
}
