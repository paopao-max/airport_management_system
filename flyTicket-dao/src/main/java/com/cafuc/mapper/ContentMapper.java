package com.cafuc.mapper;

import com.cafuc.pojo.Content;

import java.util.List;

/**
 * 广告信息数据访问接口
 */
public interface ContentMapper {
    
    /**
     * 添加广告
     */
    void addContent(Content content);
    
    /**
     * 删除广告
     */
    void deleteContent(String contentId);
    
    /**
     * 更新广告
     */
    void updateContent(Content content);
    
    /**
     * 根据ID查询广告
     */
    Content getContentById(String contentId);
    
    /**
     * 查询所有广告
     */
    List<Content> getAllContents();
}
