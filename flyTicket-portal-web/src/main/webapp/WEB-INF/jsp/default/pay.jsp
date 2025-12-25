<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html ng-app="portalApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>订单支付 - 机票预订系统</title>
    <link rel="stylesheet" href="/flyTicket-portal-web/css/portal/common.css">
    <link rel="stylesheet" href="/flyTicket-portal-web/css/portal/pay.css">
    <script src="https://cdn.jsdelivr.net/npm/angular@1.8.2/angular.min.js"></script>
    <script src="/flyTicket-portal-web/js/jquery.min.js"></script>
</head>
<body ng-controller="payController">
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

    <!-- 支付页面 -->
    <div class="pay-container">
        <div class="container">
            <h2>订单支付</h2>
            
            <!-- 订单信息 -->
            <div class="order-info" ng-if="order">
                <h3>订单信息</h3>
                <div class="info-row">
                    <span>订单号：{{order.orderNumber}}</span>
                    <span>航班号：{{order.flightNumber}}</span>
                </div>
                <div class="info-row">
                    <span>乘客姓名：{{order.passengerName}}</span>
                    <span>联系人：{{order.contactName}}</span>
                </div>
                <div class="info-row">
                    <span>联系电话：{{order.contactPhone}}</span>
                </div>
                <div class="info-row">
                    <span>舱位等级：{{getGradeName(order.grade)}}</span>
                </div>
            </div>

            <!-- 支付金额 -->
            <div class="pay-amount">
                <h3>支付金额</h3>
                <p class="amount">¥{{order.price}}</p>
            </div>

            <!-- 支付方式 -->
            <div class="pay-methods">
                <h3>选择支付方式</h3>
                <div class="method" ng-class="{selected: selectedMethod === 'alipay'}" ng-click="selectPayMethod('alipay')">
                    <div class="method-icon alipay">支付宝</div>
                    <span>支付宝支付</span>
                </div>
                <div class="method" ng-class="{selected: selectedMethod === 'wechat'}" ng-click="selectPayMethod('wechat')">
                    <div class="method-icon wechat">微信支付</div>
                    <span>微信支付</span>
                </div>
            </div>

            <!-- 支付按钮 -->
            <button class="pay-btn" ng-click="submitPay()">确认支付</button>
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
        
        app.controller('payController', function($scope, $http, $window, $location) {
            $scope.currentUser = null;
            $scope.order = null;
            $scope.selectedMethod = 'alipay';
            $scope.orderId = '';
            
            // 获取URL参数
            $scope.getUrlParam = function(name) {
                var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)');
                var r = window.location.search.substr(1).match(reg);
                if (r != null) return decodeURIComponent(r[2]);
                return null;
            };
            
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
            
            // 加载订单信息
            $scope.loadOrder = function() {
                $scope.orderId = $scope.getUrlParam('orderId');
                if (!$scope.orderId) {
                    alert('订单ID不能为空');
                    $window.location.href = '/flyTicket-portal-web/portal/index';
                    return;
                }
                
                $http.get('/flyTicket-portal-web/portal/getOrder?orderId=' + $scope.orderId).then(
                    function(response) {
                        if (response.data.success) {
                            $scope.order = response.data.data;
                        } else {
                            alert('获取订单信息失败：' + response.data.message);
                            $window.location.href = '/flyTicket-portal-web/portal/index';
                        }
                    },
                    function(error) {
                        console.log('获取订单信息失败', error);
                        alert('获取订单信息失败，请稍后重试');
                    }
                );
            };
            
            // 选择支付方式
            $scope.selectPayMethod = function(method) {
                $scope.selectedMethod = method;
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
            
            // 提交支付
            $scope.submitPay = function() {
                if (confirm('确认支付 ¥' + $scope.order.price + ' 吗？')) {
                    $http.post('/flyTicket-portal-web/portal/pay', {
                        orderId: $scope.orderId,
                        payMethod: $scope.selectedMethod
                    }).then(
                        function(response) {
                            if (response.data.success) {
                                alert('支付成功！');
                                $window.location.href = '/flyTicket-portal-web/portal/toOrderList';
                            } else {
                                alert('支付失败：' + response.data.message);
                            }
                        },
                        function(error) {
                            console.log('支付失败', error);
                            alert('支付失败，请稍后重试');
                        }
                    );
                }
            };
            
            // 初始化
            $scope.checkLogin();
            $scope.loadOrder();
        });
    </script>
</body>
</html>
