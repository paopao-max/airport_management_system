package com.cafuc.controller;

import com.cafuc.pojo.Flight;
import com.cafuc.pojo.PageResult;
import com.cafuc.pojo.Result;
import com.cafuc.service.FlightService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * 航班管理控制器
 */
@Controller
@RequestMapping("/flightManage")
public class FlightManageController {
    
    @Autowired
    private FlightService flightService;
    
    /**
     * 跳转到航班列表页面
     */
    @RequestMapping("/list")
    public String list() {
        return "admin/flight_list";
    }
    
    /**
     * 添加航班
     */
    @RequestMapping(value = "/addFlight", method = RequestMethod.POST)
    @ResponseBody
    public Result addFlight(@RequestBody Flight flight) {
        try {
            flightService.addFlight(flight);
            return new Result(true, "添加成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "添加失败：" + e.getMessage());
        }
    }
    
    /**
     * 查询航班列表（分页）
     */
    @RequestMapping(value = "/search", method = RequestMethod.GET)
    @ResponseBody
    public PageResult search(int page, int rows, String searchEntity) {
        try {
            List<Flight> flightList;
            int total;
            
            if (searchEntity != null && !searchEntity.trim().equals("")) {
                // 条件查询
                Flight flight = new Flight();
                flight.setFlightStartPlace(searchEntity);
                flight.setFlightEndPlace(searchEntity);
                flightList = flightService.searchFlights(flight);
                total = flightList.size();
            } else {
                // 分页查询所有
                flightList = flightService.getFlightsByPage(page, rows);
                total = flightService.getFlightCount();
            }
            
            return new PageResult(total, flightList);
        } catch (Exception e) {
            e.printStackTrace();
            return new PageResult(0, null);
        }
    }
    
    /**
     * 根据ID查询航班
     */
    @RequestMapping(value = "/getFlightById", method = RequestMethod.GET)
    @ResponseBody
    public Flight getFlightById(String flightId) {
        return flightService.getFlightById(flightId);
    }
    
    /**
     * 更新航班
     */
    @RequestMapping(value = "/updateFlight", method = RequestMethod.POST)
    @ResponseBody
    public Result updateFlight(@RequestBody Flight flight) {
        try {
            flightService.updateFlight(flight);
            return new Result(true, "更新成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "更新失败：" + e.getMessage());
        }
    }
    
    /**
     * 删除航班
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Result delete(@RequestBody String[] ids) {
        try {
            for (String id : ids) {
                flightService.deleteFlight(id);
            }
            return new Result(true, "删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "删除失败");
        }
    }
    
    /**
     * 查询所有航班（不分页）
     */
    @RequestMapping(value = "/getAllFlights", method = RequestMethod.GET)
    @ResponseBody
    public List<Flight> getAllFlights() {
        return flightService.getAllFlights();
    }
}
