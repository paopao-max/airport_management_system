<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html ng-app="portalApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户注册 - 机票预订系统</title>
    <link rel="stylesheet" href="/flyTicket-portal-web/css/portal/common.css">
    <link rel="stylesheet" href="/flyTicket-portal-web/css/portal/register.css">
    <script src="https://cdn.jsdelivr.net/npm/angular@1.8.2/angular.min.js"></script>
    <script src="/flyTicket-portal-web/js/jquery.min.js"></script>
</head>
<body ng-controller="registerController">
    <!-- 导航栏 -->
    <div class="navbar">
        <div class="container">
            <div class="logo">机票预订系统</div>
            <div class="nav-menu">
                <a href="/flyTicket-portal-web/portal/index">首页</a>
                <a href="/flyTicket-portal-web/portal/toLogin">登录</a>
                <a href="/flyTicket-portal-web/portal/toRegister" class="active">注册</a>
            </div>
        </div>
    </div>

    <!-- 注册表单 -->
    <div class="register-container">
        <div class="register-box">
            <h2>用户注册</h2>
            <form ng-submit="register()">
                <div class="form-group">
                    <label>用户名</label>
                    <input type="text" ng-model="user.userName" placeholder="请输入用户名" required>
                </div>
                <div class="form-group">
                    <label>密码</label>
                    <input type="password" ng-model="user.userPwd" placeholder="请输入密码" required>
                </div>
                <div class="form-group">
                    <label>确认密码</label>
                    <input type="password" ng-model="confirmPwd" placeholder="请再次输入密码" required>
                </div>
                <div class="form-group">
                    <label>邮箱</label>
                    <input type="email" ng-model="user.userEmail" placeholder="请输入邮箱">
                </div>
                <div class="form-group">
                    <label>手机号</label>
                    <input type="tel" ng-model="user.userPhone" placeholder="请输入手机号">
                </div>
                <div class="form-group">
                    <label>性别</label>
                    <select ng-model="user.userSex">
                        <option value="">请选择</option>
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>年龄</label>
                    <input type="number" ng-model="user.userAge" placeholder="请输入年龄" min="1" max="120">
                </div>
                <button type="submit" class="register-btn">注册</button>
            </form>
            <div class="login-link">
                已有账号？<a href="/flyTicket-portal-web/portal/toLogin">立即登录</a>
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
        
        app.controller('registerController', function($scope, $http, $window) {
            $scope.user = {
                userName: '',
                userPwd: '',
                userEmail: '',
                userPhone: '',
                userSex: '',
                userAge: ''
            };
            $scope.confirmPwd = '';
            
            // 注册
            $scope.register = function() {
                // 验证密码
                if ($scope.user.userPwd !== $scope.confirmPwd) {
                    alert('两次输入的密码不一致');
                    return;
                }
                
                $http.post('/flyTicket-portal-web/portal/register', $scope.user).then(
                    function(response) {
                        if (response.data.success) {
                            alert('注册成功，请登录');
                            $window.location.href = '/flyTicket-portal-web/portal/toLogin';
                        } else {
                            alert('注册失败：' + response.data.message);
                        }
                    },
                    function(error) {
                        console.log('注册失败', error);
                        alert('注册失败，请稍后重试');
                    }
                );
            };
        });
    </script>
</body>
</html>
