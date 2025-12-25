package com.cafuc.mapper;

import com.cafuc.pojo.Flight;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 航班数据访问接口
 */
public interface FlightMapper {
    
    /**
     * 添加航班
     */
    void addFlight(Flight flight);
    
    /**
     * 删除航班
     */
    void deleteFlight(String flightId);
    
    /**
     * 更新航班
     */
    void updateFlight(Flight flight);
    
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
    List<Flight> getFlightsByPage(@Param("start") int start, @Param("pageSize") int pageSize);
    
    /**
     * 获取航班总数
     */
    int getFlightCount();
    
    /**
     * 更新航班座位数
     */
    void updateFlightSeats(@Param("flightId") String flightId, @Param("grade") String grade, @Param("number") int number);
}
