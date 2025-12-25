<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html ng-app="portalApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户登录 - 机票预订系统</title>
    <link rel="stylesheet" href="/flyTicket-portal-web/css/portal/common.css">
    <link rel="stylesheet" href="/flyTicket-portal-web/css/portal/login.css">
    <script src="https://cdn.jsdelivr.net/npm/angular@1.8.2/angular.min.js"></script>
    <script src="/flyTicket-portal-web/js/jquery.min.js"></script>
</head>
<body ng-controller="loginController">
    <!-- 导航栏 -->
    <div class="navbar">
        <div class="container">
            <div class="logo">机票预订系统</div>
            <div class="nav-menu">
                <a href="/flyTicket-portal-web/portal/index">首页</a>
                <a href="/flyTicket-portal-web/portal/toLogin" class="active">登录</a>
                <a href="/flyTicket-portal-web/portal/toRegister">注册</a>
            </div>
        </div>
    </div>

    <!-- 登录表单 -->
    <div class="login-container">
        <div class="login-box">
            <h2>用户登录</h2>
            <form ng-submit="login()">
                <div class="form-group">
                    <label>用户名</label>
                    <input type="text" ng-model="user.userName" placeholder="请输入用户名" required>
                </div>
                <div class="form-group">
                    <label>密码</label>
                    <input type="password" ng-model="user.userPwd" placeholder="请输入密码" required>
                </div>
                <button type="submit" class="login-btn">登录</button>
            </form>
            <div class="register-link">
                还没有账号？<a href="/flyTicket-portal-web/portal/toRegister">立即注册</a>
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
        
        app.controller('loginController', function($scope, $http, $window) {
            $scope.user = {
                userName: '',
                userPwd: ''
            };
            
            // 登录
            $scope.login = function() {
                $http.post('/flyTicket-portal-web/portal/login', $scope.user).then(
                    function(response) {
                        if (response.data.success) {
                            alert('登录成功');
                            $window.location.href = '/flyTicket-portal-web/portal/index';
                        } else {
                            alert('登录失败：' + response.data.message);
                        }
                    },
                    function(error) {
                        console.log('登录失败', error);
                        alert('登录失败，请稍后重试');
                    }
                );
            };
        });
    </script>
</body>
</html>
