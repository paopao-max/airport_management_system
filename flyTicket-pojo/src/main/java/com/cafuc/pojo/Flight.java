package com.cafuc.pojo;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 航班信息实体类
 */
public class Flight implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private String flightId;              // 航班ID
    private String flightNumber;          // 航班号
    private String flightStartPlace;      // 出发城市
    private String flightEndPlace;        // 到达城市
    private String flightStartAirport;    // 出发机场
    private String flightEndAirport;      // 到达机场
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date flightStartTime;         // 出发时间
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date flightEndTime;           // 到达时间
    private BigDecimal flightHighPrice;   // 头等舱价格
    private BigDecimal flightMiddlePrice; // 商务舱价格
    private BigDecimal flightBasePrice;   // 经济舱价格
    private Integer flightHighNumber;     // 头等舱座位数
    private Integer flightMiddleNumber;   // 商务舱座位数
    private Integer flightBaseNumber;     // 经济舱座位数
    private String flightType;            // 航班类型
    
    public Flight() {
    }
    
    public String getFlightId() {
        return flightId;
    }
    
    public void setFlightId(String flightId) {
        this.flightId = flightId;
    }
    
    public String getFlightNumber() {
        return flightNumber;
    }
    
    public void setFlightNumber(String flightNumber) {
        this.flightNumber = flightNumber;
    }
    
    public String getFlightStartPlace() {
        return flightStartPlace;
    }
    
    public void setFlightStartPlace(String flightStartPlace) {
        this.flightStartPlace = flightStartPlace;
    }
    
    public String getFlightEndPlace() {
        return flightEndPlace;
    }
    
    public void setFlightEndPlace(String flightEndPlace) {
        this.flightEndPlace = flightEndPlace;
    }
    
    public String getFlightStartAirport() {
        return flightStartAirport;
    }
    
    public void setFlightStartAirport(String flightStartAirport) {
        this.flightStartAirport = flightStartAirport;
    }
    
    public String getFlightEndAirport() {
        return flightEndAirport;
    }
    
    public void setFlightEndAirport(String flightEndAirport) {
        this.flightEndAirport = flightEndAirport;
    }
    
    public Date getFlightStartTime() {
        return flightStartTime;
    }
    
    public void setFlightStartTime(Date flightStartTime) {
        this.flightStartTime = flightStartTime;
    }
    
    public Date getFlightEndTime() {
        return flightEndTime;
    }
    
    public void setFlightEndTime(Date flightEndTime) {
        this.flightEndTime = flightEndTime;
    }
    
    public BigDecimal getFlightHighPrice() {
        return flightHighPrice;
    }
    
    public void setFlightHighPrice(BigDecimal flightHighPrice) {
        this.flightHighPrice = flightHighPrice;
    }
    
    public BigDecimal getFlightMiddlePrice() {
        return flightMiddlePrice;
    }
    
    public void setFlightMiddlePrice(BigDecimal flightMiddlePrice) {
        this.flightMiddlePrice = flightMiddlePrice;
    }
    
    public BigDecimal getFlightBasePrice() {
        return flightBasePrice;
    }
    
    public void setFlightBasePrice(BigDecimal flightBasePrice) {
        this.flightBasePrice = flightBasePrice;
    }
    
    public Integer getFlightHighNumber() {
        return flightHighNumber;
    }
    
    public void setFlightHighNumber(Integer flightHighNumber) {
        this.flightHighNumber = flightHighNumber;
    }
    
    public Integer getFlightMiddleNumber() {
        return flightMiddleNumber;
    }
    
    public void setFlightMiddleNumber(Integer flightMiddleNumber) {
        this.flightMiddleNumber = flightMiddleNumber;
    }
    
    public Integer getFlightBaseNumber() {
        return flightBaseNumber;
    }
    
    public void setFlightBaseNumber(Integer flightBaseNumber) {
        this.flightBaseNumber = flightBaseNumber;
    }
    
    public String getFlightType() {
        return flightType;
    }
    
    public void setFlightType(String flightType) {
        this.flightType = flightType;
    }
    
    @Override
    public String toString() {
        return "Flight{" +
                "flightId='" + flightId + '\'' +
                ", flightNumber='" + flightNumber + '\'' +
                ", flightStartPlace='" + flightStartPlace + '\'' +
                ", flightEndPlace='" + flightEndPlace + '\'' +
                ", flightStartAirport='" + flightStartAirport + '\'' +
                ", flightEndAirport='" + flightEndAirport + '\'' +
                ", flightStartTime=" + flightStartTime +
                ", flightEndTime=" + flightEndTime +
                ", flightHighPrice=" + flightHighPrice +
                ", flightMiddlePrice=" + flightMiddlePrice +
                ", flightBasePrice=" + flightBasePrice +
                ", flightHighNumber=" + flightHighNumber +
                ", flightMiddleNumber=" + flightMiddleNumber +
                ", flightBaseNumber=" + flightBaseNumber +
                ", flightType='" + flightType + '\'' +
                '}';
    }
}
