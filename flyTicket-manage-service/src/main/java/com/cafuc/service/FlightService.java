package com.cafuc.service;

import com.cafuc.pojo.Flight;

import java.util.List;

/**
 * 航班服务接口
 */
public interface FlightService {
    
    /**
     * 添加航班
     */
    void addFlight(Flight flight) throws Exception;
    
    /**
     * 删除航班
     */
    void deleteFlight(String flightId) throws Exception;
    
    /**
     * 更新航班
     */
    void updateFlight(Flight flight) throws Exception;
    
    /**
     * 根据ID查询航班
     */
    Flight getFlightById(String flightId);
    
    /**
     * 根据航班号查询航班
     */
    Flight getFlightByNumber(String flightNumber);
    
    /**
     * 查询所有航班
     */
    List<Flight> getAllFlights();
    
    /**
     * 条件查询航班
     */
    List<Flight> searchFlights(Flight flight);
    
    /**
     * 分页查询航班
     */
    List<Flight> getFlightsByPage(int pageNum, int pageSize);
    
    /**
     * 获取航班总数
     */
    int getFlightCount();
    
    /**
     * 更新航班座位数
     */
    void updateFlightSeats(String flightId, String grade, int number) throws Exception;
}
