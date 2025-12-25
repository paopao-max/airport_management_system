/**
 * 订单列表页面AngularJS控制器
 */
var app = angular.module('portalApp', []);

app.controller('orderListController', function($scope, $http, $window) {
    $scope.orders = [];
    $scope.currentUser = null;
    
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
                $window.location.href = '/flyTicket-portal-web/portal/toLogin';
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
                    console.log('加载订单失败：' + response.data.message);
                }
            },
            function(error) {
                console.log('加载订单失败', error);
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
    
    // 获取舱位名称
    $scope.getGradeName = function(grade) {
        var gradeMap = {
            '1': '头等舱',
            '2': '商务舱',
            '3': '经济舱'
        };
        return gradeMap[grade] || '经济舱';
    };
    
    // 获取订单状态
    $scope.getOrderStatus = function(status) {
        var statusMap = {
            '0': '待支付',
            '1': '已支付',
            '2': '已取消'
        };
        return statusMap[status] || '未知';
    };
    
    // 获取订单状态样式
    $scope.getStatusClass = function(status) {
        var classMap = {
            '0': 'status-pending',
            '1': 'status-paid',
            '2': 'status-cancelled'
        };
        return classMap[status] || '';
    };
    
    // 返回首页
    $scope.backToIndex = function() {
        $window.location.href = '/flyTicket-portal-web/portal/index';
    };
    
    // 退出登录
    $scope.logout = function() {
        if (confirm('确定要退出登录吗？')) {
            $http.get('/flyTicket-portal-web/portal/logout').then(
                function(response) {
                    $window.location.href = '/flyTicket-portal-web/portal/index';
                },
                function(error) {
                    console.log('退出登录失败', error);
                }
            );
        }
    };
    
    // 初始化
    $scope.checkLogin();
});
