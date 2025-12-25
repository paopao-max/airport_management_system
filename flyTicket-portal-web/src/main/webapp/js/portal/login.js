/**
 * 登录页面AngularJS控制器
 */
var app = angular.module('portalApp', []);

app.controller('loginController', function($scope, $http, $window) {
    $scope.user = {
        userName: '',
        userPwd: ''
    };
    
    // 登录
    $scope.login = function() {
        if (!$scope.user.userName) {
            alert('请输入用户名');
            return;
        }
        
        if (!$scope.user.userPwd) {
            alert('请输入密码');
            return;
        }
        
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
    
    // 回车登录
    $scope.handleKeyPress = function(event) {
        if (event.keyCode === 13) {
            $scope.login();
        }
    };
});
