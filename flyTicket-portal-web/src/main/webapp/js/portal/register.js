/**
 * 注册页面AngularJS控制器
 */
var app = angular.module('portalApp', []);

app.controller('registerController', function($scope, $http, $window) {
    $scope.user = {
        userName: '',
        userPwd: '',
        userPwdConfirm: '',
        userEmail: '',
        userPhone: '',
        userSex: '男',
        userAge: ''
    };
    
    // 注册
    $scope.register = function() {
        // 验证用户名
        if (!$scope.user.userName) {
            alert('请输入用户名');
            return;
        }
        
        if ($scope.user.userName.length < 3) {
            alert('用户名至少3个字符');
            return;
        }
        
        // 验证密码
        if (!$scope.user.userPwd) {
            alert('请输入密码');
            return;
        }
        
        if ($scope.user.userPwd.length < 6) {
            alert('密码至少6个字符');
            return;
        }
        
        // 验证确认密码
        if ($scope.user.userPwd !== $scope.user.userPwdConfirm) {
            alert('两次密码输入不一致');
            return;
        }
        
        // 验证邮箱
        if (!$scope.user.userEmail) {
            alert('请输入邮箱');
            return;
        }
        
        var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test($scope.user.userEmail)) {
            alert('邮箱格式不正确');
            return;
        }
        
        // 验证手机号
        if (!$scope.user.userPhone) {
            alert('请输入手机号');
            return;
        }
        
        var phoneRegex = /^1[3-9]\d{9}$/;
        if (!phoneRegex.test($scope.user.userPhone)) {
            alert('手机号格式不正确');
            return;
        }
        
        // 验证年龄
        if ($scope.user.userAge) {
            if ($scope.user.userAge < 1 || $scope.user.userAge > 120) {
                alert('年龄必须在1-120之间');
                return;
            }
        }
        
        // 提交注册
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
    
    // 重置表单
    $scope.reset = function() {
        $scope.user = {
            userName: '',
            userPwd: '',
            userPwdConfirm: '',
            userEmail: '',
            userPhone: '',
            userSex: '男',
            userAge: ''
        };
    };
});
