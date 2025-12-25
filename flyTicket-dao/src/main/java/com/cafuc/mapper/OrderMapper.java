package com.cafuc.mapper;

import com.cafuc.pojo.Order;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 订单数据访问接口
 */
public interface OrderMapper {
    
    /**
     * 添加订单
     */
    void addOrder(Order order);
    
    /**
     * 删除订单
     */
    void deleteOrder(String orderId);
    
    /**
     * 更新订单
     */
    void updateOrder(Order order);
    
    /**
     * 根据ID查询订单
     */
    Order getOrderById(String orderId);
    
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
    List<Order> getOrdersByPage(@Param("start") int start, @Param("pageSize") int pageSize);
    
    /**
     * 获取订单总数
     */
    int getOrderCount();
    
    /**
     * 更新订单状态
     */
    void updateOrderStatus(@Param("orderId") String orderId, @Param("orderStatus") int orderStatus);
}
