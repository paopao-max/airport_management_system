<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html ng-app="portalApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>填写订单 - 机票预订系统</title>
    <link rel="stylesheet" href="/flyTicket-portal-web/css/portal/common.css">
    <link rel="stylesheet" href="/flyTicket-portal-web/css/portal/book.css">
    <script src="https://cdn.jsdelivr.net/npm/angular@1.8.2/angular.min.js"></script>
    <script src="/flyTicket-portal-web/js/jquery.min.js"></script>
</head>
<body ng-controller="bookController">
    <!-- 导航栏 -->
    <div class="navbar">
        <div class="container">
            <div class="logo">机票预订系统</div>
            <div class="nav-menu">
                <a href="/flyTicket-portal-web/portal/index">首页</a>
                <a href="/flyTicket-portal-web/portal/toOrderList">我的订单</a>
                <a href="/flyTicket-portal-web/portal/logout">退出</a>
                <span class="user-info">欢迎，{{currentUser.userName}}</span>
            </div>
        </div>
    </div>

    <!-- 订单填写 -->
    <div class="book-container">
        <div class="container">
            <h2>填写订单</h2>
            
            <!-- 航班信息 -->
            <div class="flight-info" ng-if="flight">
                <h3>航班信息</h3>
                <div class="info-row">
                    <span>航班号：{{flight.flightNumber}}</span>
                    <span>出发：{{flight.flightStartPlace}} - {{flight.flightStartAirport}}</span>
                </div>
                <div class="info-row">
                    <span>到达：{{flight.flightEndPlace}} - {{flight.flightEndAirport}}</span>
                </div>
                <div class="info-row">
                    <span>出发时间：{{formatTime(flight.flightStartTime)}}</span>
                    <span>到达时间：{{formatTime(flight.flightEndTime)}}</span>
                </div>
            </div>

            <!-- 订单表单 -->
            <div class="order-form">
                <h3>乘客信息</h3>
                <form ng-submit="submitOrder()">
                    <div class="form-group">
                        <label>乘客姓名</label>
                        <input type="text" ng-model="order.passengerName" placeholder="请输入乘客姓名" required>
                    </div>
                    <div class="form-group">
                        <label>身份证号</label>
                        <input type="text" ng-model="order.passengerId" placeholder="请输入身份证号" required>
                    </div>
                    <div class="form-group">
                        <label>联系人姓名</label>
                        <input type="text" ng-model="order.contactName" placeholder="请输入联系人姓名" required>
                    </div>
                    <div class="form-group">
                        <label>联系电话</label>
                        <input type="tel" ng-model="order.contactPhone" placeholder="请输入联系电话" required>
                    </div>
                    
                    <h3>舱位选择</h3>
                    <div class="grade-select">
                        <label ng-repeat="grade in grades">
                            <input type="radio" ng-model="order.grade" value="{{grade.value}}" ng-change="updatePrice()">
                            <span class="grade-name">{{grade.name}}</span>
                            <span class="grade-price">¥{{grade.price}}</span>
                            <span class="grade-seats">余票：{{grade.seats}}</span>
                        </label>
                    </div>
                    
                    <div class="total-price">
                        <span>订单金额：</span>
                        <span class="price">¥{{order.price}}</span>
                    </div>
                    
                    <button type="submit" class="submit-btn">提交订单</button>
                </form>
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
        
        app.controller('bookController', function($scope, $http, $window) {
            $scope.currentUser = null;
            $scope.flight = null;
            $scope.order = {
                passengerName: '',
                passengerId: '',
                contactName: '',
                contactPhone: '',
                grade: '3',
                price: 0
            };
            $scope.grades = [];
            
            // 检查登录状态
            $scope.checkLogin = function() {
                $http.get('/flyTicket-portal-web/portal/checkLogin').then(
                    function(response) {
                        if (response.data.success) {
                            $scope.currentUser = response.data.data;
                        } else {
                            alert('请先登录');
                            $window.location.href = '/flyTicket-portal-web/portal/toLogin';
                        }
                    },
                    function(error) {
                        console.log('检查登录状态失败', error);
                    }
                );
            };
            
            // 加载航班信息
            $scope.loadFlight = function() {
                var flightStr = sessionStorage.getItem('selectedFlight');
                if (!flightStr) {
                    alert('请先选择航班');
                    $window.location.href = '/flyTicket-portal-web/portal/index';
                    return;
                }
                
                $scope.flight = JSON.parse(flightStr);
                
                // 设置舱位选项
                $scope.grades = [
                    {name: '经济舱', value: '3', price: $scope.flight.flightBasePrice, seats: $scope.flight.flightBaseNumber},
                    {name: '商务舱', value: '2', price: $scope.flight.flightMiddlePrice, seats: $scope.flight.flightMiddleNumber},
                    {name: '头等舱', value: '1', price: $scope.flight.flightHighPrice, seats: $scope.flight.flightHighNumber}
                ];
                
                // 默认选择经济舱
                $scope.updatePrice();
            };
            
            // 更新价格
            $scope.updatePrice = function() {
                var selectedGrade = $scope.grades.find(function(g) {
                    return g.value === $scope.order.grade;
                });
                if (selectedGrade) {
                    $scope.order.price = selectedGrade.price;
                }
            };
            
            // 提交订单
            $scope.submitOrder = function() {
                // 设置订单信息
                $scope.order.flightNumber = $scope.flight.flightNumber;
                $scope.order.userName = $scope.currentUser.userName;
                
                $http.post('/flyTicket-portal-web/portal/createOrder', $scope.order).then(
                    function(response) {
                        if (response.data.success) {
                            alert('订单创建成功');
                            $window.location.href = '/flyTicket-portal-web/portal/toPay?orderId=' + response.data.data.orderId;
                        } else {
                            alert('订单创建失败：' + response.data.message);
                        }
                    },
                    function(error) {
                        console.log('订单创建失败', error);
                        alert('订单创建失败，请稍后重试');
                    }
                );
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
            $scope.loadFlight();
        });
    </script>
</body>
</html>
