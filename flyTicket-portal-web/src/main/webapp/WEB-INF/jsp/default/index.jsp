<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html ng-app="portalApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>机票预订系统</title>
    <link rel="stylesheet" href="/flyTicket-portal-web/css/portal/common.css">
    <link rel="stylesheet" href="/flyTicket-portal-web/css/portal/index.css">
    <script src="https://cdn.jsdelivr.net/npm/angular@1.8.2/angular.min.js"></script>
    <script src="/flyTicket-portal-web/js/jquery.min.js"></script>
</head>
<body ng-controller="indexController">
    <!-- 导航栏 -->
    <div class="navbar">
        <div class="container">
            <div class="logo">机票预订系统</div>
            <div class="nav-menu">
                <a href="/flyTicket-portal-web/portal/index" class="active">首页</a>
                <a href="/flyTicket-portal-web/portal/toLogin" ng-if="!currentUser">登录</a>
                <a href="/flyTicket-portal-web/portal/toRegister" ng-if="!currentUser">注册</a>
                <a href="/flyTicket-portal-web/portal/toOrderList" ng-if="currentUser">我的订单</a>
                <a href="/flyTicket-portal-web/portal/logout" ng-if="currentUser">退出</a>
                <span ng-if="currentUser" class="user-info">欢迎，{{currentUser.userName}}</span>
            </div>
        </div>
    </div>

    <!-- 搜索区域 -->
    <div class="search-section">
        <div class="container">
            <h1>轻松预订，畅享旅程</h1>
            <div class="search-box">
                <div class="search-item">
                    <label>出发城市</label>
                    <input type="text" ng-model="searchParams.startPlace" placeholder="请输入出发城市">
                </div>
                <div class="search-item">
                    <label>到达城市</label>
                    <input type="text" ng-model="searchParams.endPlace" placeholder="请输入到达城市">
                </div>
                <div class="search-item">
                    <label>出发日期</label>
                    <input type="date" ng-model="searchParams.startTime">
                </div>
                <button class="search-btn" ng-click="searchFlights()">搜索航班</button>
            </div>
        </div>
    </div>

    <!-- 航班列表 -->
    <div class="flight-list-section">
        <div class="container">
            <h2>航班列表</h2>
            <div class="flight-list" ng-if="flights.length > 0">
                <div class="flight-item" ng-repeat="flight in flights">
                    <div class="flight-info">
                        <div class="flight-route">
                            <span class="start-place">{{flight.flightStartPlace}}</span>
                            <span class="arrow">→</span>
                            <span class="end-place">{{flight.flightEndPlace}}</span>
                        </div>
                        <div class="flight-number">航班号：{{flight.flightNumber}}</div>
                        <div class="flight-time">
                            <span>出发：{{formatTime(flight.flightStartTime)}}</span>
                            <span>到达：{{formatTime(flight.flightEndTime)}}</span>
                        </div>
                        <div class="flight-airport">
                            <span>{{flight.flightStartAirport}}</span>
                            <span>{{flight.flightEndAirport}}</span>
                        </div>
                    </div>
                    <div class="flight-price">
                        <div class="price-item">
                            <span class="grade">经济舱</span>
                            <span class="price">¥{{flight.flightBasePrice}}</span>
                            <span class="seats">余票：{{flight.flightBaseNumber}}</span>
                        </div>
                        <div class="price-item">
                            <span class="grade">商务舱</span>
                            <span class="price">¥{{flight.flightMiddlePrice}}</span>
                            <span class="seats">余票：{{flight.flightMiddleNumber}}</span>
                        </div>
                        <div class="price-item">
                            <span class="grade">头等舱</span>
                            <span class="price">¥{{flight.flightHighPrice}}</span>
                            <span class="seats">余票：{{flight.flightHighNumber}}</span>
                        </div>
                    </div>
                    <div class="flight-action">
                        <button class="book-btn" ng-click="toBookFlight(flight)">预订</button>
                    </div>
                </div>
            </div>
            <div class="no-data" ng-if="flights.length === 0">
                <p>暂无航班信息</p>
            </div>
        </div>
    </div>

    <!-- 页脚 -->
    <div class="footer">
        <div class="container">
            <p>&copy; 2024 机票预订系统 版权所有</p>
        </div>
    </div>

    <script>
        var app = angular.module('portalApp', []);
        
        app.controller('indexController', function($scope, $http, $window) {
            $scope.flights = [];
            $scope.currentUser = null;
            $scope.searchParams = {
                startPlace: '',
                endPlace: '',
                startTime: ''
            };
            
            // 检查登录状态
            $scope.checkLogin = function() {
                $http.get('/flyTicket-portal-web/portal/checkLogin').then(
                    function(response) {
                        if (response.data.success) {
                            $scope.currentUser = response.data.data;
                        }
                    },
                    function(error) {
                        console.log('检查登录状态失败', error);
                    }
                );
            };
            
            // 搜索航班
            $scope.searchFlights = function() {
                var params = [];
                if ($scope.searchParams.startPlace) {
                    params.push('startPlace=' + encodeURIComponent($scope.searchParams.startPlace));
                }
                if ($scope.searchParams.endPlace) {
                    params.push('endPlace=' + encodeURIComponent($scope.searchParams.endPlace));
                }
                if ($scope.searchParams.startTime) {
                    params.push('startTime=' + $scope.searchParams.startTime);
                }
                
                var url = '/flyTicket-portal-web/portal/search';
                if (params.length > 0) {
                    url += '?' + params.join('&');
                }
                
                $http.get(url).then(
                    function(response) {
                        $scope.flights = response.data;
                        if ($scope.flights.length === 0) {
                            alert('没有找到符合条件的航班');
                        }
                    },
                    function(error) {
                        console.log('搜索失败', error);
                        alert('搜索失败，请稍后重试');
                    }
                );
            };
            
            // 加载所有航班
            $scope.loadAllFlights = function() {
                $http.get('/flyTicket-portal-web/portal/search').then(
                    function(response) {
                        $scope.flights = response.data;
                    },
                    function(error) {
                        console.log('加载航班失败', error);
                    }
                );
            };
            
            // 预订航班
            $scope.toBookFlight = function(flight) {
                if (!$scope.currentUser) {
                    alert('请先登录');
                    $window.location.href = '/flyTicket-portal-web/portal/toLogin';
                    return;
                }
                
                // 将航班信息存储到sessionStorage
                sessionStorage.setItem('selectedFlight', JSON.stringify(flight));
                $window.location.href = '/flyTicket-portal-web/portal/toBook';
            };
            
            // 格式化时间
            $scope.formatTime = function(dateStr) {
                if (!dateStr) return '';
                var date = new Date(dateStr);
                var year = date.getFullYear();
                var month = (date.getMonth() + 1).toString().padStart(2, '0');
                var day = date.getDate().toString().padStart(2, '0');
                var hours = date.getHours().toString().padStart(2, '0');
                var minutes = date.getMinutes().toString().padStart(2, '0');
                return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes;
            };
            
            // 初始化
            $scope.checkLogin();
            $scope.loadAllFlights();
        });
    </script>
</body>
</html>
