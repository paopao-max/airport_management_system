package com.cafuc.controller;

import com.cafuc.pojo.Order;
import com.cafuc.pojo.PageResult;
import com.cafuc.pojo.Result;
import com.cafuc.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 订单管理控制器
 */
@Controller
@RequestMapping("/orderManage")
public class OrderManageController {
    
    @Autowired
    private OrderService orderService;
    
    /**
     * 跳转到订单列表页面
     */
    @RequestMapping("/list")
    public String list() {
        return "admin/order_list";
    }
    
    /**
     * 查询订单列表（分页）
     */
    @RequestMapping(value = "/search", method = RequestMethod.GET)
    @ResponseBody
    public PageResult search(int page, int rows, String searchEntity) {
        try {
            List<Order> orderList;
            int total;
            
            if (searchEntity != null && !searchEntity.trim().equals("")) {
                // 条件查询
                orderList = orderService.getAllOrders();
                total = orderList.size();
            } else {
                // 分页查询所有
                orderList = orderService.getOrdersByPage(page, rows);
                total = orderService.getOrderCount();
            }
            
            return new PageResult(total, orderList);
        } catch (Exception e) {
            e.printStackTrace();
            return new PageResult(0, null);
        }
    }
    
    /**
     * 根据ID查询订单
     */
    @RequestMapping(value = "/getOrderById", method = RequestMethod.GET)
    @ResponseBody
    public Order getOrderById(String orderId) {
        return orderService.getOrderById(orderId);
    }
    
    /**
     * 更新订单状态
     */
    @RequestMapping(value = "/updateOrderStatus", method = RequestMethod.POST)
    @ResponseBody
    public Result updateOrderStatus(@RequestBody Order order) {
        try {
            orderService.updateOrderStatus(order.getOrderId(), order.getOrderStatus());
            return new Result(true, "更新成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "更新失败：" + e.getMessage());
        }
    }
    
    /**
     * 删除订单
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Result delete(@RequestBody String[] ids) {
        try {
            for (String id : ids) {
                orderService.deleteOrder(id);
            }
            return new Result(true, "删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "删除失败");
        }
    }
}
