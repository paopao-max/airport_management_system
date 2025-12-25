package com.cafuc.service;

import com.cafuc.pojo.Order;

import java.util.List;

/**
 * 订单服务接口
 */
public interface OrderService {
    
    /**
     * 根据ID查询订单
     */
    Order getOrderById(String orderId);
    
    /**
     * 保存订单
     */
    void saveOrder(Order order) throws Exception;
    
    /**
     * 添加订单
     */
    void addOrder(Order order) throws Exception;
    
    /**
     * 删除订单
     */
    void deleteOrder(String orderId) throws Exception;
    
    /**
     * 更新订单
     */
    void updateOrder(Order order) throws Exception;
    
    /**
     * 根据订单号查询订单
     */
    Order getOrderByNumber(String orderNumber);
    
    /**
     * 根据用户ID查询订单
     */
    List<Order> getOrdersByUserId(String userId);
    
    /**
     * 根据用户名查询订单
     */
    List<Order> getOrdersByUserName(String userName);
    
    /**
     * 查询所有订单
     */
    List<Order> getAllOrders();
    
    /**
     * 分页查询订单
     */
    List<Order> getOrdersByPage(int pageNum, int pageSize);
    
    /**
     * 获取订单总数
     */
    int getOrderCount();
    
    /**
     * 更新订单状态
     */
    void updateOrderStatus(String orderId, String status);
}
