package com.cafuc.service.impl;

import com.cafuc.mapper.FlightMapper;
import com.cafuc.pojo.Flight;
import com.cafuc.service.FlightService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * 航班服务实现类
 */
@Service
@Transactional
public class FlightServiceImpl implements FlightService {
    
    @Autowired
    private FlightMapper flightMapper;
    
    @Override
    public void addFlight(Flight flight) throws Exception {
        // 检查航班号是否重复
        Flight existFlight = flightMapper.getFlightByNumber(flight.getFlightNumber());
        if (existFlight != null) {
            throw new Exception("航班号已存在");
        }
        
        // 生成航班ID
        String flightId = "F" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + 
                         UUID.randomUUID().toString().substring(0, 4);
        flight.setFlightId(flightId);
        
        // 插入数据库
        flightMapper.addFlight(flight);
    }
    
    @Override
    public void deleteFlight(String flightId) throws Exception {
        flightMapper.deleteFlight(flightId);
    }
    
    @Override
    public void updateFlight(Flight flight) throws Exception {
        flightMapper.updateFlight(flight);
    }
    
    @Override
    public Flight getFlightById(String flightId) {
        return flightMapper.getFlightById(flightId);
    }
    
    @Override
    public Flight getFlightByNumber(String flightNumber) {
        return flightMapper.getFlightByNumber(flightNumber);
    }
    
    @Override
    public List<Flight> getAllFlights() {
        return flightMapper.getAllFlights();
    }
    
    @Override
    public List<Flight> searchFlights(Flight flight) {
        return flightMapper.searchFlights(flight);
    }
    
    @Override
    public List<Flight> getFlightsByPage(int pageNum, int pageSize) {
        int start = (pageNum - 1) * pageSize;
        return flightMapper.getFlightsByPage(start, pageSize);
    }
    
    @Override
    public int getFlightCount() {
        return flightMapper.getFlightCount();
    }
    
    @Override
    public void updateFlightSeats(String flightId, String grade, int number) throws Exception {
        flightMapper.updateFlightSeats(flightId, grade, number);
    }
}
