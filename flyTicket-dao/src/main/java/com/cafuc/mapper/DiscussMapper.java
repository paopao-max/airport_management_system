package com.cafuc.mapper;

import com.cafuc.pojo.Discuss;

import java.util.List;

/**
 * 留言评论数据访问接口
 */
public interface DiscussMapper {
    
    /**
     * 添加评论
     */
    void addDiscuss(Discuss discuss);
    
    /**
     * 删除评论
     */
    void deleteDiscuss(String discussId);
    
    /**
     * 根据ID查询评论
     */
    Discuss getDiscussById(String discussId);
    
    /**
     * 查询所有评论
     */
    List<Discuss> getAllDiscusses();
    
    /**
     * 分页查询评论
     */
    List<Discuss> getDiscussesByPage(int start, int pageSize);
    
    /**
     * 获取评论总数
     */
    int getDiscussCount();
}
