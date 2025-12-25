package com.cafuc.pojo;

import java.io.Serializable;

/**
 * 广告信息实体类
 */
public class Content implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private String contentId;    // 广告ID
    private String describe;     // 广告描述
    private String picture;      // 广告图片
    private String url;          // 广告链接
    
    public Content() {
    }
    
    public String getContentId() {
        return contentId;
    }
    
    public void setContentId(String contentId) {
        this.contentId = contentId;
    }
    
    public String getDescribe() {
        return describe;
    }
    
    public void setDescribe(String describe) {
        this.describe = describe;
    }
    
    public String getPicture() {
        return picture;
    }
    
    public void setPicture(String picture) {
        this.picture = picture;
    }
    
    public String getUrl() {
        return url;
    }
    
    public void setUrl(String url) {
        this.url = url;
    }
    
    @Override
    public String toString() {
        return "Content{" +
                "contentId='" + contentId + '\'' +
                ", describe='" + describe + '\'' +
                ", picture='" + picture + '\'' +
                ", url='" + url + '\'' +
                '}';
    }
}
