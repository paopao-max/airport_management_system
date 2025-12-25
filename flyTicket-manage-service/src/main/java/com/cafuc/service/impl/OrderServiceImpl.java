package com.cafuc.service.impl;

import com.cafuc.mapper.OrderMapper;
import com.cafuc.pojo.Order;
import com.cafuc.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * 订单服务实现类
 */
@Service
@Transactional
public class OrderServiceImpl implements OrderService {
    
    @Autowired
    private OrderMapper orderMapper;
    
    @Override
    public void saveOrder(Order order) throws Exception {
        // 生成订单ID
        if (order.getOrderId() == null || order.getOrderId().isEmpty()) {
            String orderId = "O" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + 
                            UUID.randomUUID().toString().substring(0, 4);
            order.setOrderId(orderId);
        }
        
        // 生成订单号
        if (order.getOrderNumber() == null || order.getOrderNumber().isEmpty()) {
            String orderNumber = "ORD" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + 
                               UUID.randomUUID().toString().substring(0, 6);
            order.setOrderNumber(orderNumber);
        }
        
        // 设置订单日期
        if (order.getOrderDate() == null) {
            order.setOrderDate(new Date());
        }
        
        // 设置订单状态为待支付
        if (order.getOrderStatus() == null) {
            order.setOrderStatus(0);
        }
        
        // 插入数据库
        orderMapper.addOrder(order);
    }
    
    @Override
    public void addOrder(Order order) throws Exception {
        saveOrder(order);
    }
    
    @Override
    public void deleteOrder(String orderId) throws Exception {
        orderMapper.deleteOrder(orderId);
    }
    
    @Override
    public void updateOrder(Order order) throws Exception {
        orderMapper.updateOrder(order);
    }
    
    @Override
    public Order getOrderById(String orderId) {
        return orderMapper.getOrderById(orderId);
    }
    
    @Override
    public Order getOrderByNumber(String orderNumber) {
        return orderMapper.getOrderByNumber(orderNumber);
    }
    
    @Override
    public List<Order> getOrdersByUserId(String userId) {
        return orderMapper.getOrdersByUserId(userId);
    }
    
    @Override
    public List<Order> getOrdersByUserName(String userName) {
        return orderMapper.getOrdersByUserName(userName);
    }
    
    @Override
    public List<Order> getAllOrders() {
        return orderMapper.getAllOrders();
    }
    
    @Override
    public List<Order> getOrdersByPage(int pageNum, int pageSize) {
        int start = (pageNum - 1) * pageSize;
        return orderMapper.getOrdersByPage(start, pageSize);
    }
    
    @Override
    public int getOrderCount() {
        return orderMapper.getOrderCount();
    }
    
    @Override
    public void updateOrderStatus(String orderId, String status) {
        int orderStatus = 0;
        if ("已支付".equals(status)) {
            orderStatus = 1;
        } else if ("已取消".equals(status)) {
            orderStatus = 2;
        } else if ("已完成".equals(status)) {
            orderStatus = 3;
        }
        orderMapper.updateOrderStatus(orderId, orderStatus);
    }
}
