<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html ng-app="portalApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>我的订单 - 机票预订系统</title>
    <link rel="stylesheet" href="/flyTicket-portal-web/css/portal/common.css">
    <link rel="stylesheet" href="/flyTicket-portal-web/css/portal/order_list.css">
    <script src="https://cdn.jsdelivr.net/npm/angular@1.8.2/angular.min.js"></script>
    <script src="/flyTicket-portal-web/js/jquery.min.js"></script>
</head>
<body ng-controller="orderListController">
    <!-- 导航栏 -->
    <div class="navbar">
        <div class="container">
            <div class="logo">机票预订系统</div>
            <div class="nav-menu">
                <a href="/flyTicket-portal-web/portal/index">首页</a>
                <a href="/flyTicket-portal-web/portal/toOrderList" class="active">我的订单</a>
                <a href="/flyTicket-portal-web/portal/logout">退出</a>
                <span class="user-info">欢迎，{{currentUser.userName}}</span>
            </div>
        </div>
    </div>

    <!-- 订单列表 -->
    <div class="order-list-container">
        <div class="container">
            <h2>我的订单</h2>
            
            <div class="order-list" ng-if="orders.length > 0">
                <div class="order-item" ng-repeat="order in orders">
                    <div class="order-header">
                        <span class="order-number">订单号：{{order.orderNumber}}</span>
                        <span class="order-date">下单时间：{{formatTime(order.orderDate)}}</span>
                        <span class="order-status" ng-class="getStatusClass(order.status)">{{getStatusText(order.status)}}</span>
                    </div>
                    <div class="order-body">
                        <div class="order-info">
                            <div class="info-row">
                                <span>航班号：{{order.flightNumber}}</span>
                                <span>乘客姓名：{{order.passengerName}}</span>
                            </div>
                            <div class="info-row">
                                <span>联系人：{{order.contactName}}</span>
                                <span>联系电话：{{order.contactPhone}}</span>
                            </div>
                            <div class="info-row">
                                <span>舱位等级：{{getGradeName(order.grade)}}</span>
                                <span>订单金额：<span class="price">¥{{order.price}}</span></span>
                            </div>
                        </div>
                        <div class="order-action" ng-if="order.status === 0">
                            <button class="pay-btn" ng-click="toPay(order.orderId)">去支付</button>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="no-data" ng-if="orders.length === 0">
                <p>暂无订单信息</p>
                <a href="/flyTicket-portal-web/portal/index" class="btn">去预订航班</a>
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
        
        app.controller('orderListController', function($scope, $http, $window) {
            $scope.currentUser = null;
            $scope.orders = [];
            
            // 检查登录状态
            $scope.checkLogin = function() {
                $http.get('/flyTicket-portal-web/portal/checkLogin').then(
                    function(response) {
                        if (response.data.success) {
                            $scope.currentUser = response.data.data;
                            $scope.loadOrders();
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
            
            // 加载订单列表
            $scope.loadOrders = function() {
                $http.get('/flyTicket-portal-web/portal/getUserOrders').then(
                    function(response) {
                        if (response.data.success) {
                            $scope.orders = response.data.data;
                        } else {
                            alert('获取订单列表失败：' + response.data.message);
                        }
                    },
                    function(error) {
                        console.log('获取订单列表失败', error);
                        alert('获取订单列表失败，请稍后重试');
                    }
                );
            };
            
            // 去支付
            $scope.toPay = function(orderId) {
                $window.location.href = '/flyTicket-portal-web/portal/toPay?orderId=' + orderId;
            };
            
            // 获取舱位名称
            $scope.getGradeName = function(grade) {
                var gradeMap = {
                    '1': '头等舱',
                    '2': '商务舱',
                    '3': '经济舱'
                };
                return gradeMap[grade] || '经济舱';
            };
            
            // 获取状态文本
            $scope.getStatusText = function(status) {
                var statusMap = {
                    0: '待支付',
                    1: '已支付',
                    2: '已取消'
                };
                return statusMap[status] || '未知';
            };
            
            // 获取状态样式类
            $scope.getStatusClass = function(status) {
                var classMap = {
                    0: 'status-pending',
                    1: 'status-paid',
                    2: 'status-cancelled'
                };
                return classMap[status] || '';
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
        });
    </script>
</body>
</html>
