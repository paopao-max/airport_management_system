package com.cafuc.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cafuc.pojo.Flight;
import com.cafuc.pojo.Order;
import com.cafuc.pojo.Result;
import com.cafuc.pojo.User;
import com.cafuc.service.FlightService;
import com.cafuc.service.OrderService;
import com.cafuc.service.UserService;

@Controller
@RequestMapping("/portal")
public class PortalController {
    
    @Autowired
    private FlightService flightService;
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private OrderService orderService;
    
    // 首页
    @RequestMapping("/index")
    public String index(Model model) {
        // 获取所有航班
        List<Flight> flights = flightService.getAllFlights();
        model.addAttribute("flights", flights);
        return "default/index";
    }
    
    // 航班搜索
    @RequestMapping("/search")
    @ResponseBody
    public List<Flight> searchFlights(
            @RequestParam(value = "startPlace", required = false) String startPlace,
            @RequestParam(value = "endPlace", required = false) String endPlace,
            @RequestParam(value = "startTime", required = false) String startTimeStr) {
        
        Flight flight = new Flight();
        
        if (startPlace != null && !startPlace.trim().equals("")) {
            flight.setFlightStartPlace(startPlace);
        }
        
        if (endPlace != null && !endPlace.trim().equals("")) {
            flight.setFlightEndPlace(endPlace);
        }
        
        if (startTimeStr != null && !startTimeStr.trim().equals("")) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date startTime = sdf.parse(startTimeStr);
                flight.setFlightStartTime(startTime);
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        
        return flightService.searchFlights(flight);
    }
    
    // 航班详情
    @RequestMapping("/detail")
    public String flightDetail(@RequestParam("flightId") String flightId, Model model) {
        Flight flight = flightService.getFlightById(flightId);
        model.addAttribute("flight", flight);
        return "default/flight_detail";
    }
    
    @RequestMapping("/getFlightDetail")
    @ResponseBody
    public Flight getFlightDetail(@RequestParam("flightId") String flightId) {
        return flightService.getFlightById(flightId);
    }
    
    // 登录页面
    @RequestMapping("/loginPage")
    public String loginPage() {
        return "default/login";
    }
    
    // 用户登录
    @RequestMapping("/login")
    @ResponseBody
    public Result login(@RequestParam("userName") String userName,
                       @RequestParam("userPwd") String userPwd,
                       HttpSession session) {
        try {
            User user = userService.findUserByNameAndPwd(userName, userPwd);
            if (user != null) {
                session.setAttribute("user", user);
                return new Result(true, "登录成功");
            } else {
                return new Result(false, "用户名或密码错误");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "登录失败：" + e.getMessage());
        }
    }
    
    // 注册页面
    @RequestMapping("/registerPage")
    public String registerPage() {
        return "default/register";
    }
    
    // 用户注册
    @RequestMapping("/register")
    @ResponseBody
    public Result register(User user) {
        try {
            // 检查用户名是否已存在
            User existUser = userService.findUserByName(user.getUserName());
            if (existUser != null) {
                return new Result(false, "用户名已存在");
            }
            
            // 生成用户ID
            user.setUserId("U" + System.currentTimeMillis());
            
            userService.addUser(user);
            return new Result(true, "注册成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "注册失败：" + e.getMessage());
        }
    }
    
    // 退出登录
    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/portal/index";
    }
    
    // 订单填写页面
    @RequestMapping("/orderPage")
    public String orderPage(@RequestParam("flightId") String flightId,
                           @RequestParam("grade") String grade,
                           Model model) {
        Flight flight = flightService.getFlightById(flightId);
        model.addAttribute("flight", flight);
        model.addAttribute("grade", grade);
        return "default/order_fill";
    }
    
    // 提交订单
    @RequestMapping("/submitOrder")
    @ResponseBody
    public Result submitOrder(Order order, HttpSession session) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return new Result(false, "请先登录");
            }
            
            // 生成订单ID和订单号
            String orderId = "O" + System.currentTimeMillis();
            String orderNumber = "ORD" + System.currentTimeMillis();
            
            order.setOrderId(orderId);
            order.setOrderNumber(orderNumber);
            order.setUserName(user.getUserName());
            order.setOrderDate(new Date());
            
            // 保存订单
            orderService.saveOrder(order);
            
            return new Result(true, "订单提交成功", orderId);
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "订单提交失败：" + e.getMessage());
        }
    }
    
    // 我的订单
    @RequestMapping("/myOrders")
    public String myOrders(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/portal/loginPage";
        }
        
        List<Order> orders = orderService.getOrdersByUserName(user.getUserName());
        model.addAttribute("orders", orders);
        return "default/order_list";
    }
    
    // 支付页面
    @RequestMapping("/payPage")
    public String payPage(@RequestParam("orderId") String orderId, Model model) {
        Order order = orderService.getOrderById(orderId);
        model.addAttribute("order", order);
        return "default/pay";
    }
    
    // 支付
    @RequestMapping("/pay")
    @ResponseBody
    public Result pay(@RequestParam("orderId") String orderId) {
        try {
            orderService.updateOrderStatus(orderId, "已支付");
            return new Result(true, "支付成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "支付失败：" + e.getMessage());
        }
    }
}
