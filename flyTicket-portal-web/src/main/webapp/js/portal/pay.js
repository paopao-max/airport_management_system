/**
 * 支付页面AngularJS控制器
 */
var app = angular.module('portalApp', []);

app.controller('payController', function($scope, $http, $window) {
    $scope.order = null;
    $scope.selectedMethod = 'alipay';
    
    // 加载订单信息
    $scope.loadOrder = function() {
        $http.get('/flyTicket-portal-web/portal/getCurrentOrder').then(
            function(response) {
                if (response.data.success) {
                    $scope.order = response.data.data;
                } else {
                    alert('加载订单信息失败：' + response.data.message);
                    $window.location.href = '/flyTicket-portal-web/portal/index';
                }
            },
            function(error) {
                console.log('加载订单信息失败', error);
                alert('加载订单信息失败');
                $window.location.href = '/flyTicket-portal-web/portal/index';
            }
        );
    };
    
    // 选择支付方式
    $scope.selectMethod = function(method) {
        $scope.selectedMethod = method;
    };
    
    // 支付
    $scope.pay = function() {
        if (!$scope.order) {
            alert('订单信息不存在');
            return;
        }
        
        if (confirm('确认支付 ¥' + $scope.order.price + ' 吗？')) {
            // 模拟支付成功
            $http.post('/flyTicket-portal-web/portal/pay', {}).then(
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
    
    // 取消订单
    $scope.cancelOrder = function() {
        if (confirm('确定要取消订单吗？')) {
            $http.post('/flyTicket-portal-web/portal/cancelOrder', {}).then(
                function(response) {
                    if (response.data.success) {
                        alert('订单已取消');
                        $window.location.href = '/flyTicket-portal-web/portal/index';
                    } else {
                        alert('取消订单失败：' + response.data.message);
                    }
                },
                function(error) {
                    console.log('取消订单失败', error);
                    alert('取消订单失败，请稍后重试');
                }
            );
        }
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
    
    // 初始化
    $scope.loadOrder();
});
